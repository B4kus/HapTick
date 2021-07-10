//
//  HapticsEventType.swift
//
//
//  Created by Szymon Szysz on 15/04/2021.
//

import UIKit
import CoreHaptics

public enum HapticsEventType {
    case success
    case warning
    case error
    case back
    case confirm
    case press
    case custom(events: [HapticEvent])
    
    public var hapticPattern: HapticEvent? {
        switch self {
        case .success: return HapticEvent(events: [
                                            CHHapticEvent(eventType: .hapticTransient, parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.78), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.49)], relativeTime: .zero, duration: .zero),
                                            CHHapticEvent(eventType: .hapticTransient, parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.49)], relativeTime: 0.16, duration: .zero)]
        )
        case .warning: return HapticEvent(events: [
                                            CHHapticEvent(eventType: .hapticTransient, parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.82)], relativeTime: .zero, duration: .zero),
                                            CHHapticEvent(eventType: .hapticTransient, parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.64), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.51)], relativeTime: 0.20, duration: .zero)]
        )
        case .error: return HapticEvent(events: [
                                            CHHapticEvent(eventType: .hapticTransient, parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.75), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.50)], relativeTime: .zero, duration: .zero),
                                            CHHapticEvent(eventType: .hapticTransient, parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.50)], relativeTime: 0.20, duration: .zero),
                                            CHHapticEvent(eventType: .hapticTransient, parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.60)], relativeTime: 0.20, duration: .zero),
                                            CHHapticEvent(eventType: .hapticTransient, parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.50), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.30)], relativeTime: 0.20, duration: .zero)]
                                        
        )
        case .press: return HapticEvent(events: [CHHapticEvent(eventType: .hapticTransient, parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.48), CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.90)], relativeTime: .zero)])
        case .back: return HapticEvent(events: [CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: .zero)])
        default: return nil
        }
    }
}

