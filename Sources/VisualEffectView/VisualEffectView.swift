import SwiftUI
import AppKit

/**
 A SwiftUI wrapper for NSVisualEffectView that provides native macOS visual effects.
 
 This view creates translucent backgrounds and blur effects that integrate seamlessly with the system.
 Designed to be used directly with the `.background()` modifier without additional configuration.
 
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
 */
public struct VisualEffectView: View {
    /// The blending mode for the effect.
    var material: NSVisualEffectView.Material = .underWindowBackground
    
    /// The blending mode for the effect.
    var blendingMode: NSVisualEffectView.BlendingMode = .behindWindow
    
    /// Whether the effect should be emphasized.
    var isEmphasized: Bool = false

    /**
     Creates a new VisualEffectView with the specified parameters.
     
     - Parameters:
        - material: The visual effect material to apply. Defaults to `.underWindowBackground`.
        - blendingMode: The blending mode for the effect. Defaults to `.behindWindow`.
        - isEmphasized: Whether the effect should be emphasized. Defaults to `false`.
     
     - Returns: A configured VisualEffectView that can be used in SwiftUI layouts.
     */
    public init(
        material: NSVisualEffectView.Material = .underWindowBackground,
        blendingMode: NSVisualEffectView.BlendingMode = .behindWindow,
        isEmphasized: Bool = false
    ) {
        self.material = material
        self.blendingMode = blendingMode
        self.isEmphasized = isEmphasized
    }

    public var body: some View {
        Representable(
            material: material,
            blendingMode: blendingMode,
            isEmphasized: isEmphasized
        )
        .ignoresSafeArea()
    }
    
    /**
     A private NSViewRepresentable that bridges NSVisualEffectView to SwiftUI.
     
     This struct handles the creation and updating of the underlying NSVisualEffectView,
     ensuring that changes to the SwiftUI view's properties are properly reflected in the native view.
     */
    private struct Representable: NSViewRepresentable {
        /// The visual effect material to apply.
        var material: NSVisualEffectView.Material
        
        /// The blending mode for the effect.
        var blendingMode: NSVisualEffectView.BlendingMode
        
        /// Whether the effect should be emphasized.
        var isEmphasized: Bool

        /**
         Creates the underlying NSVisualEffectView.
         
         - Parameter context: The context provided by SwiftUI for view creation.
         - Returns: A configured NSVisualEffectView with the specified properties.
         */
        func makeNSView(context: Context) -> NSVisualEffectView {
            let view = NSVisualEffectView()
            view.material = material
            view.blendingMode = blendingMode
            view.state = .active
            view.isEmphasized = isEmphasized
            return view
        }

        /**
         Updates the underlying NSVisualEffectView when SwiftUI properties change.
         
         - Parameters:
            - nsView: The NSVisualEffectView to update.
            - context: The context provided by SwiftUI for view updates.
         */
        func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
            nsView.material = material
            nsView.blendingMode = blendingMode
            nsView.isEmphasized = isEmphasized
        }
    }
}
