import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as d;
import 'data/database/app_database.dart';
import 'domain/engine/draft_engine.dart';
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: DraftHomeScreen(db: db),
    );
  }
}

class DraftHomeScreen extends StatefulWidget {
  final AppDatabase db;
  const DraftHomeScreen({super.key, required this.db});

  @override
  State<DraftHomeScreen> createState() => _DraftHomeScreenState();
}

class _DraftHomeScreenState extends State<DraftHomeScreen> {
  late final CloudSyncService _syncService;
  List<RankedPlayer> _rankedPlayers = [];
  bool _isLoading = false;

  // Mutable scoring and risk factors
  double _ppr = 1.0;
  double _injuryWeight = 0.5;
  double _crimeWeight = 0.8;
  double _teamWeight = 0.5;

  @override
  void initState() {
    super.initState();
    _syncService = CloudSyncService(widget.db);
    _refreshRankings();
  }

  LeagueSettings get _leagueSettings => LeagueSettings(ppr: _ppr);

  CustomWeights get _customWeights => CustomWeights(
        injuryWeight: _injuryWeight,
        crimeWeight: _crimeWeight,
        teamWeight: _teamWeight,
      );

  Future<void> _refreshRankings() async {
    final all = await widget.db.select(widget.db.players).get();
    final ranked = DraftEngine.calculateVorp(all, _leagueSettings, _customWeights);
    setState(() => _rankedPlayers = ranked);
  }

  Future<void> _triggerSync() async {
    setState(() => _isLoading = true);
    await _syncService.syncData();
    await _refreshRankings();
    setState(() => _isLoading = false);
  }

  Future<void> _draftPlayer(Player p) async {
    await (widget.db.update(widget.db.players)..where((tbl) => tbl.id.equals(p.id)))
        .write(const PlayersCompanion(isDrafted: d.Value<bool>(true)));
    await _refreshRankings();
  }

  Future<void> _resetDraft() async {
    await widget.db.customUpdate('UPDATE players SET is_drafted = 0');
    await _refreshRankings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draft Dominator (VORP Engine)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt),
            tooltip: 'Reset Drafted Picks',
            onPressed: _resetDraft,
          ),
          _isLoading
              ? const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.sync),
                  tooltip: 'Sync Projections',
                  onPressed: _triggerSync,
                ),
          Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.tune),
              tooltip: 'Risk & Scoring Settings',
              onPressed: () => Scaffold.of(ctx).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Text(
                'Scoring & Risk Sliders',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text('League PPR: ${_ppr.toStringAsFixed(1)} pt'),
              Slider(
                value: _ppr,
                min: 0.0,
                max: 2.0,
                divisions: 4,
                label: '$_ppr PPR',
                onChanged: (val) {
                  setState(() => _ppr = val);
                  _refreshRankings();
                },
              ),
              const Divider(),
              Text('Injury Fade Sensitivity: ${(_injuryWeight * 100).toInt()}%'),
              Slider(
                value: _injuryWeight,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: '${(_injuryWeight * 100).toInt()}%',
                onChanged: (val) {
                  setState(() => _injuryWeight = val);
                  _refreshRankings();
                },
              ),
              const Divider(),
              Text('Crime / Suspension Fade: ${(_crimeWeight * 100).toInt()}%'),
              Slider(
                value: _crimeWeight,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: '${(_crimeWeight * 100).toInt()}%',
                onChanged: (val) {
                  setState(() => _crimeWeight = val);
                  _refreshRankings();
                },
              ),
              const Divider(),
              Text('Offensive Talent Multiplier: ${(_teamWeight * 100).toInt()}%'),
              Slider(
                value: _teamWeight,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: '${(_teamWeight * 100).toInt()}%',
                onChanged: (val) {
                  setState(() => _teamWeight = val);
                  _refreshRankings();
                },
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _triggerSync,
        child: _rankedPlayers.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No undrafted players found in SQLite.'),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.restart_alt),
                      label: const Text('Reset Board'),
                      onPressed: _resetDraft,
                    )
                  ],
                ),
              )
            : ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _rankedPlayers.length,
                separatorBuilder: (context, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = _rankedPlayers[index];
                  final p = item.player;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: p.position == 'RB'
                          ? Colors.blue.shade900
                          : p.position == 'WR'
                              ? Colors.green.shade900
                              : p.position == 'TE'
                                  ? Colors.amber.shade900
                                  : Colors.purple.shade900,
                      child: Text(
                        p.position,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      '${p.name} (${p.nflTeam})',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'VORP: +${item.vorp.toStringAsFixed(1)} | VONA: +${item.vona.toStringAsFixed(1)} | Proj: ${item.adjustedPts.toStringAsFixed(1)} pts | Age: ${p.age}',
                    ),
                    trailing: ElevatedButton(
                      child: const Text('Draft'),
                      onPressed: () => _draftPlayer(p),
                    ),
                  );
                },
              ),
      ),
    );
  }
}