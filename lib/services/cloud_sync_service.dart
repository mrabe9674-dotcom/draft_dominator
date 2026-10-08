import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:drift/drift.dart';
import '../data/database/app_database.dart';

class CloudSyncService {
  final AppDatabase db;
  static const String remoteUrl =
      'https://raw.githubusercontent.com/mrabe9674-dotcom/draft_dominator/assets/data/players.json';

  CloudSyncService(this.db);

  Future<void> syncData() async {
    String rawData;
    try {
      final res =
          await http.get(Uri.parse(remoteUrl)).timeout(const Duration(seconds: 4));
      rawData = (res.statusCode == 200) ? res.body : throw Exception();
    } catch (_) {
      rawData = await rootBundle.loadString('assets/data/players.json');
    }

    final List<dynamic> list = jsonDecode(rawData);
    final companions = list.map((item) {
      final m = item as Map<String, dynamic>;
      return PlayersCompanion.insert(
        name: m['name'] as String,
        position: m['position'] as String,
        nflTeam: m['nflTeam'] as String,
        age: (m['age'] as num).toInt(),
        injuryRisk: Value((m['injuryRisk'] as num? ?? 0.0).toDouble()),
        crimeRisk: Value((m['crimeRisk'] as num? ?? 0.0).toDouble()),
        teamTalentScore: Value((m['teamTalentScore'] as num? ?? 1.0).toDouble()),
        projPassYds: Value((m['projPassYds'] as num? ?? 0.0).toDouble()),
        projPassTds: Value((m['projPassTds'] as num? ?? 0.0).toDouble()),
        projRushYds: Value((m['projRushYds'] as num? ?? 0.0).toDouble()),
        projRushTds: Value((m['projRushTds'] as num? ?? 0.0).toDouble()),
        projRec: Value((m['projRec'] as num? ?? 0.0).toDouble()),
        projRecYds: Value((m['projRecYds'] as num? ?? 0.0).toDouble()),
        projRecTds: Value((m['projRecTds'] as num? ?? 0.0).toDouble()),
      );
    }).toList();

    // Clear stale rows first to prevent duplicate stacking across syncs
    await db.delete(db.players).go();

    await db.batch((b) {
      b.insertAll(db.players, companions);
    });
  }
}