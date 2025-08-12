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
     SwiftUI wrapper for NSVisualEffectView.
     Provides translucent backgrounds and blur effects for macOS apps.
     Supports direct parameter configuration or external configuration via protocol.
    
     ## Usage Examples
     // Default configuration
     VisualEffectView()
    
     // Direct parameters
     VisualEffectView(material: .popover, blendingMode: .withinWindow)
    
     // External configuration
     struct AppConfig: VisualEffectConfiguration { ... }
     VisualEffectView(config: AppConfig())
    
     // Optional external configuration
     VisualEffectView(config: anOptionalConfig)
    
     */
    public struct VisualEffectView: View {
        private let configuration: VisualEffectConfiguration?
    
        /// Creates VisualEffectView with an optional external configuration.
        /// If the configuration is nil, default values are used.
        public init(config: VisualEffectConfiguration? = nil) {
            self.configuration = config
        }
    
        /// Creates VisualEffectView with direct parameters
        public init(
            material: NSVisualEffectView.Material,
            blendingMode: NSVisualEffectView.BlendingMode,
            isEmphasized: Bool = true
        ) {
            self.configuration = CustomVisualEffectConfiguration(
                material: material,
                blendingMode: blendingMode,
                isEmphasized: isEmphasized
            )
        }
    
        public var body: some View {
            Representable(configuration: configuration)
                .ignoresSafeArea()
        }
    
        private struct CustomVisualEffectConfiguration: VisualEffectConfiguration {
            let material: NSVisualEffectView.Material
            let blendingMode: NSVisualEffectView.BlendingMode
            let isEmphasized: Bool
        }
    
        private struct Representable: NSViewRepresentable {
            var configuration: VisualEffectConfiguration?
    
            func makeNSView(context: Context) -> NSVisualEffectView {
                let view = NSVisualEffectView()
                view.state = .active
                return view
            }
    
            func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
                nsView.material = configuration?.material ?? .underWindowBackground
                nsView.blendingMode = configuration?.blendingMode ?? .behindWindow
                nsView.isEmphasized = configuration?.isEmphasized ?? true
            }
        }
    }