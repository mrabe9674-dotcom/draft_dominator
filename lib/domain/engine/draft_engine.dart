import '../../data/database/app_database.dart';

class LeagueSettings {
  final double ppr;
  final double passYdPts;
  final double passTdPts;
  final double rushYdPts;
  final double rushTdPts;
  final double recYdPts;
  final double recTdPts;
  final Map<String, int> rosterSpots;

  const LeagueSettings({
    this.ppr = 1.0,
    this.passYdPts = 0.04,
    this.passTdPts = 4.0,
    this.rushYdPts = 0.1,
    this.rushTdPts = 6.0,
    this.recYdPts = 0.1,
    this.recTdPts = 6.0,
    this.rosterSpots = const {'QB': 12, 'RB': 24, 'WR': 36, 'TE': 12},
  });
}

class CustomWeights {
  final double injuryWeight;
  final double crimeWeight;
  final double teamWeight;

  const CustomWeights({
    this.injuryWeight = 0.5,
    this.crimeWeight = 0.8,
    this.teamWeight = 0.5,
  });
}

class RankedPlayer {
  final Player player;
  final double adjustedPts;
  final double vorp;
  final double vona;

  RankedPlayer({
    required this.player,
    required this.adjustedPts,
    required this.vorp,
    required this.vona,
  });
}

class DraftEngine {
  static double calculateAdjustedPoints(Player p, LeagueSettings l, CustomWeights w) {
    final raw = (p.projPassYds * l.passYdPts) +
        (p.projPassTds * l.passTdPts) +
        (p.projRushYds * l.rushYdPts) +
        (p.projRushTds * l.rushTdPts) +
        (p.projRec * l.ppr) +
        (p.projRecYds * l.recYdPts) +
        (p.projRecTds * l.recTdPts);

    double ageMod = 1.0;
    if (p.age >= 29 && p.position == 'RB') ageMod = 0.90;
    if (p.age >= 32 && p.position == 'WR') ageMod = 0.92;

    final double injuryDiscount = (p.injuryRisk * w.injuryWeight) * 0.30;
    final double crimeDiscount = (p.crimeRisk * w.crimeWeight) * 0.50;
    final double teamMod = 1.0 + ((p.teamTalentScore - 1.0) * w.teamWeight);

    final result = raw * ageMod * teamMod * (1.0 - injuryDiscount) * (1.0 - crimeDiscount);
    return result > 0 ? result : 0.0;
  }

  static List<RankedPlayer> calculateVorp(List<Player> pool, LeagueSettings l, CustomWeights w) {
    final available = pool.where((p) => !p.isDrafted).toList();
    final scored = available.map((p) => MapEntry(p, calculateAdjustedPoints(p, l, w))).toList();

    // Group available players by position sorted descending by adjusted points
    final Map<String, List<MapEntry<Player, double>>> posGroups = {};
    for (var entry in scored) {
      posGroups.putIfAbsent(entry.key.position, () => []).add(entry);
    }
    for (var key in posGroups.keys) {
      posGroups[key]!.sort((a, b) => b.value.compareTo(a.value));
    }

    // Determine replacement-level baseline for each position
    final Map<String, double> baselines = {};
    for (var pos in ['QB', 'RB', 'WR', 'TE']) {
      final limit = l.rosterSpots[pos] ?? 12;
      final group = posGroups[pos] ?? [];
      baselines[pos] = (group.length >= limit)
          ? group[limit - 1].value
          : (group.isNotEmpty ? group.last.value : 0.0);
    }

    final results = <RankedPlayer>[];

    for (var entry in scored) {
      final player = entry.key;
      final pts = entry.value;
      final baseline = baselines[player.position] ?? 0.0;
      final vorp = double.parse((pts - baseline).toStringAsFixed(2));

      // Calculate VONA against the next available player at this same position
      final samePosList = posGroups[player.position] ?? [];
      final playerIndex = samePosList.indexWhere((e) => e.key.id == player.id);
      double vona = 0.0;
      if (playerIndex != -1 && playerIndex + 1 < samePosList.length) {
        vona = double.parse((pts - samePosList[playerIndex + 1].value).toStringAsFixed(2));
      }

      results.add(RankedPlayer(
        player: player,
        adjustedPts: pts,
        vorp: vorp,
        vona: vona,
      ));
    }

    results.sort((a, b) => b.vorp.compareTo(a.vorp));
    return results;
  }
}