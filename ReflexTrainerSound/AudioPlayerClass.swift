//
//  AudioPlayerClass.swift
//  ReflexTrainerSound
//
//  Created by Henrieke Baunack on 6/30/24.
//

import Foundation
import AVFoundation


// todo: I want to reset the audio session when they stop playing

class AudioPlayerClass: NSObject, AVAudioPlayerDelegate {
    var player: AVAudioPlayer?
    
    func playSound() {
        // creating an audio session to change how the audio is gonna be played
//        do {
//            // playback:stop existing audio that is playing
//            // ambient: music keeps playing
//            // playback with "duckOthers" is a mix of both
//            //using ambient because I want to be able to listen to music at the same time
//            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
//            // docking defeats the reflex purpose so not using it here, but together with deactivating the session after playing it would get back to normal volume afterwards
////            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers])
//            try AVAudioSession.sharedInstance().setActive(true)
//        }
//        catch {
//            print("Could not create audio session")
//        }
//        guard let path = Bundle.main.path(forResource: "refereeWhistle", ofType:"mp3") else {
        guard let path = Bundle.main.path(forResource: "beepSound", ofType:"mp3") else {
            print("Cannot find file")
            return }
        let url = URL(fileURLWithPath: path)

        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.play()
            self.player?.delegate = self 
            print("playing")
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    // not gonna enforce the finishing because the time intervals might be too short, so just leaving this here for knowledge :)
    // this is also the reason I am not resetting the Audio Session as recommended here https://blog.kulman.sk/correctly-playing-audio-in-ios-apps/
//    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        print("Did finish Playing")
//        // this resets the volume from "dockingOthers" but I don't like it in the reflex setting so not necessary here
//        try! AVAudioSession.sharedInstance().setActive(false)
//       }
}
