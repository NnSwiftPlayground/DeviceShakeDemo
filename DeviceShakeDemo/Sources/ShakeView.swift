//
//  ShakeView.swift
//  DeviceShakeDemo
//
//  Created by Nikolai Nobadi on 4/6/25.
//

import SwiftUI

struct ShakeView: View {
    @StateObject private var viewModel: ShakeViewModel
    
    let phases: [CGFloat]
    let duration: TimeInterval
    
    init(phases: [CGFloat] = [0, -50, 50, 0], duration: TimeInterval = 0.1, shakeLimit: Int = 3) {
        self.phases = phases
        self.duration = duration
        self._viewModel = .init(wrappedValue: .init(shakeLimit: shakeLimit, shakePhasesCount: phases.count, stepDuration: duration))
    }

    var body: some View {
        VStack(spacing: 20) {
            AnimatedImage(trigger: viewModel.shakeTrigger, phases: phases, duration: duration)

            Text("Shake count: \(viewModel.shakeCount)")
                .font(.title2)
                .bold()

            if viewModel.isActive {
                Text("Shake the device!")
                    .font(.headline)
            } else {
                ShakeLimitView(enableShake: viewModel.enableShake)
            }
        }
        .padding()
        // 🟡 Primary Feature: Detect device shake using a custom ViewModifier
        .onDeviceShake(isActive: viewModel.isActive) {
            viewModel.handleShake()
        }
    }
}


// MARK: - Animated Image
private struct AnimatedImage: View {
    let trigger: Bool
    let phases: [CGFloat]
    let duration: TimeInterval

    var body: some View {
        PhaseAnimator(phases, trigger: trigger) { phase in
            Image(systemName: "iphone.gen3.radiowaves.left.and.right")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.blue)
                .offset(x: phase)
        } animation: { _ in
            .easeInOut(duration: duration)
        }
    }
}


// MARK: - ShakeLimitView
private struct ShakeLimitView: View {
    let enableShake: () -> Void
    
    var body: some View {
        VStack {
            Text("You've shaken enough! Take a break.")
                .font(.headline)
                .foregroundStyle(.red)

            Button("Let Me Shake!!!", action: enableShake)
                .padding(.top, 10)
                .buttonStyle(.borderedProminent)
        }
    }
}
