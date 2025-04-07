//
//  ShakeViewModel.swift
//  DeviceShakeDemo
//
//  Created by Nikolai Nobadi on 4/6/25.
//

import Foundation

final class ShakeViewModel: ObservableObject {
    @Published var shakeCount = 0
    @Published var isActive = true
    @Published var shakeTrigger = false
    
    private let shakeLimit: Int
    private let shakePhasesCount: Int
    private let stepDuration: TimeInterval
    
    init(shakeLimit: Int, shakePhasesCount: Int, stepDuration: TimeInterval) {
        self.shakeLimit = shakeLimit
        self.shakePhasesCount = shakePhasesCount
        self.stepDuration = stepDuration
    }
}


// MARK: - Actions
extension ShakeViewModel {
    func enableShake() {
        isActive = true
    }
    
    func handleShake() {
        shakeCount += 1
        shakeTrigger.toggle()
        
        if shakeCount % shakeLimit == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                self.isActive = false
            }
        }
    }
}


// MARK: - Private
private extension ShakeViewModel {
    var animationDuration: TimeInterval {
        return stepDuration * Double(shakePhasesCount - 1)
    }
}
