/// A Flutter package for responsive layout switching with smooth animations
///
/// This library provides widgets that automatically adapt their layout based on
/// available screen space, transitioning smoothly between different layout types.
/// It's particularly useful for creating responsive UIs that work across
/// different screen sizes and orientations.
///
/// Main components:
/// - [SmartLayoutSwitcher]: The primary widget that automatically switches
///   between layouts based on screen width
/// - [MasonryLayout]: A Pinterest-style masonry grid layout
/// - [StaggeredLayout]: A grid layout with staggered item sizes
///
/// Typical usage:
/// ```dart
/// SmartLayoutSwitcher(
///   children: contentWidgets,
///   listThreshold: 600,
///   gridThreshold: 900,
///   masonryThreshold: 1200,
/// )
/// ```
///
/// Features:
/// - Automatic responsive layout switching
/// - Smooth animated transitions
/// - Customizable breakpoints
/// - Multiple layout types
/// - Efficient rendering
library smart_layout_switcher;

export 'src/layout_switcher.dart' show SmartLayoutSwitcher;
export 'src/masonry_layout.dart' show MasonryLayout;
export 'src/staggered_layout.dart' show StaggeredLayout;
