import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_layout_switcher/smart_layout_switcher.dart';

/// Test suite for [SmartLayoutSwitcher] widget
///
/// This test suite verifies the behavior of the SmartLayoutSwitcher widget,
/// including layout switching, threshold respect, and animation transitions.
void main() {
  /// Creates a list of test items with varying heights and colors
  ///
  /// [count] - The number of test items to generate
  /// Returns a List<Widget> with visually distinct containers
  List<Widget> createTestItems(int count) {
    return List.generate(
        count,
        (index) => Container(
              height: 100 + (index % 5) * 20,
              color: Colors.primaries[index % Colors.primaries.length],
              child: Center(child: Text('Item $index')),
            ));
  }

  /// Builds a test widget with controlled width for layout testing
  ///
  /// [width] - The constrained width for the test
  /// [children] - Optional list of widgets to use (defaults to 5 test items)
  /// Returns a MaterialApp with properly scaffolded test environment
  Widget buildTestWidget(double width, {List<Widget>? children}) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: width,
          child: SmartLayoutSwitcher(
            children: children ?? createTestItems(5),
          ),
        ),
      ),
    );
  }

  /// Test group for SmartLayoutSwitcher core functionality
  group('SmartLayoutSwitcher', () {
    /// Tests that the widget renders a ListView when width is below listThreshold
    testWidgets('renders ListView below listThreshold', (tester) async {
      await tester.pumpWidget(buildTestWidget(500));
      expect(find.byType(ListView), findsOneWidget);
    });

    /// Tests automatic switching to GridView when width is between thresholds
    testWidgets('switches to GridView between thresholds', (tester) async {
      await tester.pumpWidget(buildTestWidget(700));
      await tester.pumpAndSettle(); // Wait for animations
      expect(find.byType(GridView), findsOneWidget);
    });

    /// Tests smooth animation between layout changes
    testWidgets('animates between layout changes', (tester) async {
      // Start with list layout
      await tester.pumpWidget(buildTestWidget(500));
      expect(find.byType(ListView), findsOneWidget);

      // Switch to grid layout
      await tester.pumpWidget(buildTestWidget(800));
      await tester.pumpAndSettle(); // Wait for animation completion
      expect(find.byType(GridView), findsOneWidget);
    });

    /// Tests that custom thresholds are respected
    testWidgets('respects custom thresholds', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 500,
              child: SmartLayoutSwitcher(
                children: createTestItems(5),
                listThreshold: 400, // Custom lower threshold
                gridThreshold: 800, // Custom upper threshold
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(GridView), findsOneWidget);
    });
  });
}
