import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables/players.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Players])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'draft_dominator_db'));

  @override
  int get schemaVersion => 1;
}