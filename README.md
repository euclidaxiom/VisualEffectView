# VisualEffectView

SwiftUI wrapper for NSVisualEffectView providing translucent backgrounds and blur effects for macOS.

## Overview

- **Direct Parameters**: Configure individual properties inline
- **External Configuration**: Use protocol for centralized configuration
- **Default Values**: Sensible defaults for common use case
- **Intermediate Package Support**: Delegate configuration to final app

## API

### VisualEffectConfiguration Protocol
```swift
public protocol VisualEffectConfiguration {
    var material: NSVisualEffectView.Material { get }
    var blendingMode: NSVisualEffectView.BlendingMode { get }
    var isEmphasized: Bool { get }
    var allowsVibrancy: Bool { get }
}
```

### Constructors
```swift
// Default configuration
VisualEffectView()

// Direct parameters
VisualEffectView(
    material: .popover,
    blendingMode: .withinWindow,
    isEmphasized: true,
    allowsVibrancy: false
)

// External configuration
VisualEffectView(config: MyConfig())
```

## Usage Patterns

### Basic Usage
```swift
VStack {
    Text("Content")
}
.background(VisualEffectView())
```

### Custom Material
```swift
.background(VisualEffectView(material: .popover))
```

### Full Custom Configuration
```swift
.background(VisualEffectView(
    material: .hudWindow,
    blendingMode: .behindWindow,
    isEmphasized: false,
    allowsVibrancy: true
))
```

### Protocol-based Configuration
```swift
struct AppConfig: VisualEffectConfiguration {
    let material: NSVisualEffectView.Material = .popover
    let blendingMode: NSVisualEffectView.BlendingMode = .withinWindow
    let isEmphasized: Bool = true
    let allowsVibrancy: Bool = true
}

.background(VisualEffectView(config: AppConfig()))
```

### Intermediate Package Usage
```swift
// In intermediate package
public struct MyView: View {
    private let visualEffectConfig: VisualEffectConfiguration?
    
    public init(visualEffectConfig: VisualEffectConfiguration? = nil) {
        self.visualEffectConfig = visualEffectConfig
    }
    
    public var body: some View {
        VStack { Text("Content") }
            .background(VisualEffectView(config: visualEffectConfig ?? DefaultVisualEffectConfiguration()))
    }
}

// In final app
struct AppConfig: VisualEffectConfiguration { ... }
MyView(visualEffectConfig: AppConfig())
```

## Default Values

- `material`: `.underWindowBackground`
- `blendingMode`: `.behindWindow`
- `isEmphasized`: `true`
- `allowsVibrancy`: `false`

## Requirements

- macOS 11.0+
- SwiftUI

## Reference

For available materials and blending modes: [NSVisualEffectView Documentation](https://developer.apple.com/documentation/appkit/nsvisualeffectview)