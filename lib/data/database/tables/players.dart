import 'package:drift/drift.dart';

class Players extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  TextColumn get position => text().withLength(min: 2, max: 4)();
  TextColumn get nflTeam => text().withLength(min: 2, max: 4)();
  IntColumn get age => integer()();

  RealColumn get injuryRisk => real().withDefault(const Constant(0.0))();
  RealColumn get crimeRisk => real().withDefault(const Constant(0.0))();
  RealColumn get teamTalentScore => real().withDefault(const Constant(1.0))();

  RealColumn get projPassYds => real().withDefault(const Constant(0.0))();
  RealColumn get projPassTds => real().withDefault(const Constant(0.0))();
  RealColumn get projRushYds => real().withDefault(const Constant(0.0))();
  RealColumn get projRushTds => real().withDefault(const Constant(0.0))();
  RealColumn get projRec => real().withDefault(const Constant(0.0))();
  RealColumn get projRecYds => real().withDefault(const Constant(0.0))();
  RealColumn get projRecTds => real().withDefault(const Constant(0.0))();

  BoolColumn get isDrafted => boolean().withDefault(const Constant(false))();

  @override
  List<Set<Column>> get uniqueKeys => [
        {name, nflTeam}
      ];
}