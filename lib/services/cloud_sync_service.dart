import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:drift/drift.dart';
import '../data/database/app_database.dart';

class CloudSyncService {
  final AppDatabase db;
  CloudSyncService(this.db);

  Future<void> syncData() async {
    final String rawJson =
        await rootBundle.loadString('assets/data/players.json');
    final List<dynamic> list = jsonDecode(rawJson) as List<dynamic>;

    await db.batch((batch) {
      for (final item in list) {
        final map = item as Map<String, dynamic>;
        batch.insert(
          db.players,
          PlayersCompanion(
            id: map['id'] != null
                ? Value((map['id'] as num).toInt())
                : const Value.absent(),
            name: Value(map['name'] as String? ?? 'Unknown Player'),
            position: Value(map['position'] as String? ?? 'N/A'),
            nflTeam: Value(map['nflTeam'] as String? ?? 'FA'),
            age: Value((map['age'] as num?)?.toInt() ?? 25),
            adp: Value((map['adp'] as num?)?.toDouble() ?? 999.0),
            injuryRisk: Value((map['injuryRisk'] as num?)?.toDouble() ?? 0.0),
            crimeRisk: Value((map['crimeRisk'] as num?)?.toDouble() ?? 0.0),
            teamTalentScore:
                Value((map['teamTalentScore'] as num?)?.toDouble() ?? 1.0),
            projPassYds:
                Value((map['projPassYds'] as num?)?.toDouble() ?? 0.0),
            projPassTds:
                Value((map['projPassTds'] as num?)?.toDouble() ?? 0.0),
            projPassInts:
                Value((map['projPassInts'] as num?)?.toDouble() ?? 0.0),
            projRushYds:
                Value((map['projRushYds'] as num?)?.toDouble() ?? 0.0),
            projRushTds:
                Value((map['projRushTds'] as num?)?.toDouble() ?? 0.0),
            projRec: Value((map['projRec'] as num?)?.toDouble() ?? 0.0),
            projRecYds: Value((map['projRecYds'] as num?)?.toDouble() ?? 0.0),
            projRecTds: Value((map['projRecTds'] as num?)?.toDouble() ?? 0.0),
            projFgMade: Value((map['projFgMade'] as num?)?.toDouble() ?? 0.0),
            projFg50Plus:
                Value((map['projFg50Plus'] as num?)?.toDouble() ?? 0.0),
            projPatMade:
                Value((map['projPatMade'] as num?)?.toDouble() ?? 0.0),
            projSacks: Value((map['projSacks'] as num?)?.toDouble() ?? 0.0),
            projTakeaways:
                Value((map['projTakeaways'] as num?)?.toDouble() ?? 0.0),
            projDefTds: Value((map['projDefTds'] as num?)?.toDouble() ?? 0.0),
            projPtsAllowedBaseline:
                Value((map['projPtsAllowedBaseline'] as num?)?.toDouble() ?? 0.0),
            priorYearPts:
                Value((map['priorYearPts'] as num?)?.toDouble() ?? 0.0),
            priorYearSummary:
                Value(map['priorYearSummary'] as String? ?? ''),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }
}