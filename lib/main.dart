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

class LeagueSettings {
  String leagueName;
  int numTeams;
  int numRounds;
  List<String> teamNames;
  int myTeamIndex;

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
  }) : teamNames = teamNames ??
            List.generate(
              16,
              (i) => i == 0 ? 'My Dominators' : 'Team ${i + 1}',
            );
}

class DraftPickRecord {
  final int pickNumber;
  final Player player;
  final String draftedByTeam;
  final bool isMyTeam;

  DraftPickRecord({
    required this.pickNumber,
    required this.player,
    required this.draftedByTeam,
    required this.isMyTeam,
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
  final LeagueSettings _settings = LeagueSettings();
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

  Set<int> get _draftedPlayerIds =>
      _draftHistory.map((pick) => pick.player.id).toSet();

  List<Player> get _myRoster =>
      _draftHistory.where((pick) => pick.isMyTeam).map((pick) => pick.player).toList();

  String get _myTeamName => _settings.teamNames[_settings.myTeamIndex];

  void _recordPick(Player player, String teamName) {
    setState(() {
      _draftHistory.add(
        DraftPickRecord(
          pickNumber: _draftHistory.length + 1,
          player: player,
          draftedByTeam: teamName,
          isMyTeam: teamName == _myTeamName,
        ),
      );
    });
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

  void _showDraftSelectionDialog(Player player) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1716),
        title: Text('Draft ${player.name} (${player.position})'),
        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pick #${_draftHistory.length + 1} - Select drafting team:',
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 250,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _settings.numTeams,
                  separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.white10),
                  itemBuilder: (context, idx) {
                    final tName = _settings.teamNames[idx];
                    final isMine = idx == _settings.myTeamIndex;

                    return ListTile(
                      dense: true,
                      leading: Icon(
                        isMine ? Icons.star : Icons.shield_outlined,
                        color: isMine ? Colors.amber : Colors.white60,
                        size: 20,
                      ),
                      title: Text(
                        tName,
                        style: TextStyle(
                          color: isMine ? Colors.amberAccent : Colors.white,
                          fontWeight: isMine ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      subtitle: isMine
                          ? const Text('My Team', style: TextStyle(color: Colors.white54, fontSize: 11))
                          : null,
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
        ],
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
                        '${pick.player.name} (${pick.player.position} - ${pick.player.nflTeam})',
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
            length: 3,
            child: AlertDialog(
              backgroundColor: const Color(0xFF1E1716),
              title: const TabBar(
                indicatorColor: Color(0xFF6750A4),
                tabs: [
                  Tab(icon: Icon(Icons.tune), text: 'General & Teams'),
                  Tab(icon: Icon(Icons.sports_football), text: 'Offense & Kicking'),
                  Tab(icon: Icon(Icons.shield), text: 'Defense / Special Teams'),
                ],
              ),
              content: SizedBox(
                width: 620,
                height: 520,
                child: TabBarView(
                  children: [
                    // Tab 1: General & Teams
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
                                      });
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: DropdownButtonFormField<int>(
                                  initialValue: tempRounds,
                                  decoration: const InputDecoration(labelText: 'Draft Rounds'),
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
                          const SizedBox(height: 16),
                          const Text(
                            'Customize Team Names (Click Radio to Set "My Team"):',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: tempTeams,
                            itemBuilder: (context, i) {
                              final isMySquad = i == tempMyTeamIndex;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        isMySquad ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                        color: isMySquad ? Colors.amberAccent : Colors.white60,
                                      ),
                                      onPressed: () {
                                        setDialogState(() => tempMyTeamIndex = i);
                                      },
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: teamControllers[i],
                                        decoration: InputDecoration(
                                          labelText: isMySquad ? 'Team ${i + 1} (My Team)' : 'Team ${i + 1}',
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // Tab 2: Offense & Kicking (Manual Numeric Entry)
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

                    // Tab 3: Defense / Special Teams (Manual Numeric Entry)
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
                      for (int i = 0; i < 16; i++) {
                        _settings.teamNames[i] = teamControllers[i].text.trim().isEmpty
                            ? 'Team ${i + 1}'
                            : teamControllers[i].text.trim();
                      }

                      // Parse Passing
                      _settings.passTdPoints = double.tryParse(passTdCtrl.text) ?? _settings.passTdPoints;
                      _settings.passTd50PlusBonus = double.tryParse(passTd50Ctrl.text) ?? _settings.passTd50PlusBonus;
                      _settings.passTd75PlusBonus = double.tryParse(passTd75Ctrl.text) ?? _settings.passTd75PlusBonus;
                      _settings.passYdsTierPts = double.tryParse(passYdsTierCtrl.text) ?? _settings.passYdsTierPts;
                      _settings.pass250Bonus = double.tryParse(pass250Ctrl.text) ?? _settings.pass250Bonus;
                      _settings.pass450Bonus = double.tryParse(pass450Ctrl.text) ?? _settings.pass450Bonus;
                      _settings.passIntPoints = double.tryParse(passIntCtrl.text) ?? _settings.passIntPoints;

                      // Parse Rushing
                      _settings.rushTdPoints = double.tryParse(rushTdCtrl.text) ?? _settings.rushTdPoints;
                      _settings.rushTd50PlusBonus = double.tryParse(rushTd50Ctrl.text) ?? _settings.rushTd50PlusBonus;
                      _settings.rushTd75PlusBonus = double.tryParse(rushTd75Ctrl.text) ?? _settings.rushTd75PlusBonus;
                      _settings.rushYdsTierPts = double.tryParse(rushYdsTierCtrl.text) ?? _settings.rushYdsTierPts;
                      _settings.rush100Bonus = double.tryParse(rush100Ctrl.text) ?? _settings.rush100Bonus;
                      _settings.rush200Bonus = double.tryParse(rush200Ctrl.text) ?? _settings.rush200Bonus;
                      _settings.rush300Bonus = double.tryParse(rush300Ctrl.text) ?? _settings.rush300Bonus;

                      // Parse Receiving
                      _settings.recTdPoints = double.tryParse(recTdCtrl.text) ?? _settings.recTdPoints;
                      _settings.recTd50PlusBonus = double.tryParse(recTd50Ctrl.text) ?? _settings.recTd50PlusBonus;
                      _settings.recTd75PlusBonus = double.tryParse(recTd75Ctrl.text) ?? _settings.recTd75PlusBonus;
                      _settings.recYdsTierPts = double.tryParse(recYdsTierCtrl.text) ?? _settings.recYdsTierPts;
                      _settings.rec100Bonus = double.tryParse(rec100Ctrl.text) ?? _settings.rec100Bonus;
                      _settings.rec200Bonus = double.tryParse(rec200Ctrl.text) ?? _settings.rec200Bonus;
                      _settings.rec300Bonus = double.tryParse(rec300Ctrl.text) ?? _settings.rec300Bonus;
                      _settings.ppr = double.tryParse(pprCtrl.text) ?? _settings.ppr;

                      // Parse Kicking
                      _settings.fgBasePoints = double.tryParse(fgBaseCtrl.text) ?? _settings.fgBasePoints;
                      _settings.fg40Bonus = double.tryParse(fg40Ctrl.text) ?? _settings.fg40Bonus;
                      _settings.fg50Bonus = double.tryParse(fg50Ctrl.text) ?? _settings.fg50Bonus;
                      _settings.fg60Bonus = double.tryParse(fg60Ctrl.text) ?? _settings.fg60Bonus;
                      _settings.xpPoints = double.tryParse(xpCtrl.text) ?? _settings.xpPoints;

                      // Parse Defense
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
                  _buildSlotCategory('Quarterbacks (QB)', myQBs, 'QB'),
                  _buildSlotCategory('Running Backs (RB)', myRBs, 'RB'),
                  _buildSlotCategory('Wide Receivers (WR)', myWRs, 'WR'),
                  _buildSlotCategory('Tight Ends (TE)', myTEs, 'TE'),
                  _buildSlotCategory('Kickers (K)', myKs, 'K'),
                  _buildSlotCategory('Defense / Special Teams (D/ST)', myDSTs, 'DST'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotCategory(String title, List<Player> players, String pos) {
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
                Text('${players.length}', style: const TextStyle(color: Colors.white60, fontSize: 12)),
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

                final Map<String, int> vorpBaselines = {
                  'QB': _settings.numTeams,
                  'RB': _settings.numTeams * 2,
                  'WR': (_settings.numTeams * 2.5).toInt(),
                  'TE': _settings.numTeams,
                  'K': _settings.numTeams,
                  'DST': _settings.numTeams,
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

                  for (int i = 0; i < list.length; i++) {
                    final p = list[i].key;
                    final pts = list[i].value;
                    final vorp = (pts - repPts).clamp(0.0, 999.0);
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

                ranked.sort((a, b) => b.vorp.compareTo(a.vorp));

                final filtered = _selectedPosition == 'ALL'
                    ? ranked
                    : ranked.where((r) => r.player.position == _selectedPosition).toList();

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: ['ALL', 'QB', 'RB', 'WR', 'TE', 'K', 'DST'].map((pos) {
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
                                  fontSize: 12,
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
                              onPressed: () => _showDraftSelectionDialog(p),
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