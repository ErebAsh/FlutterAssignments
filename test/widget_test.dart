import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assignments/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FlutterAssignmentsApp());

    // Verify that the title appears.
    expect(find.text('Assignment 1: Hello Flutter'), findsOneWidget);
  });
}
