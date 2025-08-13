import SwiftUI
import AppKit
    
public protocol VisualEffectConfiguration {
    var material: NSVisualEffectView.Material { get }
    var blendingMode: NSVisualEffectView.BlendingMode { get }
    var isEmphasized: Bool { get }
}
    
public struct VisualEffectView: View {
    private let configuration: VisualEffectConfiguration?
    
    public init(config: VisualEffectConfiguration? = nil) {
        self.configuration = config
    }
    
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
            nsView.material = configuration?.material ?? .popover
            nsView.blendingMode = configuration?.blendingMode ?? .behindWindow
            nsView.isEmphasized = configuration?.isEmphasized ?? true
        }
    }
}
