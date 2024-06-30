//
//  AudioPlayerClass.swift
//  ReflexTrainerSound
//
//  Created by Henrieke Baunack on 6/30/24.
//

import Foundation
import AVFoundation

class AudioPlayerClass {
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "refereeWhistle", ofType:"mp3") else {
            print("Cannot find file")
            return }
        let url = URL(fileURLWithPath: path)

        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.play()
            print("playing")
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
