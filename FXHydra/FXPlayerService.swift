//
//  FXPlayerService.swift
//  FXHydra
//
//  Created by kioshimafx on 3/13/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import Foundation
import StreamingKit
import AVFoundation

class FXPlayerService : NSObject, STKAudioPlayerDelegate {

    //
    // Shared instance
    //
    
    let audioPlayer = STKAudioPlayer()
    
    private static let shared = FXPlayerService()
    
    static func sharedManager() -> FXPlayerService {
        return shared
    }
    
    // vars
    
    var currentAudioPlayed:FXAudioItemModel = FXAudioItemModel()
    
    var currentAudiosArray = [FXAudioItemModel]()
    var currentAudioInArray = 0
    
    override init() {
        super.init()
        
        audioPlayer.delegate = self
        
    }
    
    
    func startPlayAudioModel(model:FXAudioItemModel) {
        
        self.audioPlayer.play(model.audioNetworkURL)
    
        self.currentAudioPlayed = model
        self.checkAudioSession()
    }
    
    func checkAudioSession() {
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            try audioSession.setActive(true)
            
            UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
            
        } catch {
            log.error("audio session register error")
        }
        
    }
    
    
    // stk delegate
    
    /// Raised when an item has started playing
    func audioPlayer(audioPlayer: STKAudioPlayer, didStartPlayingQueueItemId queueItemId: NSObject) {
        //
        log.info("didStartPlayingQueueItemId ::: \(queueItemId)")
        
    }
    
    /// Raised when an item has finished buffering (may or may not be the currently playing item)
    /// This event may be raised multiple times for the same item if seek is invoked on the player
    func audioPlayer(audioPlayer: STKAudioPlayer, didFinishBufferingSourceWithQueueItemId queueItemId: NSObject) {
        log.debug("didFinishBufferingSourceWithQueueItemId ::: \(queueItemId)")
    }
    
    /// Raised when an item has finished playing
    func audioPlayer(audioPlayer: STKAudioPlayer, didFinishPlayingQueueItemId queueItemId: NSObject, withReason stopReason: STKAudioPlayerStopReason, andProgress progress: Double, andDuration duration: Double) {
        log.debug("didFinishPlayingQueueItemId ::: \(queueItemId)")
    }
    
    /// Raised when the state of the player has changed
    func audioPlayer(audioPlayer: STKAudioPlayer, stateChanged state: STKAudioPlayerState, previousState: STKAudioPlayerState) {
        log.debug("audioPlayer stateChanged ::: state : \(state.rawValue) , prevState : \(previousState.rawValue)")
    }
    
    /// Raised when an unexpected and possibly unrecoverable error has occured (usually best to recreate the STKAudioPlauyer)
    func audioPlayer(audioPlayer: STKAudioPlayer, unexpectedError errorCode: STKAudioPlayerErrorCode) {
        log.error("audioPlayer error ::: \(errorCode)")
    }
    
    /// Optionally implemented to get logging information from the STKAudioPlayer (used internally for debugging)
    func audioPlayer(audioPlayer: STKAudioPlayer, logInfo line: String) {
        //log.debug("audioPlayer info ::: \(line)")
    }
    
    /// Raised when items queued items are cleared (usually because of a call to play, setDataSource or stop)
    func audioPlayer(audioPlayer: STKAudioPlayer, didCancelQueuedItems queuedItems: [AnyObject]) {
        log.debug("didCancelQueuedItems info ::: \(queuedItems)")
    }
    
}
