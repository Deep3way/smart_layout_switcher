import 'package:flutter/material.dart';

/// Test helper functions for widget testing
///
/// This file contains utility functions to simplify widget testing,
/// particularly for responsive layout scenarios where controlled widths
/// and test content are needed.

/// Creates a test widget with constrained width in a proper widget hierarchy
///
/// Wraps the [child] widget in a [MaterialApp] and [Scaffold] with controlled
/// width to simulate different screen sizes during testing.
///
/// Parameters:
/// * [child] - The widget to be tested
/// * [width] - The constrained width for testing (default: 400)
///
/// Returns:
/// A properly scaffolded test widget with controlled width constraints
///
/// Example:
/// ```dart
/// await tester.pumpWidget(buildTestableWidget(
///   MyResponsiveWidget(),
///   width: 600,
/// ));
/// ```
Widget buildTestableWidget(Widget child, {double width = 400}) {
  return MaterialApp(
    home: Scaffold(
      body: SizedBox(
        width: width,
        child: child,
      ),
    ),
  );
}

/// Generates a list of test widgets with varying visual properties
///
/// Creates a list of colored containers with incrementing heights and text
/// labels, useful for testing layout widgets that need visual differentiation
/// between items.
///
/// Parameters:
/// * [count] - Number of test widgets to generate (default: 5)
///
/// Returns:
/// A List<Widget> containing visually distinct test items
///
/// Example:
/// ```dart
/// final testItems = getTestChildren(count: 10);
/// await tester.pumpWidget(buildTestableWidget(
///   MyLayoutWidget(children: testItems),
/// ));
/// ```
List<Widget> getTestChildren({int count = 5}) {
  return List.generate(
    count,
    (index) => Container(
      // Vary heights to test layout algorithms (base 50 + 0-40)
      height: 50 + (index % 3) * 20,
      // Cycle through material design primary colors
      color: Colors.primaries[index % Colors.primaries.length],
      child: Text('Item $index'),
    ),
  );
}
