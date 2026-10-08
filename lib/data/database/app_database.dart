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

  // Status & Medical designation
  TextColumn get injuryStatus => text().withDefault(const Constant('ACTIVE'))(); // ACTIVE, Q, OUT, IR, SUSP

  // Draft state & consensus ADP
  BoolColumn get isDrafted => boolean().withDefault(const Constant(false))();
  RealColumn get adp => real().withDefault(const Constant(999.0))();

  // Quantified Risk Modifiers (0.0 to 1.0)
  RealColumn get injuryRisk => real().withDefault(const Constant(0.05))();
  RealColumn get crimeRisk => real().withDefault(const Constant(0.0))();
  RealColumn get teamTalentScore => real().withDefault(const Constant(1.0))();

  // Depth Chart, Headshot & OLS Linear Regression
  IntColumn get depthChartOrder => integer().withDefault(const Constant(1))();
  TextColumn get headshotUrl => text().withDefault(const Constant(''))();
  RealColumn get trendSlope => real().withDefault(const Constant(0.0))();
  RealColumn get regressionForecast => real().withDefault(const Constant(0.0))();

  // Multi-Year Stat History (2025, 2024, 2023)
  RealColumn get y2025Pts => real().withDefault(const Constant(0.0))();
  TextColumn get y2025Stats => text().withDefault(const Constant(''))();
  RealColumn get y2024Pts => real().withDefault(const Constant(0.0))();
  TextColumn get y2024Stats => text().withDefault(const Constant(''))();
  RealColumn get y2023Pts => real().withDefault(const Constant(0.0))();
  TextColumn get y2023Stats => text().withDefault(const Constant(''))();

  // 3-Year Actual Counting Stat Averages
  RealColumn get threeYearAvgPts => real().withDefault(const Constant(0.0))();
  TextColumn get threeYearStatsSummary => text().withDefault(const Constant(''))();

  // Baseline Projections
  RealColumn get projPassYds => real().withDefault(const Constant(0.0))();
  RealColumn get projPassTds => real().withDefault(const Constant(0.0))();
  RealColumn get projPassInts => real().withDefault(const Constant(0.0))();
  RealColumn get projRushYds => real().withDefault(const Constant(0.0))();
  RealColumn get projRushTds => real().withDefault(const Constant(0.0))();
  RealColumn get projRec => real().withDefault(const Constant(0.0))();
  RealColumn get projRecYds => real().withDefault(const Constant(0.0))();
  RealColumn get projRecTds => real().withDefault(const Constant(0.0))();

  // Kicking stats
  RealColumn get projFgMade => real().withDefault(const Constant(0.0))();
  RealColumn get projFg50Plus => real().withDefault(const Constant(0.0))();
  RealColumn get projPatMade => real().withDefault(const Constant(0.0))();

  // D/ST stats
  RealColumn get projSacks => real().withDefault(const Constant(0.0))();
  RealColumn get projTakeaways => real().withDefault(const Constant(0.0))();
  RealColumn get projDefTds => real().withDefault(const Constant(0.0))();
  RealColumn get projPtsAllowedBaseline => real().withDefault(const Constant(0.0))();

  // Backward compatibility legacy columns
  RealColumn get priorYearPts => real().withDefault(const Constant(0.0))();
  TextColumn get priorYearSummary => text().withDefault(const Constant(''))();
}

@DriftDatabase(tables: [Players])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 8;

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