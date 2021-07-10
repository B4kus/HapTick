//
//  File.swift
//  
//
// Created by Szymon Szysz on 15/04/2021.
//

import CoreHaptics

public protocol HapticsEventManaging {
    func resetHapticEngine()
    func engineFailureMessage()
    func playPattern(type: HapticsEventType) throws
    func stopHapticEngine()
    func startHapticEngine()
    var isHapticEngineRunning: Bool { get }
}

public final class HapticsEventManager: HapticsEventManaging {
    
    // MARK: -  Singleton
    
    public static let shared: HapticsEventManaging = HapticsEventManager()
    
    // MARK: - Properties
    
    public var supportsHaptics: Bool = false
    public var supportsAudio: Bool = false
    private let userDefaults = UserDefaults.standard
    public var isHapticEngineRunning: Bool
    
    // MARK: - Configuration
    
    private var engine: CHHapticEngine?
    
    // MARK: - Initialization
    
    public init() {
        self.isHapticEngineRunning = userDefaults.bool(forKey: "isHapticEngineRunning")
        hapticCapability()
        initializeHapticEngine()
    }
    
    // MARK: - Haptic Initialization
    
    private func hapticCapability() {
        let hapticCapability = CHHapticEngine.capabilitiesForHardware()
        supportsHaptics = hapticCapability.supportsHaptics
        supportsAudio = hapticCapability.supportsAudio
    }
    
    private func initializeHapticEngine() {
        guard supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            isHapticEngineRunning = true
        } catch let error {
            fatalError("Engine Creation Error: \(error)")
        }
    }
    
    // MARK: - Engine methods
    
    public func resetHapticEngine() {
        engine?.resetHandler = {
            do {
                try self.engine?.start()
                self.isHapticEngineRunning = true
            } catch {
                fatalError("Failed to restart the engine: \(error)")
            }
        }
    }
    
    public func stopHapticEngine() {
        engine?.stop(completionHandler: nil)
        isHapticEngineRunning = false
        userDefaults.setValue(false, forKey: "isHapticEngineRunning")
    }
    
    public func startHapticEngine() {
        try? self.engine?.start()
        isHapticEngineRunning = true
        userDefaults.setValue(true, forKey: "isHapticEngineRunning")
    }
    
    public func engineFailureMessage() {
        engine?.stoppedHandler = { reason in
            self.isHapticEngineRunning = false
            print("Stop Handler: The engine stopped for reason: \(reason.rawValue)")
            switch reason {
            case .audioSessionInterrupt: print("Audio session interrupt")
            case .applicationSuspended: print("Application suspended")
            case .idleTimeout: print("Idle timeout")
            case .systemError: print("System error")
            case .notifyWhenFinished: print("Notify when finished")
            case .engineDestroyed: print("Engine destroyed")
            case .gameControllerDisconnect: print("Game controller disconnect")
            @unknown default: print("Unknown error")
            }
        }
    }
    
    // MARK: - Engine usage
    
    public func playPattern(type: HapticsEventType) throws {
        guard isHapticEngineRunning else { return }
        guard let events = type.hapticPattern?.events else { return }
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try engine?.start()
            try player?.start(atTime: CHHapticTimeImmediate)
        } catch {
            fatalError("Fail to play pattern")
        }
    }
}

