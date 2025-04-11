# Smart Layout Switcher for Flutter

[![Pub Version](https://img.shields.io/pub/v/smart_layout_switcher)](https://pub.dev/packages/smart_layout_switcher)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

A revolutionary Flutter package that automatically switches between list, grid, masonry, and
staggered layouts with smooth animations based on screen size.

## Features

- 🚀 Automatic layout switching based on screen size
- 🎨 Smooth animated transitions between layouts
- ⚙️ Fully customizable breakpoints
- 📱 Responsive design made simple
- 🏗 Zero-boilerplate implementation

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  smart_layout_switcher: ^1.0.0
```

## Usage

Basic implementation:

```dart
void main() {
  SmartLayoutSwitcher(
    children: List.generate(
      20,
          (index) => Card(child: Text('Item $index')),
    ),
  );
}
```

Custom configuration:

```dart
void main() {
  SmartLayoutSwitcher(
    children: myWidgets,
    listThreshold: 500,
    gridThreshold: 800,
    masonryThreshold: 1100,
    animationDuration: Duration(milliseconds: 500),
    gridCrossAxisCount: 3,
  );
}
```

## Layout Thresholds

| Layout    | Default Threshold | Description                     |
|-----------|-------------------|---------------------------------|
| List      | <600px            | Single column layout            |
| Grid      | 600-900px         | Uniform grid layout             |
| Masonry   | 900-1200px        | Pinterest-style masonry layout  |
| Staggered | >1200px           | Staggered grid with large items |

## License

MIT