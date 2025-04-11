import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// A responsive masonry layout that displays items with variable heights in columns
///
/// This widget implements a Pinterest-style layout where items flow vertically
/// with consistent column widths but varying heights. The layout automatically
/// adjusts column count based on available space and the specified maximum
/// item width.
///
/// Features:
/// - Dynamic column count based on screen width
/// - Efficient rendering with lazy loading
/// - Smooth scrolling in both directions
/// - Automatic content flow between columns
///
/// Example usage:
/// ```dart
/// MasonryLayout(
///   maxCrossAxisExtent: 200,
///   scrollDirection: Axis.vertical,
///   children: myWidgets,
/// )
/// ```
class MasonryLayout extends StatelessWidget {
  /// The widgets to be displayed in the masonry layout
  ///
  /// Typically a collection of cards or content blocks with varying heights
  /// that benefit from a flowing column-based arrangement.
  final List<Widget> children;

  /// The maximum width (or height for horizontal scrolling) of each item
  ///
  /// This determines:
  /// - Minimum column count (based on available space)
  /// - The base size of grid cells
  /// - The responsive behavior at different screen sizes
  final double maxCrossAxisExtent;

  /// The primary axis along which the content scrolls
  ///
  /// - [Axis.vertical] for vertical scrolling (traditional masonry layout)
  /// - [Axis.horizontal] for horizontal scrolling (less common)
  final Axis scrollDirection;

  /// Creates a MasonryLayout instance
  ///
  /// Requires:
  /// - [children]: The content widgets to display
  /// - [maxCrossAxisExtent]: The maximum item width/height
  /// - [scrollDirection]: The primary scrolling axis
  const MasonryLayout({
    super.key,
    required this.children,
    required this.maxCrossAxisExtent,
    required this.scrollDirection,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: scrollDirection,
      slivers: [
        SliverMasonryGrid(
          // Efficient builder that only creates visible children
          delegate: SliverChildBuilderDelegate(
            (context, index) => children[index],
            childCount: children.length,
          ),

          // Grid delegate that calculates column count
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            // Calculate column count based on available space
            crossAxisCount: (scrollDirection == Axis.vertical
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.height) ~/
                maxCrossAxisExtent,
          ),
        ),
      ],
    );
  }
}
