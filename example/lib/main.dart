import 'package:flutter/material.dart';
import 'package:smart_layout_switcher/smart_layout_switcher.dart';

/// Demo application showcasing the SmartLayoutSwitcher widget
///
/// This application demonstrates the responsive layout switching capabilities
/// of the SmartLayoutSwitcher widget with 20 sample items that automatically
/// adapt their layout based on screen size.
void main() => runApp(const SmartLayoutDemo());

/// The root widget of the demo application
class SmartLayoutDemo extends StatelessWidget {
  /// Creates the demo application
  const SmartLayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Layout Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Smart Layout Switcher')),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: ResponsiveLayoutExample(),
        ),
      ),
    );
  }
}

/// Example widget demonstrating responsive layout switching
///
/// This widget uses [SmartLayoutSwitcher] to display a collection of cards
/// that automatically switch between list, grid, masonry, and staggered layouts
/// based on the available screen width. Each card has a distinct color and height
/// to better visualize the different layout behaviors.
class ResponsiveLayoutExample extends StatelessWidget {
  /// Creates the responsive layout example
  const ResponsiveLayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SmartLayoutSwitcher(
      // Custom animation duration for more visible transitions
      animationDuration: const Duration(milliseconds: 500),

      // Generate 20 demo items with varying heights and colors
      children: List.generate(
        20,
        (index) => Card(
          elevation: 4,
          child: Container(
            // Vary heights to demonstrate masonry/staggered layouts
            height: 100 + (index % 5) * 20.0,
            // Cycle through material colors
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(
              child: Text(
                'Item $index',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
