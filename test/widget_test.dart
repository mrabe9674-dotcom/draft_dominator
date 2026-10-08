import 'package:flutter_test/flutter_test.dart';
import 'package:draft_dominator/data/database/app_database.dart';
import 'package:draft_dominator/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final db = AppDatabase();
    await tester.pumpWidget(DraftDominatorApp(db: db));
    expect(find.text('Draft Dominator (VORP Engine)'), findsOneWidget);
  });
}