# VisualEffectView

A SwiftUI wrapper for NSVisualEffectView that provides native macOS visual effects.

This view creates translucent backgrounds and blur effects that integrate seamlessly with the system. Designed to be used directly with the `.background()` modifier without additional configuration.

## Usage

```swift
VStack() {
    Text("Hello World")
        .background(VisualEffectView())
}

// Or with custom material
VStack() {
    Text("Hello World")
        .background(VisualEffectView(material: .popover))
}
```

For available materials and blending modes, see the [NSVisualEffectView documentation](https://developer.apple.com/documentation/appkit/nsvisualeffectview).

Requires macOS 11+.