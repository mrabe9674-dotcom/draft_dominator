import 'package:flutter/material.dart';
import 'data/database/app_database.dart';
import 'services/cloud_sync_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  runApp(DraftDominatorApp(db: db));
}

class DraftDominatorApp extends StatelessWidget {
  final AppDatabase db;
  const DraftDominatorApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draft Dominator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF140D0C),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6750A4),
          surface: Color(0xFF1E1716),
        ),
      ),
      home: DraftBoardPage(db: db),
    );
  }
}

class DraftBoardPage extends StatefulWidget {
  final AppDatabase db;
  const DraftBoardPage({super.key, required this.db});

  @override
  State<DraftBoardPage> createState() => _DraftBoardPageState();
}

class RankedPlayer {
  final Player player;
  final double projPoints;
  final double vorp;
  final double vona;

  RankedPlayer({
    required this.player,
    required this.projPoints,
    required this.vorp,
    required this.vona,
  });
}

class _DraftBoardPageState extends State<DraftBoardPage> {
  late final CloudSyncService _syncService;
  final Set<int> _draftedPlayerIds = {};
  String _selectedPosition = 'ALL';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _syncService = CloudSyncService(widget.db);
    _initializeData();
  }

  Future<void> _initializeData() async {
    final count = await widget.db.select(widget.db.players).get();
    if (count.isEmpty) {
      await _sync();
    }
  }

  Future<void> _sync() async {
    setState(() => _isLoading = true);
    try {
      await _syncService.syncData();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _resetDraft() {
    setState(() {
      _draftedPlayerIds.clear();
    });
  }

  // Fantasy scoring baseline (Half-PPR with injury/risk multiplier)
  double _calculateFantasyPoints(Player p) {
    final passPts = (p.projPassYds * 0.04) + (p.projPassTds * 4.0);
    final rushPts = (p.projRushYds * 0.1) + (p.projRushTds * 6.0);
    final recPts = (p.projRec * 0.5) + (p.projRecYds * 0.1) + (p.projRecTds * 6.0);
    final basePts = passPts + rushPts + recPts;

    final injuryMultiplier = 1.0 - (p.injuryRisk * 0.5);
    return basePts * injuryMultiplier * p.teamTalentScore;
  }

  // Tier cliff color coding based on VONA drop-off to the next replacement tier
  Color _getTierCliffColor(double vona) {
    if (vona >= 20.0) return const Color(0xFFFF5252); // Critical cliff (Red): large talent drop
    if (vona >= 8.0) return const Color(0xFFFFB74D);  // Moderate drop (Orange/Amber)
    return const Color(0xFF81C784);                   // Flat tier (Green): safe to wait
  }

  Color _getPositionBadgeColor(String position) {
    switch (position) {
      case 'QB':
        return const Color(0xFF6A1B9A); // Deep Purple
      case 'RB':
        return const Color(0xFF1565C0); // Royal Blue
      case 'WR':
        return const Color(0xFF2E7D32); // Forest Green
      case 'TE':
        return const Color(0xFFD84315); // Rust Orange
      default:
        return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draft Dominator (VORP Engine)'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt),
            tooltip: 'Reset Drafted Players',
            onPressed: _resetDraft,
          ),
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Sync Live Data',
            onPressed: _sync,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<Player>>(
              stream: widget.db.select(widget.db.players).watch(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final allPlayers = snapshot.data!;
                final availablePlayers = allPlayers
                    .where((p) => !_draftedPlayerIds.contains(p.id))
                    .toList();

                // 1. Group available players by position and sort descending by points
                final Map<String, List<MapEntry<Player, double>>> posGroups = {
                  'QB': [],
                  'RB': [],
                  'WR': [],
                  'TE': [],
                };

                for (final p in availablePlayers) {
                  final pts = _calculateFantasyPoints(p);
                  if (posGroups.containsKey(p.position)) {
                    posGroups[p.position]!.add(MapEntry(p, pts));
                  }
                }

                for (final key in posGroups.keys) {
                  posGroups[key]!.sort((a, b) => b.value.compareTo(a.value));
                }

                // 2. Compute VORP and VONA baselines
                // 12-team baseline: QB: 12th, RB: 24th, WR: 30th, TE: 12th
                const Map<String, int> vorpBaselines = {
                  'QB': 12,
                  'RB': 24,
                  'WR': 30,
                  'TE': 12,
                };

                final Map<String, double> replacementPoints = {};
                for (final entry in vorpBaselines.entries) {
                  final list = posGroups[entry.key] ?? [];
                  if (list.isEmpty) {
                    replacementPoints[entry.key] = 0.0;
                  } else if (list.length >= entry.value) {
                    replacementPoints[entry.key] = list[entry.value - 1].value;
                  } else {
                    replacementPoints[entry.key] = list.last.value;
                  }
                }

                // 3. Assemble ranked roster
                final List<RankedPlayer> ranked = [];
                for (final entry in posGroups.entries) {
                  final pos = entry.key;
                  final list = entry.value;
                  final repPts = replacementPoints[pos] ?? 0.0;

                  for (int i = 0; i < list.length; i++) {
                    final p = list[i].key;
                    final pts = list[i].value;
                    final vorp = (pts - repPts).clamp(0.0, 999.0);

                    // VONA: Gap between this player and the next available player at this position
                    final nextPts = (i + 1 < list.length) ? list[i + 1].value : repPts;
                    final vona = (pts - nextPts).clamp(0.0, 999.0);

                    ranked.add(RankedPlayer(
                      player: p,
                      projPoints: pts,
                      vorp: vorp,
                      vona: vona,
                    ));
                  }
                }

                // Sort overall draft board by VORP descending
                ranked.sort((a, b) => b.vorp.compareTo(a.vorp));

                // 4. Apply position filter
                final filtered = _selectedPosition == 'ALL'
                    ? ranked
                    : ranked.where((r) => r.player.position == _selectedPosition).toList();

                return Column(
                  children: [
                    // Position Filter Selector Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: ['ALL', 'QB', 'RB', 'WR', 'TE'].map((pos) {
                            final isSelected = _selectedPosition == pos;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ChoiceChip(
                                label: Text(pos),
                                selected: isSelected,
                                selectedColor: const Color(0xFF6750A4),
                                labelStyle: TextStyle(
                                  color: isSelected ? Colors.white : Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                                onSelected: (_) {
                                  setState(() {
                                    _selectedPosition = pos;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const Divider(height: 1, color: Colors.white12),
                    // Player List
                    Expanded(
                      child: ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1, color: Colors.white12),
                        itemBuilder: (context, index) {
                          final item = filtered[index];
                          final p = item.player;
                          final cliffColor = _getTierCliffColor(item.vona);

                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 4.0,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: _getPositionBadgeColor(p.position),
                              child: Text(
                                p.position,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              '${p.name} (${p.nflTeam})',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  'VORP: +${item.vorp.toStringAsFixed(1)} | ',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                    vertical: 2.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: cliffColor.withValues(alpha: 0.18),
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                      color: cliffColor.withValues(alpha: 0.6),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    'VONA: +${item.vona.toStringAsFixed(1)}',
                                    style: TextStyle(
                                      color: cliffColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Text(
                                  ' | Proj: ${item.projPoints.toStringAsFixed(1)} pts | Age: ${p.age}',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2C2220),
                                foregroundColor: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _draftedPlayerIds.add(p.id);
                                });
                              },
                              child: const Text('Draft'),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}