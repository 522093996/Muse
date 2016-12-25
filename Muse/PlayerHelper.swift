//
//  PlayerHelper.swift
//  Muse
//
//  Created by Marco Albera on 29/11/16.
//  Copyright © 2016 Edge Apps. All rights reserved.
//

// Generic protocol for a player application
// with AppleScript support
@objc protocol PlayerApplication {
    var isRunning: Bool { get }
}

protocol PlayerHelper {
    
    // MARK: Player application
    
    associatedtype Application: PlayerApplication
    
    var application: Application { get }
    
    // MARK: Player availability
    
    var isAvailable: Bool { get }
    
    // MARK: Song data
    
    var song: Song { get }
    
    // MARK: Playback controls
    
    func togglePlayPause()
    
    func nextTrack()
    
    func previousTrack()
    
    // MARK: Playback status
    
    var playbackPosition: Double { set get }
    
    var trackDuration: Double { get }
    
    func scrub(to doubleValue: Double?, touching: Bool)
    
    // MARK: Playback options
    
    var volume: Int { set get }
    
    var repeating: Bool { set get }
    
    var shuffling: Bool { set get }
    
    // MARK: Artwork
    
    func artwork() -> Any?
    
    // MARK: Callbacks
    
    var trackChangedHandler: () -> () { set get }
    
    var timeChangedHandler: (Bool, Double?) -> () { set get }
    
    // MARK: Application identifier
    
    static var bundleIdentifier: String { get }
    
    // MARK: Notification ID
    
    var notificationID: String { get }
    
}

extension PlayerHelper {
    
    // MARK: Player availability
    
    var isAvailable: Bool {
        // Returns if the application is running
        // ( implemented by SBApplication )
        return application.isRunning
    }
    
}
