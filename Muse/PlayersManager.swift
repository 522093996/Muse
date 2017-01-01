//
//  PlayersManager.swift
//  Muse
//
//  Created by Marco Albera on 31/12/16.
//  Copyright © 2016 Edge Apps. All rights reserved.
//

// Available players
enum PlayerID {
    case spotify
    case vox
}

// Default player's id (Spotify)
let defaultPlayerID: PlayerID = .spotify

class PlayersManager {
    
    // MARK: Constructors
    
    static let shared = PlayersManager()
    
    private init() { }
    
    // MARK: Dictionary
    
    typealias PlayersDictionary = [PlayerID: PlayerHelper]
    
    // The players dictionary
    private let playersDictionary: PlayersDictionary = [.spotify: SpotifyHelper.shared,
                                                        .vox: VoxHelper.shared]
    
    // Interaction functions
    
    func get(_ id: PlayerID) -> PlayerHelper {
        // Return a requested helper
        return playersDictionary[id]!
    }
    
    // MARK: Player vars
    
    var designatedHelper: PlayerHelper {
        // Find the first player that's runninng and playing
        for (_, helper) in playersDictionary {
            if helper.isAvailable && helper.isPlaying {
                return helper
            }
        }
        
        // Return default helper otherwise
        return defaultHelper
    }
    
    var defaultHelper: PlayerHelper {
        // Returns the default player
        return get(defaultPlayerID)
    }
    
}
