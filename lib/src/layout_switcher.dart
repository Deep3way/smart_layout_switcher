import 'package:flutter/material.dart';

import '../smart_layout_switcher.dart';

/// Enum representing the different layout types available for the switcher.
///
/// - [list]: A single column/row list view layout
/// - [grid]: A uniform grid layout
/// - [masonry]: A masonry-style layout with variable height items
/// - [staggered]: A staggered grid layout with larger featured items
enum LayoutType { list, grid, masonry, staggered }

/// A smart layout switcher widget that automatically transitions between different
/// layout types based on available width.
///
/// This widget automatically switches between list, grid, masonry, and staggered
/// layouts when the available width crosses the configured thresholds, with smooth
/// animated transitions between layout changes.
///
/// Example:
/// ```dart
/// SmartLayoutSwitcher(
///   children: myWidgets,
///   listThreshold: 600,
///   gridThreshold: 900,
///   masonryThreshold: 1200,
/// )
/// ```
class SmartLayoutSwitcher extends StatefulWidget {
  /// The widgets to be displayed in the layout
  final List<Widget> children;

  /// The maximum width at which the list view layout will be used (default: 600)
  final double listThreshold;

  /// The maximum width at which the grid view layout will be used (default: 900)
  final double gridThreshold;

  /// The maximum width at which the masonry layout will be used (default: 1200)
  final double masonryThreshold;

  /// The duration of the animation when switching between layouts (default: 300ms)
  final Duration animationDuration;

  /// The curve used for layout transition animations (default: Curves.easeInOut)
  final Curve animationCurve;

  /// The scroll direction for all layouts (default: Axis.vertical)
  final Axis scrollDirection;

  /// Optional fixed cross axis count for the grid layout
  /// If null, defaults to 2 for vertical scroll and 3 for horizontal
  final int? gridCrossAxisCount;

  /// Optional aspect ratio for children in the grid layout (default: 1.0)
  final double? childAspectRatio;

  /// Optional maximum cross axis extent for masonry layout (default: 200)
  final double? masonryMaxCrossAxisExtent;

  /// Creates a smart layout switcher widget
  const SmartLayoutSwitcher({
    super.key,
    required this.children,
    this.listThreshold = 600,
    this.gridThreshold = 900,
    this.masonryThreshold = 1200,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.scrollDirection = Axis.vertical,
    this.gridCrossAxisCount,
    this.childAspectRatio,
    this.masonryMaxCrossAxisExtent,
  });

  @override
  State<SmartLayoutSwitcher> createState() => _SmartLayoutSwitcherState();
}

/// The state class for [SmartLayoutSwitcher]
class _SmartLayoutSwitcherState extends State<SmartLayoutSwitcher> {
  /// The currently active layout type
  LayoutType currentLayout = LayoutType.list;

  /// Determines the appropriate layout type based on available width
  ///
  /// This method is marked as visible for testing to allow verification of
  /// the layout determination logic.
  @visibleForTesting
  LayoutType determineLayout(double width) {
    if (width < widget.listThreshold) return LayoutType.list;
    if (width < widget.gridThreshold) return LayoutType.grid;
    if (width < widget.masonryThreshold) return LayoutType.masonry;
    return LayoutType.staggered;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final newLayout = determineLayout(width);

        if (newLayout != currentLayout) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() => currentLayout = newLayout);
          });
        }

        return AnimatedSwitcher(
          duration: widget.animationDuration,
          switchInCurve: widget.animationCurve,
          switchOutCurve: widget.animationCurve,
          child: _buildLayout(currentLayout),
        );
      },
    );
  }

  /// Builds the appropriate layout widget based on the current [LayoutType]
  Widget _buildLayout(LayoutType type) {
    switch (type) {
      case LayoutType.list:
        return ListView(
          key: ValueKey('list_${widget.children.length}'),
          scrollDirection: widget.scrollDirection,
          children: widget.children,
        );
      case LayoutType.grid:
        return GridView.count(
          key: ValueKey('grid_${widget.children.length}'),
          scrollDirection: widget.scrollDirection,
          crossAxisCount: widget.gridCrossAxisCount ??
              (widget.scrollDirection == Axis.vertical ? 2 : 3),
          childAspectRatio: widget.childAspectRatio ?? 1.0,
          children: widget.children,
        );
      case LayoutType.masonry:
        return MasonryLayout(
          key: ValueKey('masonry_${widget.children.length}'),
          maxCrossAxisExtent: widget.masonryMaxCrossAxisExtent ?? 200,
          scrollDirection: widget.scrollDirection,
          children: widget.children,
        );
      case LayoutType.staggered:
        return StaggeredLayout(
          key: ValueKey('staggered_${widget.children.length}'),
          scrollDirection: widget.scrollDirection,
          children: widget.children,
        );
    }
  }
}
