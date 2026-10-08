import 'dart:math';
import 'package:flutter/material.dart';
import 'data/database/app_database.dart';
import 'services/cloud_sync_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  runApp(OnTheClockApp(db: db));
}

// Compatibility alias so any lingering references never throw an error
typedef DraftDominatorApp = OnTheClockApp;

class OnTheClockApp extends StatelessWidget {
  final AppDatabase db;
  const OnTheClockApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'On The Clock - Fantasy Football Draft Tool',
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

enum DraftType { snake, linear }
enum SortMetric { vorp, vona, projPoints, priorYear }

class KeeperSelection {
  final Player player;
  final int teamIndex;
  final int forfeitRound;

  KeeperSelection({
    required this.player,
    required this.teamIndex,
    required this.forfeitRound,
  });

  String getTeamName(LeagueSettings settings) => settings.teamNames[teamIndex];

  int getRoundPick(LeagueSettings settings) =>
      settings.getRoundPickForTeam(teamIndex, forfeitRound);

  int getOverallPick(LeagueSettings settings) =>
      settings.calculateOverallPick(forfeitRound, getRoundPick(settings));
}

class LeagueSettings {
  String leagueName;
  int numTeams;
  int numRounds;
  List<String> teamNames;
  int myTeamIndex;
  DraftType draftType;
  List<int> draftOrder;

  // Starting Lineup Requirements
  int startQb;
  int startRb;
  int startWr;
  int startTe;
  int startFlex;
  int startK;
  int startDst;

  // Positional Draft Quotas
  int minQb;
  int minRb;
  int minWr;
  int minTe;
  int minK;
  int minDst;

  // Passing Scoring
  double passTdPoints;
  double passTd50PlusBonus;
  double passTd75PlusBonus;
  double passIntPoints;
  double pass2PtPoints;
  double passYdsTierPts;
  double pass250Bonus;
  double pass450Bonus;

  // Rushing Scoring
  double rushTdPoints;
  double rushTd50PlusBonus;
  double rushTd75PlusBonus;
  double rush2PtPoints;
  double rushYdsTierPts;
  double rush100Bonus;
  double rush200Bonus;
  double rush300Bonus;

  // Receiving Scoring
  double ppr;
  double tePremium;
  double recTdPoints;
  double recTd50PlusBonus;
  double recTd75PlusBonus;
  double rec2PtPoints;
  double recYdsTierPts;
  double rec100Bonus;
  double rec200Bonus;
  double rec300Bonus;

  // Kicking Scoring
  double fgBasePoints;
  double fg40Bonus;
  double fg50Bonus;
  double fg60Bonus;
  double xpPoints;

  // D/ST Scoring
  double sackPoints;
  double intPoints;
  double fumbleRecPoints;
  double safetyPoints;
  double blockedKickPoints;
  double defTdPoints;
  double pa0Points;
  double pa2to3Points;
  double pa4to6Points;
  double pa7to9Points;
  double pa10to12Points;

  LeagueSettings({
    this.leagueName = 'Fantasy Championship League',
    this.numTeams = 12,
    this.numRounds = 16,
    List<String>? teamNames,
    this.myTeamIndex = 0,
    this.draftType = DraftType.snake,
    List<int>? draftOrder,
    this.startQb = 1,
    this.startRb = 2,
    this.startWr = 2,
    this.startTe = 1,
    this.startFlex = 1,
    this.startK = 1,
    this.startDst = 1,
    this.minQb = 2,
    this.minRb = 4,
    this.minWr = 4,
    this.minTe = 2,
    this.minK = 1,
    this.minDst = 1,
    this.passTdPoints = 4.0,
    this.passTd50PlusBonus = 3.0,
    this.passTd75PlusBonus = 6.0,
    this.passIntPoints = -2.0,
    this.pass2PtPoints = 2.0,
    this.passYdsTierPts = 2.0,
    this.pass250Bonus = 8.0,
    this.pass450Bonus = 8.0,
    this.rushTdPoints = 6.0,
    this.rushTd50PlusBonus = 3.0,
    this.rushTd75PlusBonus = 6.0,
    this.rush2PtPoints = 2.0,
    this.rushYdsTierPts = 2.0,
    this.rush100Bonus = 8.0,
    this.rush200Bonus = 8.0,
    this.rush300Bonus = 6.0,
    this.ppr = 0.0,
    this.tePremium = 0.0,
    this.recTdPoints = 6.0,
    this.recTd50PlusBonus = 3.0,
    this.recTd75PlusBonus = 6.0,
    this.rec2PtPoints = 2.0,
    this.recYdsTierPts = 2.0,
    this.rec100Bonus = 8.0,
    this.rec200Bonus = 8.0,
    this.rec300Bonus = 6.0,
    this.fgBasePoints = 3.0,
    this.fg40Bonus = 2.0,
    this.fg50Bonus = 3.0,
    this.fg60Bonus = 4.0,
    this.xpPoints = 1.0,
    this.sackPoints = 2.0,
    this.intPoints = 3.0,
    this.fumbleRecPoints = 3.0,
    this.safetyPoints = 8.0,
    this.blockedKickPoints = 3.0,
    this.defTdPoints = 6.0,
    this.pa0Points = 12.0,
    this.pa2to3Points = 8.0,
    this.pa4to6Points = 6.0,
    this.pa7to9Points = 4.0,
    this.pa10to12Points = 2.0,
  })  : teamNames = teamNames ??
            List.generate(
              16,
              (i) => i == 0 ? 'My Roster' : 'Team ${i + 1}',
            ),
        draftOrder = draftOrder ?? List.generate(16, (i) => i);

  int get totalStarters =>
      startQb + startRb + startWr + startTe + startFlex + startK + startDst;

  int get totalQuotas => minQb + minRb + minWr + minTe + minK + minDst;

  int getTeamIndexForPick(int overallPick) {
    if (numTeams == 0) return 0;
    final int pick0 = overallPick - 1;
    final int round0 = pick0 ~/ numTeams;
    final int roundPick0 = pick0 % numTeams;

    if (draftType == DraftType.snake && (round0 % 2 == 1)) {
      final int reversedSlot = (numTeams - 1) - roundPick0;
      return draftOrder[reversedSlot];
    }
    return draftOrder[roundPick0];
  }

  int getRoundPickForTeam(int teamIdx, int round) {
    final int slot0 = draftOrder.indexOf(teamIdx);
    if (slot0 == -1) return 1;
    if (draftType == DraftType.snake && (round % 2 == 0)) {
      return numTeams - slot0;
    }
    return slot0 + 1;
  }

  int calculateOverallPick(int round, int roundPick) {
    return ((round - 1) * numTeams) + roundPick;
  }
}

class DraftPickRecord {
  final int pickNumber;
  final Player player;
  final String draftedByTeam;
  final bool isMyTeam;
  final bool isKeeper;

  DraftPickRecord({
    required this.pickNumber,
    required this.player,
    required this.draftedByTeam,
    required this.isMyTeam,
    this.isKeeper = false,
  });
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

class DraftBoardPage extends StatefulWidget {
  final AppDatabase db;
  const DraftBoardPage({super.key, required this.db});

  @override
  State<DraftBoardPage> createState() => _DraftBoardPageState();
}

class _DraftBoardPageState extends State<DraftBoardPage> {
  late final CloudSyncService _syncService;
  final List<DraftPickRecord> _draftHistory = [];
  final List<KeeperSelection> _keepers = [];
  final Set<int> _targetPlayerIds = {};
  final Set<int> _fadePlayerIds = {};

  final LeagueSettings _settings = LeagueSettings();
  String _selectedPosition = 'ALL';
  SortMetric _selectedSort = SortMetric.vorp;
  bool _filterTargetsOnly = false;
  bool _hideFadedPlayers = false;
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

  Set<int> get _draftedPlayerIds =>
      _draftHistory.map((pick) => pick.player.id).toSet();

  List<Player> get _myRoster =>
      _draftHistory.where((pick) => pick.isMyTeam).map((pick) => pick.player).toList();

  String get _myTeamName => _settings.teamNames[_settings.myTeamIndex];

  int get _currentPickNumber => _draftHistory.length + 1;
  int get _currentRound => ((_currentPickNumber - 1) ~/ _settings.numTeams) + 1;
  int get _currentRoundPick => ((_currentPickNumber - 1) % _settings.numTeams) + 1;
  bool get _isDraftComplete => _draftHistory.length >= (_settings.numTeams * _settings.numRounds);

  String get _onTheClockTeamName {
    if (_isDraftComplete) return 'Draft Complete';
    final int teamIdx = _settings.getTeamIndexForPick(_currentPickNumber);
    return _settings.teamNames[teamIdx];
  }

  bool get _isMyTurn {
    if (_isDraftComplete) return false;
    final int teamIdx = _settings.getTeamIndexForPick(_currentPickNumber);
    return teamIdx == _settings.myTeamIndex;
  }

  void _checkAndTriggerKeeper() {
    if (_isDraftComplete) return;
    final match = _keepers
        .where((k) => k.getOverallPick(_settings) == _currentPickNumber)
        .toList();
    if (match.isNotEmpty) {
      final keeper = match.first;
      _recordPick(keeper.player, keeper.getTeamName(_settings), isKeeper: true);
    }
  }

  void _recordPick(Player player, String teamName, {bool isKeeper = false}) {
    setState(() {
      _draftHistory.add(
        DraftPickRecord(
          pickNumber: _draftHistory.length + 1,
          player: player,
          draftedByTeam: teamName,
          isMyTeam: teamName == _myTeamName,
          isKeeper: isKeeper,
        ),
      );
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAndTriggerKeeper());
  }

  void _undoToPick(int targetPickNumber) {
    setState(() {
      _draftHistory.removeWhere((pick) => pick.pickNumber >= targetPickNumber);
    });
  }

  void _resetFullDraft() {
    setState(() {
      _draftHistory.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAndTriggerKeeper());
  }

  double _calculateFantasyPoints(Player p) {
    double total = 0.0;
    const double games = 17.0;

    if (p.position == 'K') {
      total += (p.projFgMade * _settings.fgBasePoints);
      total += (p.projFg50Plus * _settings.fg50Bonus);
      total += (p.projPatMade * _settings.xpPoints);
    } else if (p.position == 'DST') {
      total += (p.projSacks * _settings.sackPoints);
      total += (p.projTakeaways * _settings.intPoints);
      total += (p.projDefTds * _settings.defTdPoints);
      total += (p.projPtsAllowedBaseline > 0
          ? p.projPtsAllowedBaseline
          : (_settings.pa4to6Points * games));
    } else {
      final perGamePassYds = p.projPassYds / games;
      int passTiers = (perGamePassYds / 50.0).floor();
      if (passTiers > 12) passTiers = 12;
      double passYdsPts = passTiers * _settings.passYdsTierPts;
      if (perGamePassYds >= 250.0) passYdsPts += _settings.pass250Bonus;
      if (perGamePassYds >= 450.0) passYdsPts += _settings.pass450Bonus;
      total += (passYdsPts * games);
      total += (p.projPassTds * _settings.passTdPoints);
      total += (p.projPassInts * _settings.passIntPoints);

      final perGameRushYds = p.projRushYds / games;
      int rushTiers = (perGameRushYds / 25.0).floor();
      if (rushTiers > 13) rushTiers = 13;
      double rushYdsPts = rushTiers * _settings.rushYdsTierPts;
      if (perGameRushYds >= 100.0) rushYdsPts += _settings.rush100Bonus;
      if (perGameRushYds >= 200.0) rushYdsPts += _settings.rush200Bonus;
      if (perGameRushYds >= 300.0) rushYdsPts += _settings.rush300Bonus;
      total += (rushYdsPts * games);
      total += (p.projRushTds * _settings.rushTdPoints);

      final perGameRecYds = p.projRecYds / games;
      int recTiers = (perGameRecYds / 25.0).floor();
      if (recTiers > 13) recTiers = 13;
      double recYdsPts = recTiers * _settings.recYdsTierPts;
      if (perGameRecYds >= 100.0) recYdsPts += _settings.rec100Bonus;
      if (perGameRecYds >= 200.0) recYdsPts += _settings.rec200Bonus;
      if (perGameRecYds >= 300.0) recYdsPts += _settings.rec300Bonus;
      total += (recYdsPts * games);
      total += (p.projRecTds * _settings.recTdPoints);

      final recPerCatch = _settings.ppr + (p.position == 'TE' ? _settings.tePremium : 0.0);
      total += (p.projRec * recPerCatch);
    }

    final injuryMultiplier = 1.0 - (p.injuryRisk * 0.5);
    return total * injuryMultiplier * p.teamTalentScore;
  }

  double _getQuotaScarcityMultiplier(String pos) {
    int draftedCount = _myRoster.where((p) => p.position == pos).length;
    int targetMin = 0;
    switch (pos) {
      case 'QB':
        targetMin = _settings.minQb;
        break;
      case 'RB':
        targetMin = _settings.minRb;
        break;
      case 'WR':
        targetMin = _settings.minWr;
        break;
      case 'TE':
        targetMin = _settings.minTe;
        break;
      case 'K':
        targetMin = _settings.minK;
        break;
      case 'DST':
        targetMin = _settings.minDst;
        break;
    }

    if (targetMin <= 0) return 1.0;
    int remainingNeeded = targetMin - draftedCount;
    if (remainingNeeded <= 0) return 0.95;

    int remainingRounds = _settings.numRounds - _draftHistory.where((p) => p.isMyTeam).length;
    if (remainingRounds <= 0) remainingRounds = 1;

    double pressure = remainingNeeded / remainingRounds;
    return 1.0 + (pressure * 0.4).clamp(0.0, 0.6);
  }

  Color _getTierCliffColor(double vona) {
    if (vona >= 20.0) return const Color(0xFFFF5252);
    if (vona >= 8.0) return const Color(0xFFFFB74D);
    return const Color(0xFF81C784);
  }

  Color _getPositionBadgeColor(String position) {
    switch (position) {
      case 'QB':
        return const Color(0xFF6A1B9A);
      case 'RB':
        return const Color(0xFF1565C0);
      case 'WR':
        return const Color(0xFF2E7D32);
      case 'TE':
        return const Color(0xFFD84315);
      case 'K':
        return const Color(0xFF00838F);
      case 'DST':
        return const Color(0xFF4E342E);
      default:
        return Colors.grey.shade700;
    }
  }

  void _showKeepersDialog(List<Player> allPlayers) {
    int selectedTeamIdx = 0;
    int forfeitRound = 1;
    Player? chosenPlayer;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          final availablePlayers = allPlayers
              .where((p) => !_keepers.any((k) => k.player.id == p.id))
              .toList();
          chosenPlayer ??= availablePlayers.isNotEmpty ? availablePlayers.first : null;

          final lockedRoundPick = _settings.getRoundPickForTeam(selectedTeamIdx, forfeitRound);
          final lockedOverallPick = _settings.calculateOverallPick(forfeitRound, lockedRoundPick);

          return AlertDialog(
            backgroundColor: const Color(0xFF1E1716),
            title: const Row(
              children: [
                Icon(Icons.bookmark_added, color: Colors.amberAccent),
                SizedBox(width: 8),
                Text('Manage Pre-Draft Keepers'),
              ],
            ),
            content: SizedBox(
              width: 600,
              height: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2220),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add Keeper & Auto-Locked Forfeited Slot:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.amberAccent),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<int>(
                                initialValue: selectedTeamIdx,
                                decoration: const InputDecoration(labelText: 'Team', isDense: true),
                                dropdownColor: const Color(0xFF2C2220),
                                items: List.generate(_settings.numTeams, (i) {
                                  return DropdownMenuItem(value: i, child: Text(_settings.teamNames[i]));
                                }),
                                onChanged: (v) {
                                  if (v != null) setDialogState(() => selectedTeamIdx = v);
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 3,
                              child: DropdownButtonFormField<Player>(
                                initialValue: chosenPlayer,
                                decoration: const InputDecoration(labelText: 'Player Kept', isDense: true),
                                dropdownColor: const Color(0xFF2C2220),
                                items: availablePlayers.map((p) {
                                  return DropdownMenuItem(value: p, child: Text('${p.name} (${p.position})'));
                                }).toList(),
                                onChanged: (v) {
                                  if (v != null) setDialogState(() => chosenPlayer = v);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<int>(
                                initialValue: forfeitRound,
                                decoration: const InputDecoration(labelText: 'Forfeit Round', isDense: true),
                                dropdownColor: const Color(0xFF2C2220),
                                items: List.generate(_settings.numRounds, (i) => i + 1).map((r) {
                                  return DropdownMenuItem(value: r, child: Text('Round $r'));
                                }).toList(),
                                onChanged: (v) {
                                  if (v != null) setDialogState(() => forfeitRound = v);
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF140D0C),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: Colors.white24),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Locked Pick Slot', style: TextStyle(fontSize: 10, color: Colors.white54)),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Pick #$lockedRoundPick (Overall #$lockedOverallPick)',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.greenAccent),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6750A4),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                              ),
                              icon: const Icon(Icons.add, size: 16),
                              label: const Text('Assign'),
                              onPressed: chosenPlayer == null
                                  ? null
                                  : () {
                                      setState(() {
                                        _keepers.add(KeeperSelection(
                                          player: chosenPlayer!,
                                          teamIndex: selectedTeamIdx,
                                          forfeitRound: forfeitRound,
                                        ));
                                      });
                                      setDialogState(() {
                                        chosenPlayer = null;
                                      });
                                    },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Active Pre-Draft Keepers:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 6),
                  Expanded(
                    child: _keepers.isEmpty
                        ? const Center(child: Text('No keepers assigned yet.', style: TextStyle(color: Colors.white54)))
                        : ListView.separated(
                            itemCount: _keepers.length,
                            separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.white12),
                            itemBuilder: (context, idx) {
                              final k = _keepers[idx];
                              final roundPick = k.getRoundPick(_settings);
                              final overallPick = k.getOverallPick(_settings);

                              return ListTile(
                                dense: true,
                                leading: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: _getPositionBadgeColor(k.player.position),
                                  child: Text(k.player.position, style: const TextStyle(fontSize: 10, color: Colors.white)),
                                ),
                                title: Text('${k.player.name} → ${k.getTeamName(_settings)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                  'Forfeits Round ${k.forfeitRound}, Pick #$roundPick (Overall #$overallPick)',
                                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 18),
                                  onPressed: () {
                                    setDialogState(() {
                                      setState(() {
                                        _keepers.removeAt(idx);
                                      });
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Close'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDraftSelectionDialog(Player player) {
    final defaultTeam = _isDraftComplete ? _myTeamName : _onTheClockTeamName;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1716),
        title: Text('Draft ${player.name} (${player.position})'),
        content: SizedBox(
          width: 440,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pick #$_currentPickNumber (Round $_currentRound, Pick $_currentRoundPick)',
                style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'On The Clock: $defaultTeam',
                style: const TextStyle(color: Colors.white70),
              ),
              const Divider(color: Colors.white24, height: 20),
              const Text('Confirm or override drafting team:', style: TextStyle(fontSize: 12, color: Colors.white60)),
              const SizedBox(height: 8),
              SizedBox(
                height: 240,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _settings.numTeams,
                  separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.white10),
                  itemBuilder: (context, idx) {
                    final tName = _settings.teamNames[idx];
                    final isOtC = tName == defaultTeam;
                    final isMine = idx == _settings.myTeamIndex;

                    return ListTile(
                      dense: true,
                      tileColor: isOtC ? const Color(0xFF6750A4).withValues(alpha: 0.18) : null,
                      leading: Icon(
                        isMine ? Icons.star : (isOtC ? Icons.alarm : Icons.shield_outlined),
                        color: isMine ? Colors.amber : (isOtC ? Colors.purpleAccent : Colors.white60),
                        size: 20,
                      ),
                      title: Text(
                        tName,
                        style: TextStyle(
                          color: isOtC ? Colors.amberAccent : Colors.white,
                          fontWeight: isOtC ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      subtitle: isOtC
                          ? const Text('On The Clock', style: TextStyle(color: Colors.purpleAccent, fontSize: 11))
                          : (isMine ? const Text('My Team', style: TextStyle(color: Colors.white54, fontSize: 11)) : null),
                      trailing: isOtC ? const Icon(Icons.check_circle, color: Colors.amberAccent, size: 18) : null,
                      onTap: () {
                        Navigator.pop(ctx);
                        _recordPick(player, tName);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.white60)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6750A4),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              _recordPick(player, defaultTeam);
            },
            child: Text('Draft to $defaultTeam'),
          ),
        ],
      ),
    );
  }

  void _showAllTeamsRostersDialog() {
    int activeViewerTeamIdx = _settings.myTeamIndex;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          final currentTeamName = _settings.teamNames[activeViewerTeamIdx];
          final teamPicks = _draftHistory.where((p) => p.draftedByTeam == currentTeamName).map((p) => p.player).toList();

          return AlertDialog(
            backgroundColor: const Color(0xFF1E1716),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('League Rosters Viewer'),
                DropdownButton<int>(
                  value: activeViewerTeamIdx,
                  dropdownColor: const Color(0xFF2C2220),
                  items: List.generate(_settings.numTeams, (i) {
                    final tName = _settings.teamNames[i];
                    return DropdownMenuItem(
                      value: i,
                      child: Text(
                        i == _settings.myTeamIndex ? '$tName (My Team)' : tName,
                        style: TextStyle(
                          color: i == _settings.myTeamIndex ? Colors.amberAccent : Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    );
                  }),
                  onChanged: (v) {
                    if (v != null) setDialogState(() => activeViewerTeamIdx = v);
                  },
                ),
              ],
            ),
            content: SizedBox(
              width: 540,
              height: 480,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2220),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(currentTeamName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text(
                          '${teamPicks.length} / ${_settings.numRounds} Players Drafted',
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      children: ['QB', 'RB', 'WR', 'TE', 'K', 'DST'].map((pos) {
                        final posPlayers = teamPicks.where((p) => p.position == pos).toList();
                        return Card(
                          color: const Color(0xFF140D0C),
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('$pos (${posPlayers.length})',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: _getPositionBadgeColor(pos),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                if (posPlayers.isEmpty)
                                  const Text('None', style: TextStyle(color: Colors.white38, fontSize: 11, fontStyle: FontStyle.italic))
                                else
                                  Wrap(
                                    spacing: 6.0,
                                    runSpacing: 4.0,
                                    children: posPlayers.map((p) {
                                      return Chip(
                                        backgroundColor: _getPositionBadgeColor(pos).withValues(alpha: 0.25),
                                        label: Text(
                                          '${p.name} (${p.nflTeam})',
                                          style: const TextStyle(fontSize: 11, color: Colors.white),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Close'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showHistoryAndRollbackDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1716),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Draft History & Rollback'),
            TextButton.icon(
              icon: const Icon(Icons.restart_alt, color: Colors.redAccent),
              label: const Text('Reset All', style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                Navigator.pop(ctx);
                _resetFullDraft();
              },
            ),
          ],
        ),
        content: SizedBox(
          width: 520,
          height: 400,
          child: _draftHistory.isEmpty
              ? const Center(
                  child: Text('No picks have been made yet.', style: TextStyle(color: Colors.white60)),
                )
              : ListView.separated(
                  itemCount: _draftHistory.length,
                  separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.white12),
                  itemBuilder: (context, index) {
                    final pick = _draftHistory[index];
                    return ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 14,
                        backgroundColor: _getPositionBadgeColor(pick.player.position),
                        child: Text(
                          '#${pick.pickNumber}',
                          style: const TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                      title: Text(
                        '${pick.player.name} (${pick.player.position} - ${pick.player.nflTeam})${pick.isKeeper ? " [KEEPER]" : ""}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Drafted by: ${pick.draftedByTeam}',
                        style: TextStyle(
                          color: pick.isMyTeam ? Colors.greenAccent : Colors.white60,
                        ),
                      ),
                      trailing: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          side: const BorderSide(color: Colors.redAccent),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        ),
                        icon: const Icon(Icons.undo, size: 14),
                        label: const Text('Undo to Here', style: TextStyle(fontSize: 11)),
                        onPressed: () {
                          _undoToPick(pick.pickNumber);
                          Navigator.pop(ctx);
                        },
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog() {
    final leagueNameController = TextEditingController(text: _settings.leagueName);
    final teamControllers = List.generate(
      16,
      (i) => TextEditingController(text: _settings.teamNames[i]),
    );

    int tempTeams = _settings.numTeams;
    int tempRounds = _settings.numRounds;
    int tempMyTeamIndex = _settings.myTeamIndex;
    DraftType tempDraftType = _settings.draftType;
    List<int> tempDraftOrder = List<int>.from(_settings.draftOrder);

    // Roster Requirements Controllers
    final startQbCtrl = TextEditingController(text: _settings.startQb.toString());
    final startRbCtrl = TextEditingController(text: _settings.startRb.toString());
    final startWrCtrl = TextEditingController(text: _settings.startWr.toString());
    final startTeCtrl = TextEditingController(text: _settings.startTe.toString());
    final startFlexCtrl = TextEditingController(text: _settings.startFlex.toString());
    final startKCtrl = TextEditingController(text: _settings.startK.toString());
    final startDstCtrl = TextEditingController(text: _settings.startDst.toString());

    final minQbCtrl = TextEditingController(text: _settings.minQb.toString());
    final minRbCtrl = TextEditingController(text: _settings.minRb.toString());
    final minWrCtrl = TextEditingController(text: _settings.minWr.toString());
    final minTeCtrl = TextEditingController(text: _settings.minTe.toString());
    final minKCtrl = TextEditingController(text: _settings.minK.toString());
    final minDstCtrl = TextEditingController(text: _settings.minDst.toString());

    // Passing Controllers
    final passTdCtrl = TextEditingController(text: _settings.passTdPoints.toString());
    final passTd50Ctrl = TextEditingController(text: _settings.passTd50PlusBonus.toString());
    final passTd75Ctrl = TextEditingController(text: _settings.passTd75PlusBonus.toString());
    final passYdsTierCtrl = TextEditingController(text: _settings.passYdsTierPts.toString());
    final pass250Ctrl = TextEditingController(text: _settings.pass250Bonus.toString());
    final pass450Ctrl = TextEditingController(text: _settings.pass450Bonus.toString());
    final passIntCtrl = TextEditingController(text: _settings.passIntPoints.toString());

    // Rushing Controllers
    final rushTdCtrl = TextEditingController(text: _settings.rushTdPoints.toString());
    final rushTd50Ctrl = TextEditingController(text: _settings.rushTd50PlusBonus.toString());
    final rushTd75Ctrl = TextEditingController(text: _settings.rushTd75PlusBonus.toString());
    final rushYdsTierCtrl = TextEditingController(text: _settings.rushYdsTierPts.toString());
    final rush100Ctrl = TextEditingController(text: _settings.rush100Bonus.toString());
    final rush200Ctrl = TextEditingController(text: _settings.rush200Bonus.toString());
    final rush300Ctrl = TextEditingController(text: _settings.rush300Bonus.toString());

    // Receiving Controllers
    final recTdCtrl = TextEditingController(text: _settings.recTdPoints.toString());
    final recTd50Ctrl = TextEditingController(text: _settings.recTd50PlusBonus.toString());
    final recTd75Ctrl = TextEditingController(text: _settings.recTd75PlusBonus.toString());
    final recYdsTierCtrl = TextEditingController(text: _settings.recYdsTierPts.toString());
    final rec100Ctrl = TextEditingController(text: _settings.rec100Bonus.toString());
    final rec200Ctrl = TextEditingController(text: _settings.rec200Bonus.toString());
    final rec300Ctrl = TextEditingController(text: _settings.rec300Bonus.toString());
    final pprCtrl = TextEditingController(text: _settings.ppr.toString());

    // Kicking Controllers
    final fgBaseCtrl = TextEditingController(text: _settings.fgBasePoints.toString());
    final fg40Ctrl = TextEditingController(text: _settings.fg40Bonus.toString());
    final fg50Ctrl = TextEditingController(text: _settings.fg50Bonus.toString());
    final fg60Ctrl = TextEditingController(text: _settings.fg60Bonus.toString());
    final xpCtrl = TextEditingController(text: _settings.xpPoints.toString());

    // Defense Controllers
    final sackCtrl = TextEditingController(text: _settings.sackPoints.toString());
    final intCtrl = TextEditingController(text: _settings.intPoints.toString());
    final fumbleRecCtrl = TextEditingController(text: _settings.fumbleRecPoints.toString());
    final safetyCtrl = TextEditingController(text: _settings.safetyPoints.toString());
    final blockedKickCtrl = TextEditingController(text: _settings.blockedKickPoints.toString());
    final defTdCtrl = TextEditingController(text: _settings.defTdPoints.toString());
    final pa0Ctrl = TextEditingController(text: _settings.pa0Points.toString());
    final pa2to3Ctrl = TextEditingController(text: _settings.pa2to3Points.toString());
    final pa4to6Ctrl = TextEditingController(text: _settings.pa4to6Points.toString());
    final pa7to9Ctrl = TextEditingController(text: _settings.pa7to9Points.toString());
    final pa10to12Ctrl = TextEditingController(text: _settings.pa10to12Points.toString());

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return DefaultTabController(
            length: 4,
            child: AlertDialog(
              backgroundColor: const Color(0xFF1E1716),
              title: const TabBar(
                isScrollable: true,
                indicatorColor: Color(0xFF6750A4),
                tabs: [
                  Tab(icon: Icon(Icons.tune), text: 'League & Order'),
                  Tab(icon: Icon(Icons.people_outline), text: 'Roster Requirements'),
                  Tab(icon: Icon(Icons.sports_football), text: 'Offense & Kicking'),
                  Tab(icon: Icon(Icons.shield), text: 'Defense / Special Teams'),
                ],
              ),
              content: SizedBox(
                width: 650,
                height: 520,
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: leagueNameController,
                            decoration: const InputDecoration(
                              labelText: 'League Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<int>(
                                  initialValue: tempTeams,
                                  decoration: const InputDecoration(labelText: 'Teams'),
                                  dropdownColor: const Color(0xFF2C2220),
                                  items: [8, 10, 12, 14, 16]
                                      .map((t) => DropdownMenuItem(value: t, child: Text('$t Teams')))
                                      .toList(),
                                  onChanged: (v) {
                                    if (v != null) {
                                      setDialogState(() {
                                        tempTeams = v;
                                        if (tempMyTeamIndex >= v) tempMyTeamIndex = 0;
                                        tempDraftOrder = List.generate(v, (i) => i);
                                      });
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: DropdownButtonFormField<int>(
                                  initialValue: tempRounds,
                                  decoration: const InputDecoration(labelText: 'Draft Rounds (Total Roster Slots)'),
                                  dropdownColor: const Color(0xFF2C2220),
                                  items: [12, 14, 15, 16, 17, 18, 20]
                                      .map((r) => DropdownMenuItem(value: r, child: Text('$r Rounds')))
                                      .toList(),
                                  onChanged: (v) {
                                    if (v != null) setDialogState(() => tempRounds = v);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<DraftType>(
                                  initialValue: tempDraftType,
                                  decoration: const InputDecoration(labelText: 'Draft Format'),
                                  dropdownColor: const Color(0xFF2C2220),
                                  items: const [
                                    DropdownMenuItem(value: DraftType.snake, child: Text('Snake Draft (Alternating)')),
                                    DropdownMenuItem(value: DraftType.linear, child: Text('Linear Draft (Fixed 1-N)')),
                                  ],
                                  onChanged: (v) {
                                    if (v != null) setDialogState(() => tempDraftType = v);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                                  foregroundColor: Colors.amberAccent,
                                  side: const BorderSide(color: Colors.amberAccent),
                                ),
                                icon: const Icon(Icons.shuffle, size: 18),
                                label: const Text('Randomize Draft Order'),
                                onPressed: () {
                                  setDialogState(() {
                                    final list = List<int>.generate(tempTeams, (i) => i);
                                    list.shuffle(Random());
                                    tempDraftOrder = list;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Team Names & Round 1 Draft Slot (Click Radio to Set "My Team"):',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: tempTeams,
                            itemBuilder: (context, slotIdx) {
                              final teamIdx = tempDraftOrder[slotIdx];
                              final isMySquad = teamIdx == tempMyTeamIndex;

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 58,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2C2220),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: Colors.white24),
                                      ),
                                      child: Text('Slot ${slotIdx + 1}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        isMySquad ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                        color: isMySquad ? Colors.amberAccent : Colors.white60,
                                      ),
                                      onPressed: () {
                                        setDialogState(() => tempMyTeamIndex = teamIdx);
                                      },
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: teamControllers[teamIdx],
                                        decoration: InputDecoration(
                                          labelText: isMySquad ? 'Team ${teamIdx + 1} (My Team)' : 'Team ${teamIdx + 1}',
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_upward, size: 16),
                                      onPressed: slotIdx > 0
                                          ? () {
                                              setDialogState(() {
                                                final temp = tempDraftOrder[slotIdx];
                                                tempDraftOrder[slotIdx] = tempDraftOrder[slotIdx - 1];
                                                tempDraftOrder[slotIdx - 1] = temp;
                                              });
                                            }
                                          : null,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_downward, size: 16),
                                      onPressed: slotIdx < tempTeams - 1
                                          ? () {
                                              setDialogState(() {
                                                final temp = tempDraftOrder[slotIdx];
                                                tempDraftOrder[slotIdx] = tempDraftOrder[slotIdx + 1];
                                                tempDraftOrder[slotIdx + 1] = temp;
                                              });
                                            }
                                          : null,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Active Starting Lineup Configuration:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amberAccent),
                          ),
                          const Text(
                            'Higher starter counts directly inflate baseline VORP requirements for that position.',
                            style: TextStyle(fontSize: 12, color: Colors.white60),
                          ),
                          const SizedBox(height: 8),
                          _buildNumField('Starting Quarterbacks (QB)', startQbCtrl),
                          _buildNumField('Starting Running Backs (RB)', startRbCtrl),
                          _buildNumField('Starting Wide Receivers (WR)', startWrCtrl),
                          _buildNumField('Starting Tight Ends (TE)', startTeCtrl),
                          _buildNumField('Starting FLEX (RB/WR/TE)', startFlexCtrl),
                          _buildNumField('Starting Kickers (K)', startKCtrl),
                          _buildNumField('Starting Defenses (D/ST)', startDstCtrl),
                          const Divider(color: Colors.white24, height: 24),
                          const Text(
                            'Mandatory Positional Draft Quotas:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyanAccent),
                          ),
                          const Text(
                            'If your league requires drafting minimum position counts, the algorithm increases urgency to secure positions before late rounds.',
                            style: TextStyle(fontSize: 12, color: Colors.white60),
                          ),
                          const SizedBox(height: 8),
                          _buildNumField('Must Draft QBs (e.g., 2)', minQbCtrl),
                          _buildNumField('Must Draft RBs (e.g., 4)', minRbCtrl),
                          _buildNumField('Must Draft WRs (e.g., 4)', minWrCtrl),
                          _buildNumField('Must Draft TEs (e.g., 2)', minTeCtrl),
                          _buildNumField('Must Draft Kickers (e.g., 1)', minKCtrl),
                          _buildNumField('Must Draft Defenses (e.g., 1)', minDstCtrl),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Passing Tiers & Long TD Bonuses', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purpleAccent)),
                          _buildNumField('Passing TD Value (PaTD)', passTdCtrl),
                          _buildNumField('PaTD 50-74 Yd Bonus', passTd50Ctrl),
                          _buildNumField('PaTD 75-99 Yd Bonus', passTd75Ctrl),
                          _buildNumField('PaYds per 50 Yd Tier', passYdsTierCtrl),
                          _buildNumField('250+ PaYd Game Bonus', pass250Ctrl),
                          _buildNumField('450+ PaYd Game Bonus', pass450Ctrl),
                          _buildNumField('Interception Thrown (PaINT)', passIntCtrl),
                          const Divider(color: Colors.white24),
                          const Text('Rushing Tiers & Bonuses', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                          _buildNumField('Rushing TD Value (RuTD)', rushTdCtrl),
                          _buildNumField('RuTD 50-74 Yd Bonus', rushTd50Ctrl),
                          _buildNumField('RuTD 75-99 Yd Bonus', rushTd75Ctrl),
                          _buildNumField('RuYds per 25 Yd Tier', rushYdsTierCtrl),
                          _buildNumField('100+ RuYd Game Bonus', rush100Ctrl),
                          _buildNumField('200+ RuYd Game Bonus', rush200Ctrl),
                          _buildNumField('300+ RuYd Game Bonus', rush300Ctrl),
                          const Divider(color: Colors.white24),
                          const Text('Receiving Tiers & Bonuses', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                          _buildNumField('Receiving TD Value (ReTD)', recTdCtrl),
                          _buildNumField('ReTD 50-74 Yd Bonus', recTd50Ctrl),
                          _buildNumField('ReTD 75-99 Yd Bonus', recTd75Ctrl),
                          _buildNumField('ReYds per 25 Yd Tier', recYdsTierCtrl),
                          _buildNumField('100+ ReYd Game Bonus', rec100Ctrl),
                          _buildNumField('200+ ReYd Game Bonus', rec200Ctrl),
                          _buildNumField('300+ ReYd Game Bonus', rec300Ctrl),
                          _buildNumField('Reception (PPR Value)', pprCtrl),
                          const Divider(color: Colors.white24),
                          const Text('Kicking Distance Brackets', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                          _buildNumField('Base Field Goal (FG)', fgBaseCtrl),
                          _buildNumField('FG 40-49 Yd Bonus', fg40Ctrl),
                          _buildNumField('FG 50-59 Yd Bonus', fg50Ctrl),
                          _buildNumField('FG 60-69 Yd Bonus', fg60Ctrl),
                          _buildNumField('Extra Point Made (XP)', xpCtrl),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Playmakers & Turnovers', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amberAccent)),
                          _buildNumField('Sack (SACK)', sackCtrl),
                          _buildNumField('Interception (Int)', intCtrl),
                          _buildNumField('Fumble Recovery (DFR)', fumbleRecCtrl),
                          _buildNumField('Safety (STY)', safetyCtrl),
                          _buildNumField('Blocked Kick/Punt/XP (BFB/BP/BXP)', blockedKickCtrl),
                          _buildNumField('D/ST Touchdown (DTD)', defTdCtrl),
                          const Divider(color: Colors.white24),
                          const Text('Points Against (PA) Brackets', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                          _buildNumField('0 PA (Shutout)', pa0Ctrl),
                          _buildNumField('2 - 3 Points Allowed', pa2to3Ctrl),
                          _buildNumField('4 - 6 Points Allowed', pa4to6Ctrl),
                          _buildNumField('7 - 9 Points Allowed', pa7to9Ctrl),
                          _buildNumField('10 - 12 Points Allowed', pa10to12Ctrl),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel', style: TextStyle(color: Colors.white60)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6750A4),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _settings.leagueName = leagueNameController.text.trim();
                      _settings.numTeams = tempTeams;
                      _settings.numRounds = tempRounds;
                      _settings.myTeamIndex = tempMyTeamIndex;
                      _settings.draftType = tempDraftType;
                      _settings.draftOrder = tempDraftOrder;
                      for (int i = 0; i < 16; i++) {
                        _settings.teamNames[i] = teamControllers[i].text.trim().isEmpty
                            ? 'Team ${i + 1}'
                            : teamControllers[i].text.trim();
                      }

                      _settings.startQb = int.tryParse(startQbCtrl.text) ?? _settings.startQb;
                      _settings.startRb = int.tryParse(startRbCtrl.text) ?? _settings.startRb;
                      _settings.startWr = int.tryParse(startWrCtrl.text) ?? _settings.startWr;
                      _settings.startTe = int.tryParse(startTeCtrl.text) ?? _settings.startTe;
                      _settings.startFlex = int.tryParse(startFlexCtrl.text) ?? _settings.startFlex;
                      _settings.startK = int.tryParse(startKCtrl.text) ?? _settings.startK;
                      _settings.startDst = int.tryParse(startDstCtrl.text) ?? _settings.startDst;

                      _settings.minQb = int.tryParse(minQbCtrl.text) ?? _settings.minQb;
                      _settings.minRb = int.tryParse(minRbCtrl.text) ?? _settings.minRb;
                      _settings.minWr = int.tryParse(minWrCtrl.text) ?? _settings.minWr;
                      _settings.minTe = int.tryParse(minTeCtrl.text) ?? _settings.minTe;
                      _settings.minK = int.tryParse(minKCtrl.text) ?? _settings.minK;
                      _settings.minDst = int.tryParse(minDstCtrl.text) ?? _settings.minDst;

                      _settings.passTdPoints = double.tryParse(passTdCtrl.text) ?? _settings.passTdPoints;
                      _settings.passTd50PlusBonus = double.tryParse(passTd50Ctrl.text) ?? _settings.passTd50PlusBonus;
                      _settings.passTd75PlusBonus = double.tryParse(passTd75Ctrl.text) ?? _settings.passTd75PlusBonus;
                      _settings.passYdsTierPts = double.tryParse(passYdsTierCtrl.text) ?? _settings.passYdsTierPts;
                      _settings.pass250Bonus = double.tryParse(pass250Ctrl.text) ?? _settings.pass250Bonus;
                      _settings.pass450Bonus = double.tryParse(pass450Ctrl.text) ?? _settings.pass450Bonus;
                      _settings.passIntPoints = double.tryParse(passIntCtrl.text) ?? _settings.passIntPoints;

                      _settings.rushTdPoints = double.tryParse(rushTdCtrl.text) ?? _settings.rushTdPoints;
                      _settings.rushTd50PlusBonus = double.tryParse(rushTd50Ctrl.text) ?? _settings.rushTd50PlusBonus;
                      _settings.rushTd75PlusBonus = double.tryParse(rushTd75Ctrl.text) ?? _settings.rushTd75PlusBonus;
                      _settings.rushYdsTierPts = double.tryParse(rushYdsTierCtrl.text) ?? _settings.rushYdsTierPts;
                      _settings.rush100Bonus = double.tryParse(rush100Ctrl.text) ?? _settings.rush100Bonus;
                      _settings.rush200Bonus = double.tryParse(rush200Ctrl.text) ?? _settings.rush200Bonus;
                      _settings.rush300Bonus = double.tryParse(rush300Ctrl.text) ?? _settings.rush300Bonus;

                      _settings.recTdPoints = double.tryParse(recTdCtrl.text) ?? _settings.recTdPoints;
                      _settings.recTd50PlusBonus = double.tryParse(recTd50Ctrl.text) ?? _settings.recTd50PlusBonus;
                      _settings.recTd75PlusBonus = double.tryParse(recTd75Ctrl.text) ?? _settings.recTd75PlusBonus;
                      _settings.recYdsTierPts = double.tryParse(recYdsTierCtrl.text) ?? _settings.recYdsTierPts;
                      _settings.rec100Bonus = double.tryParse(rec100Ctrl.text) ?? _settings.rec100Bonus;
                      _settings.rec200Bonus = double.tryParse(rec200Ctrl.text) ?? _settings.rec200Bonus;
                      _settings.rec300Bonus = double.tryParse(rec300Ctrl.text) ?? _settings.rec300Bonus;
                      _settings.ppr = double.tryParse(pprCtrl.text) ?? _settings.ppr;

                      _settings.fgBasePoints = double.tryParse(fgBaseCtrl.text) ?? _settings.fgBasePoints;
                      _settings.fg40Bonus = double.tryParse(fg40Ctrl.text) ?? _settings.fg40Bonus;
                      _settings.fg50Bonus = double.tryParse(fg50Ctrl.text) ?? _settings.fg50Bonus;
                      _settings.fg60Bonus = double.tryParse(fg60Ctrl.text) ?? _settings.fg60Bonus;
                      _settings.xpPoints = double.tryParse(xpCtrl.text) ?? _settings.xpPoints;

                      _settings.sackPoints = double.tryParse(sackCtrl.text) ?? _settings.sackPoints;
                      _settings.intPoints = double.tryParse(intCtrl.text) ?? _settings.intPoints;
                      _settings.fumbleRecPoints = double.tryParse(fumbleRecCtrl.text) ?? _settings.fumbleRecPoints;
                      _settings.safetyPoints = double.tryParse(safetyCtrl.text) ?? _settings.safetyPoints;
                      _settings.blockedKickPoints = double.tryParse(blockedKickCtrl.text) ?? _settings.blockedKickPoints;
                      _settings.defTdPoints = double.tryParse(defTdCtrl.text) ?? _settings.defTdPoints;
                      _settings.pa0Points = double.tryParse(pa0Ctrl.text) ?? _settings.pa0Points;
                      _settings.pa2to3Points = double.tryParse(pa2to3Ctrl.text) ?? _settings.pa2to3Points;
                      _settings.pa4to6Points = double.tryParse(pa4to6Ctrl.text) ?? _settings.pa4to6Points;
                      _settings.pa7to9Points = double.tryParse(pa7to9Ctrl.text) ?? _settings.pa7to9Points;
                      _settings.pa10to12Points = double.tryParse(pa10to12Ctrl.text) ?? _settings.pa10to12Points;
                    });
                    Navigator.pop(ctx);
                  },
                  child: const Text('Save Settings'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNumField(
    String label,
    TextEditingController controller,
  ) {
    return ListTile(
      dense: true,
      title: Text(label, style: const TextStyle(fontSize: 13)),
      trailing: SizedBox(
        width: 85,
        child: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Widget _buildRosterDrawer() {
    final myQBs = _myRoster.where((p) => p.position == 'QB').toList();
    final myRBs = _myRoster.where((p) => p.position == 'RB').toList();
    final myWRs = _myRoster.where((p) => p.position == 'WR').toList();
    final myTEs = _myRoster.where((p) => p.position == 'TE').toList();
    final myKs = _myRoster.where((p) => p.position == 'K').toList();
    final myDSTs = _myRoster.where((p) => p.position == 'DST').toList();

    return Drawer(
      backgroundColor: const Color(0xFF1E1716),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              color: const Color(0xFF2C2220),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _myTeamName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amberAccent),
                  ),
                  const SizedBox(height: 2),
                  Text(_settings.leagueName, style: const TextStyle(color: Colors.white60, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(
                    '${_myRoster.length} / ${_settings.numRounds} Roster Slots Filled',
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12.0),
                children: [
                  _buildSlotCategory('Quarterbacks (QB)', myQBs, 'QB', minQuota: _settings.minQb),
                  _buildSlotCategory('Running Backs (RB)', myRBs, 'RB', minQuota: _settings.minRb),
                  _buildSlotCategory('Wide Receivers (WR)', myWRs, 'WR', minQuota: _settings.minWr),
                  _buildSlotCategory('Tight Ends (TE)', myTEs, 'TE', minQuota: _settings.minTe),
                  _buildSlotCategory('Kickers (K)', myKs, 'K', minQuota: _settings.minK),
                  _buildSlotCategory('Defense / Special Teams (D/ST)', myDSTs, 'DST', minQuota: _settings.minDst),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotCategory(String title, List<Player> players, String pos, {int minQuota = 0}) {
    final bool quotaMet = players.length >= minQuota;

    return Card(
      color: const Color(0xFF140D0C),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(
                  '${players.length}${minQuota > 0 ? " / min $minQuota" : ""}',
                  style: TextStyle(
                    color: quotaMet ? Colors.greenAccent : Colors.orangeAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            if (players.isEmpty)
              const Text(
                'None drafted',
                style: TextStyle(color: Colors.white38, fontStyle: FontStyle.italic, fontSize: 12),
              )
            else
              Wrap(
                spacing: 6.0,
                runSpacing: 4.0,
                children: players.map((p) {
                  return Chip(
                    backgroundColor: _getPositionBadgeColor(pos).withValues(alpha: 0.25),
                    label: Text(
                      '${p.name} (${p.nflTeam})',
                      style: const TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentPickTicker() {
    if (_draftHistory.isEmpty) return const SizedBox.shrink();
    final recentPicks = _draftHistory.reversed.take(6).toList();

    return Container(
      height: 38,
      color: const Color(0xFF1A1211),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.flash_on, color: Colors.amberAccent, size: 16),
          const SizedBox(width: 6),
          const Text('RECENT:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white70)),
          const SizedBox(width: 8),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recentPicks.length,
              separatorBuilder: (_, __) => const VerticalDivider(color: Colors.white12, width: 16),
              itemBuilder: (context, idx) {
                final pick = recentPicks[idx];
                return Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '#${pick.pickNumber} ',
                          style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                        TextSpan(
                          text: '${pick.player.name} (${pick.player.position}) ',
                          style: const TextStyle(color: Colors.white, fontSize: 11),
                        ),
                        TextSpan(
                          text: '→ ${pick.draftedByTeam}',
                          style: TextStyle(color: pick.isMyTeam ? Colors.greenAccent : Colors.white60, fontSize: 11),
                        ),
                        if (pick.isKeeper)
                          const TextSpan(
                            text: ' [K]',
                            style: TextStyle(color: Colors.orangeAccent, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnTheClockHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: _isMyTurn
            ? const Color(0xFF2E7D32).withValues(alpha: 0.3)
            : const Color(0xFF2C2220),
        border: Border(
          bottom: BorderSide(
            color: _isMyTurn ? Colors.greenAccent : Colors.white12,
            width: _isMyTurn ? 2 : 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                _isDraftComplete ? Icons.flag : (_isMyTurn ? Icons.stars : Icons.timer_outlined),
                color: _isDraftComplete
                    ? Colors.amberAccent
                    : (_isMyTurn ? Colors.greenAccent : Colors.purpleAccent),
                size: 22,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isDraftComplete ? 'DRAFT COMPLETE' : 'ON THE CLOCK: $_onTheClockTeamName',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _isMyTurn ? Colors.greenAccent : Colors.white,
                    ),
                  ),
                  Text(
                    _isDraftComplete
                        ? '${_draftHistory.length} total picks recorded'
                        : 'Round $_currentRound, Pick $_currentRoundPick (Overall #$_currentPickNumber) • ${_settings.draftType == DraftType.snake ? "Snake" : "Linear"} Format',
                    style: const TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          if (_isMyTurn)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'YOUR PICK',
                style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildRosterDrawer(),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_settings.leagueName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              '${_settings.numTeams} Teams | ${_settings.numRounds} Rds | My Team: $_myTeamName',
              style: const TextStyle(fontSize: 11, color: Colors.white60),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          StreamBuilder<List<Player>>(
            stream: widget.db.select(widget.db.players).watch(),
            builder: (context, snapshot) {
              return IconButton(
                icon: const Icon(Icons.bookmark_added_outlined),
                tooltip: 'Pre-Draft Keepers',
                onPressed: () {
                  if (snapshot.hasData) {
                    _showKeepersDialog(snapshot.data!);
                  }
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.groups_outlined),
            tooltip: 'View All Teams Rosters',
            onPressed: _showAllTeamsRostersDialog,
          ),
          Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.shield_outlined),
              tooltip: 'Open My Roster',
              onPressed: () => Scaffold.of(ctx).openDrawer(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Draft History & Undo',
            onPressed: _showHistoryAndRollbackDialog,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'League & Scoring Settings',
            onPressed: _showSettingsDialog,
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

                final Map<String, List<MapEntry<Player, double>>> posGroups = {
                  'QB': [],
                  'RB': [],
                  'WR': [],
                  'TE': [],
                  'K': [],
                  'DST': [],
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

                final flexPerPos = (_settings.startFlex * _settings.numTeams) / 2.0;
                final Map<String, int> vorpBaselines = {
                  'QB': max(1, _settings.startQb * _settings.numTeams),
                  'RB': max(1, (_settings.startRb * _settings.numTeams) + flexPerPos.toInt()),
                  'WR': max(1, (_settings.startWr * _settings.numTeams) + flexPerPos.toInt()),
                  'TE': max(1, _settings.startTe * _settings.numTeams),
                  'K': max(1, _settings.startK * _settings.numTeams),
                  'DST': max(1, _settings.startDst * _settings.numTeams),
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

                final List<RankedPlayer> ranked = [];
                for (final entry in posGroups.entries) {
                  final pos = entry.key;
                  final list = entry.value;
                  final repPts = replacementPoints[pos] ?? 0.0;
                  final scarcityMult = _getQuotaScarcityMultiplier(pos);

                  for (int i = 0; i < list.length; i++) {
                    final p = list[i].key;
                    final pts = list[i].value;
                    final rawVorp = (pts - repPts).clamp(0.0, 999.0);
                    final vorp = rawVorp * scarcityMult;

                    final nextPts = (i + 1 < list.length) ? list[i + 1].value : repPts;
                    final vona = (pts - nextPts).clamp(0.0, 999.0) * scarcityMult;

                    ranked.add(RankedPlayer(
                      player: p,
                      projPoints: pts,
                      vorp: vorp,
                      vona: vona,
                    ));
                  }
                }

                switch (_selectedSort) {
                  case SortMetric.vorp:
                    ranked.sort((a, b) => b.vorp.compareTo(a.vorp));
                    break;
                  case SortMetric.vona:
                    ranked.sort((a, b) => b.vona.compareTo(a.vona));
                    break;
                  case SortMetric.projPoints:
                    ranked.sort((a, b) => b.projPoints.compareTo(a.projPoints));
                    break;
                  case SortMetric.priorYear:
                    ranked.sort((a, b) => b.player.priorYearPts.compareTo(a.player.priorYearPts));
                    break;
                }

                final filtered = ranked.where((r) {
                  final p = r.player;
                  if (_selectedPosition != 'ALL' && p.position != _selectedPosition) {
                    return false;
                  }
                  if (_filterTargetsOnly && !_targetPlayerIds.contains(p.id)) {
                    return false;
                  }
                  if (_hideFadedPlayers && _fadePlayerIds.contains(p.id)) {
                    return false;
                  }
                  return true;
                }).toList();

                return Column(
                  children: [
                    _buildOnTheClockHeader(),
                    _buildRecentPickTicker(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...['ALL', 'QB', 'RB', 'WR', 'TE', 'K', 'DST'].map((pos) {
                                    final isSelected = _selectedPosition == pos;
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 6.0),
                                      child: ChoiceChip(
                                        label: Text(pos),
                                        selected: isSelected,
                                        selectedColor: const Color(0xFF6750A4),
                                        labelStyle: TextStyle(
                                          color: isSelected ? Colors.white : Colors.white70,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        onSelected: (_) {
                                          setState(() {
                                            _selectedPosition = pos;
                                          });
                                        },
                                      ),
                                    );
                                  }),
                                  const SizedBox(width: 8),
                                  FilterChip(
                                    label: Text('🎯 Targets (${_targetPlayerIds.length})'),
                                    selected: _filterTargetsOnly,
                                    selectedColor: Colors.amber.withValues(alpha: 0.3),
                                    checkmarkColor: Colors.amberAccent,
                                    labelStyle: TextStyle(
                                      color: _filterTargetsOnly ? Colors.amberAccent : Colors.white70,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    onSelected: (val) {
                                      setState(() => _filterTargetsOnly = val);
                                    },
                                  ),
                                  const SizedBox(width: 6),
                                  FilterChip(
                                    label: Text(_hideFadedPlayers ? '🚫 Faded Hidden' : '🚫 Faded Shown'),
                                    selected: _hideFadedPlayers,
                                    selectedColor: Colors.redAccent.withValues(alpha: 0.3),
                                    checkmarkColor: Colors.redAccent,
                                    labelStyle: TextStyle(
                                      color: _hideFadedPlayers ? Colors.redAccent : Colors.white70,
                                      fontSize: 12,
                                    ),
                                    onSelected: (val) {
                                      setState(() => _hideFadedPlayers = val);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          DropdownButton<SortMetric>(
                            value: _selectedSort,
                            dropdownColor: const Color(0xFF2C2220),
                            items: const [
                              DropdownMenuItem(value: SortMetric.vorp, child: Text('Sort: VORP', style: TextStyle(fontSize: 12))),
                              DropdownMenuItem(value: SortMetric.vona, child: Text('Sort: VONA', style: TextStyle(fontSize: 12))),
                              DropdownMenuItem(value: SortMetric.projPoints, child: Text('Sort: Proj Pts', style: TextStyle(fontSize: 12))),
                              DropdownMenuItem(value: SortMetric.priorYear, child: Text('Sort: Last Year', style: TextStyle(fontSize: 12))),
                            ],
                            onChanged: (v) {
                              if (v != null) setState(() => _selectedSort = v);
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Colors.white12),
                    Expanded(
                      child: ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1, color: Colors.white12),
                        itemBuilder: (context, index) {
                          final item = filtered[index];
                          final p = item.player;
                          final cliffColor = _getTierCliffColor(item.vona);

                          final isTarget = _targetPlayerIds.contains(p.id);
                          final isFaded = _fadePlayerIds.contains(p.id);

                          return ListTile(
                            tileColor: isTarget
                                ? Colors.amber.withValues(alpha: 0.08)
                                : isFaded
                                    ? Colors.black26
                                    : null,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 4.0,
                            ),
                            leading: Stack(
                              children: [
                                CircleAvatar(
                                  backgroundColor: isFaded
                                      ? Colors.grey.shade800
                                      : _getPositionBadgeColor(p.position),
                                  child: Text(
                                    p.position,
                                    style: TextStyle(
                                      color: isFaded ? Colors.white38 : Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                if (isTarget)
                                  const Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Icon(Icons.star, color: Colors.amberAccent, size: 14),
                                  ),
                                if (isFaded)
                                  const Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Icon(Icons.block, color: Colors.redAccent, size: 14),
                                  ),
                              ],
                            ),
                            title: Row(
                              children: [
                                Text(
                                  '${p.name} (${p.nflTeam})',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: isFaded ? Colors.white38 : (isTarget ? Colors.amberAccent : Colors.white),
                                    decoration: isFaded ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Age: ${p.age}',
                                  style: TextStyle(fontSize: 12, color: isFaded ? Colors.white24 : Colors.white54),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text(
                                      'VORP: +${item.vorp.toStringAsFixed(1)} | ',
                                      style: TextStyle(
                                        color: isFaded
                                            ? Colors.white24
                                            : (_selectedSort == SortMetric.vorp ? Colors.greenAccent : Colors.white70),
                                        fontWeight: _selectedSort == SortMetric.vorp ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0,
                                        vertical: 2.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: cliffColor.withValues(alpha: isFaded ? 0.05 : 0.18),
                                        borderRadius: BorderRadius.circular(4.0),
                                        border: Border.all(
                                          color: cliffColor.withValues(alpha: isFaded ? 0.2 : 0.6),
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        'VONA: +${item.vona.toStringAsFixed(1)}',
                                        style: TextStyle(
                                          color: isFaded ? cliffColor.withValues(alpha: 0.4) : cliffColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ' | Proj: ${item.projPoints.toStringAsFixed(1)} pts',
                                      style: TextStyle(
                                        color: isFaded
                                            ? Colors.white24
                                            : (_selectedSort == SortMetric.projPoints ? Colors.amberAccent : Colors.white70),
                                        fontWeight: _selectedSort == SortMetric.projPoints ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Last Year: ${p.priorYearPts > 0 ? "${p.priorYearPts.toStringAsFixed(1)} pts (${p.priorYearSummary})" : "Rookie / No prior data"}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isFaded
                                        ? Colors.white12
                                        : (_selectedSort == SortMetric.priorYear ? Colors.cyanAccent : Colors.white38),
                                    fontWeight: _selectedSort == SortMetric.priorYear ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isTarget ? Icons.star : Icons.star_border,
                                    color: isTarget ? Colors.amberAccent : Colors.white38,
                                    size: 20,
                                  ),
                                  tooltip: isTarget ? 'Untarget Player' : 'Target Player',
                                  onPressed: () {
                                    setState(() {
                                      if (isTarget) {
                                        _targetPlayerIds.remove(p.id);
                                      } else {
                                        _targetPlayerIds.add(p.id);
                                        _fadePlayerIds.remove(p.id);
                                      }
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    isFaded ? Icons.block : Icons.block_outlined,
                                    color: isFaded ? Colors.redAccent : Colors.white38,
                                    size: 19,
                                  ),
                                  tooltip: isFaded ? 'Remove Do Not Draft Flag' : 'Flag as Do Not Draft',
                                  onPressed: () {
                                    setState(() {
                                      if (isFaded) {
                                        _fadePlayerIds.remove(p.id);
                                      } else {
                                        _fadePlayerIds.add(p.id);
                                        _targetPlayerIds.remove(p.id);
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(width: 4),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2C2220),
                                    foregroundColor: Colors.white70,
                                  ),
                                  onPressed: () => _showDraftSelectionDialog(p),
                                  child: const Text('Draft'),
                                ),
                              ],
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