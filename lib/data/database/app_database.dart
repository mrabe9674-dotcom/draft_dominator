import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Players extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get position => text()(); // QB, RB, WR, TE, K, DST
  TextColumn get nflTeam => text()();
  IntColumn get age => integer()();

  // Draft tracking state
  BoolColumn get isDrafted => boolean().withDefault(const Constant(false))();

  // Risk & talent modifiers
  RealColumn get injuryRisk => real().withDefault(const Constant(0.0))();
  RealColumn get crimeRisk => real().withDefault(const Constant(0.0))();
  RealColumn get teamTalentScore => real().withDefault(const Constant(1.0))();

  // Passing / Rushing / Receiving (Skill positions)
  RealColumn get projPassYds => real().withDefault(const Constant(0.0))();
  RealColumn get projPassTds => real().withDefault(const Constant(0.0))();
  RealColumn get projPassInts => real().withDefault(const Constant(0.0))();
  RealColumn get projRushYds => real().withDefault(const Constant(0.0))();
  RealColumn get projRushTds => real().withDefault(const Constant(0.0))();
  RealColumn get projRec => real().withDefault(const Constant(0.0))();
  RealColumn get projRecYds => real().withDefault(const Constant(0.0))();
  RealColumn get projRecTds => real().withDefault(const Constant(0.0))();

  // Kicking stats (ESPN standard metrics)
  RealColumn get projFgMade => real().withDefault(const Constant(0.0))();
  RealColumn get projFg50Plus => real().withDefault(const Constant(0.0))();
  RealColumn get projPatMade => real().withDefault(const Constant(0.0))();

  // Defense / Special Teams stats (ESPN standard metrics)
  RealColumn get projSacks => real().withDefault(const Constant(0.0))();
  RealColumn get projTakeaways => real().withDefault(const Constant(0.0))();
  RealColumn get projDefTds => real().withDefault(const Constant(0.0))();
  RealColumn get projPtsAllowedBaseline => real().withDefault(const Constant(0.0))();

  // Prior season stats
  RealColumn get priorYearPts => real().withDefault(const Constant(0.0))();
  TextColumn get priorYearSummary => text().withDefault(const Constant(''))();
}

@DriftDatabase(tables: [Players])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
            await m.createTable(table);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'on_the_clock.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}