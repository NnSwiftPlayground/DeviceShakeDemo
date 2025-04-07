//
//  DeviceShakeViewModifier.swift
//  DeviceShakeDemo
//
//  Created by Nikolai Nobadi on 4/6/25.
//

import SwiftUI

/// A view modifier that triggers an action when the device is shaken in a SwiftUI view.
struct DeviceShakeViewModifier: ViewModifier {
    let isActive: Bool
    let action: () -> Void
    
    func body(content: Content) -> some View {
        if isActive {
            content
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                    action()
                }
        } else {
            content
        }
    }
}

public extension View {
    /// Triggers an action when the device is shaken.
    /// - Parameters:
    ///   - isActive: A Boolean indicating if the shake detection is active.
    ///   - action: The action to perform when the device is shaken.
    /// - Returns: A modified view that detects and handles device shake events.
    func onDeviceShake(isActive: Bool, action: @escaping () -> Void) -> some View {
        modifier(DeviceShakeViewModifier(isActive: isActive, action: action))
    }
}


// MARK: - Extension Dependencies
extension UIDevice {
    /// A notification that is posted when the device is shaken.
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

extension UIWindow {
    /// Overrides the motionEnded function to post a shake notification when the device is shaken.
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
    }
}
