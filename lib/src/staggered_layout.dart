import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// A responsive staggered grid layout that displays items with varying sizes
///
/// This widget implements a masonry-style grid layout where items can span
/// multiple columns/rows, creating a visually dynamic arrangement. It's
/// particularly effective for displaying content with varying aspect ratios.
///
/// The layout automatically adjusts to different screen sizes while maintaining
/// consistent spacing between items. It supports both vertical and horizontal
/// scrolling directions.
///
/// Example usage:
/// ```dart
/// StaggeredLayout(
///   scrollDirection: Axis.vertical,
///   children: myWidgets,
/// )
/// ```
class StaggeredLayout extends StatelessWidget {
  /// The list of widgets to display in the staggered grid
  ///
  /// Typically a collection of cards, images, or other content blocks
  /// that benefit from a dynamic grid layout.
  final List<Widget> children;

  /// The axis along which the grid scrolls
  ///
  /// - [Axis.vertical] for vertical scrolling (default for most layouts)
  /// - [Axis.horizontal] for horizontal scrolling (carousel-like behavior)
  final Axis scrollDirection;

  /// Creates a StaggeredLayout instance
  ///
  /// Requires:
  /// - [children]: The content widgets to display
  /// - [scrollDirection]: The primary scrolling axis
  const StaggeredLayout({
    super.key,
    required this.children,
    required this.scrollDirection,
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      // Fixed number of columns regardless of screen size
      crossAxisCount: 4,

      // Total number of items to display
      itemCount: children.length,

      // Builder function for grid items
      itemBuilder: (BuildContext context, int index) => children[index],

      // Vertical spacing between items
      mainAxisSpacing: 4.0,

      // Horizontal spacing between items
      crossAxisSpacing: 4.0,

      // Scroll direction from constructor
      scrollDirection: scrollDirection,
    );
  }
}
