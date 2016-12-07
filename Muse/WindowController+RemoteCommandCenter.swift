//
//  WindowController+RemoteCommandCenter.swift
//  Muse
//
//  Created by Marco Albera on 04/12/16.
//  Copyright © 2016 Edge Apps. All rights reserved.
//

import Foundation
import MediaPlayer

extension WindowController {
    
    func togglePlayPause(event: MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus {
        spotifyHelper.togglePlayPause()
        
        updateNowPlayingInfo()
        
        return .success
    }
    
    func changePlaybackPosition(event: MPChangePlaybackPositionCommandEvent) -> MPRemoteCommandHandlerStatus {
        self.song.playbackPosition = event.positionTime.rounded()
        updateNowPlayingInfoElapsedPlaybackTime()
        
        spotifyHelper.goTo(time: Double(self.song.playbackPosition))
        
        updateNowPlayingInfo()
        
        return .success
    }
    
    func previousTrack(event: MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus {
        self.song.playbackPosition = 0
        updateNowPlayingInfoElapsedPlaybackTime()
        
        spotifyHelper.previousTrack()
        
        updateNowPlayingInfo()
        
        return .success
    }
    
    func nextTrack(event: MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus {
        self.song.playbackPosition = 0
        updateNowPlayingInfoElapsedPlaybackTime()
        
        spotifyHelper.nextTrack()
        
        updateNowPlayingInfo()
        
        return .success
    }
    
    func updateNowPlayingInfo() {
        self.nowPlayingInfo = [
            MPMediaItemPropertyTitle: self.song.name,
            MPMediaItemPropertyArtist: self.song.artist,
            MPMediaItemPropertyAlbumTitle: self.song.album,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: self.song.playbackPosition,
            MPMediaItemPropertyPlaybackDuration: self.song.duration,
            MPNowPlayingInfoPropertyMediaType: MPNowPlayingInfoMediaType.audio.rawValue
        ]
        
        // MediaPlayer nowPlayingInfo
        nowPlayingInfoCenter.nowPlayingInfo = self.nowPlayingInfo
        
        // Update playbackState accordingly
        nowPlayingInfoCenter.playbackState = self.song.isPlaying ? .playing : .paused
    }
    
    func updateNowPlayingInfoElapsedPlaybackTime() {
        self.nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.song.playbackPosition
        
        nowPlayingInfoCenter.nowPlayingInfo = self.nowPlayingInfo
    }
    
    func prepareRemoteCommandCenter() {
        // Play/pause toggle
        remoteCommandCenter.playCommand.activate(self, action: #selector(togglePlayPause(event:)))
        remoteCommandCenter.pauseCommand.activate(self, action: #selector(togglePlayPause(event:)))
        
        // Previous/next track toggle
        // Apparently these work only on 10.12.2+
        remoteCommandCenter.previousTrackCommand.activate(self, action: #selector(previousTrack(event:)))
        remoteCommandCenter.nextTrackCommand.activate(self, action: #selector(nextTrack(event:)))
        
        // Scrub bar control
        remoteCommandCenter.changePlaybackPositionCommand.activate(self, action: #selector(changePlaybackPosition(event:)))
    }
    
}
