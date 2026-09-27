import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assignments/main.dart';

void main() {
  testWidgets('App smoke test - verifies multi-week switcher boots cleanly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FlutterAssignmentsApp());
    await tester.pumpAndSettle();

    // Verify that the Capstone App header and week switcher appear.
    expect(find.text('Week 4: Capstone E-Commerce App'), findsOneWidget);
    expect(find.text('W1'), findsOneWidget);
    expect(find.text('W2'), findsOneWidget);
    expect(find.text('W3'), findsOneWidget);
    expect(find.text('W4'), findsOneWidget);
  });
}
