import SwiftUI
import AppKit

/**
 Protocol defining VisualEffectView configuration.
 
 Used by intermediate packages to delegate configuration to the final app.
 */
public protocol VisualEffectConfiguration {
    /// The visual effect material to apply.
    var material: NSVisualEffectView.Material { get }
    
    /// The blending mode for the effect.
    var blendingMode: NSVisualEffectView.BlendingMode { get }
    
    /// Whether the effect should be emphasized.
    var isEmphasized: Bool { get }
}

/**
 Default configuration values for VisualEffectView.
 */
public struct DefaultVisualEffectConfiguration: VisualEffectConfiguration {
    public let material: NSVisualEffectView.Material = .underWindowBackground
    public let blendingMode: NSVisualEffectView.BlendingMode = .behindWindow
    public let isEmphasized: Bool = true
    
    public init() {}
}

/**
 SwiftUI wrapper for NSVisualEffectView.
 
 Provides translucent backgrounds and blur effects for macOS apps.
 Supports direct parameter configuration or external configuration via protocol.
 
 ## Usage Examples
 
 ```swift
 // Default configuration
 VisualEffectView()
 
 // Direct parameters
 VisualEffectView(material: .popover, blendingMode: .withinWindow)
 
 // External configuration
 struct AppConfig: VisualEffectConfiguration { ... }
 VisualEffectView(config: AppConfig())
 ```
 */
public struct VisualEffectView: View {
    private let configuration: VisualEffectConfiguration
    
    var material: NSVisualEffectView.Material { configuration.material }
    var blendingMode: NSVisualEffectView.BlendingMode { configuration.blendingMode }
    var isEmphasized: Bool { configuration.isEmphasized }

    /// Creates VisualEffectView with default configuration
    public init() {
        self.configuration = DefaultVisualEffectConfiguration()
    }
    
    /// Creates VisualEffectView with external configuration
    public init(config: VisualEffectConfiguration) {
        self.configuration = config
    }
    
    /// Creates VisualEffectView with direct parameters
    public init(
        material: NSVisualEffectView.Material = .underWindowBackground,
        blendingMode: NSVisualEffectView.BlendingMode = .behindWindow,
        isEmphasized: Bool = true,
    ) {
        self.configuration = CustomVisualEffectConfiguration(
            material: material,
            blendingMode: blendingMode,
            isEmphasized: isEmphasized,
        )
    }

    public var body: some View {
        Representable(
            material: material,
            blendingMode: blendingMode,
            isEmphasized: isEmphasized,
        )
        .ignoresSafeArea()
    }
    
    private struct CustomVisualEffectConfiguration: VisualEffectConfiguration {
        let material: NSVisualEffectView.Material
        let blendingMode: NSVisualEffectView.BlendingMode
        let isEmphasized: Bool
    }
    
    private struct Representable: NSViewRepresentable {
        var material: NSVisualEffectView.Material
        var blendingMode: NSVisualEffectView.BlendingMode
        var isEmphasized: Bool

        func makeNSView(context: Context) -> NSVisualEffectView {
            let view = NSVisualEffectView()
            view.material = material
            view.blendingMode = blendingMode
            view.state = .active
            view.isEmphasized = isEmphasized
            return view
        }

        func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
            nsView.material = material
            nsView.blendingMode = blendingMode
            nsView.isEmphasized = isEmphasized
        }
    }
}
