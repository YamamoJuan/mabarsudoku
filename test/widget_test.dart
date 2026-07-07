import 'package:flutter_test/flutter_test.dart';
import 'package:mabar_sudoku/main.dart';

void main() {
  testWidgets('app renders without error', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Mabar Sudoku'), findsOneWidget);
  });
}
