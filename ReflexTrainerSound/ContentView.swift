//
//  ContentView.swift
//  ReflexTrainerSound
//
//  Created by Henrieke Baunack on 6/27/24.
//


// tutorial for playing sounds

import SwiftUI
import AVFoundation

struct ContentView: View {
    var audioPlayer = AudioPlayerClass()
    @State private var isRunning = false

    var body: some View {
        VStack {
            Button(action: {
                if self.isRunning {
                    // stop running
                    print("stop")
                    do {
                        try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
                        try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
                        try AVAudioSession.sharedInstance().setActive(true)
                    }
                    catch {
                        print("New audio session for ambient cannot be initialized")
                    }
                                          
//                    do {
//                        try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
//                        try AVAudioSession.sharedInstance().setActive(true)
//                    }
//                    catch {
//                        print("New audio session for ambient cannot be initialized")
//                    }
//                    UIApplication.shared.isIdleTimerDisabled = false
                } else {
                    // start running
                    do {
//                        try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
                        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers])
                        try AVAudioSession.sharedInstance().setActive(true)
                    }
                    catch {
                        print("Could not create audio session")
                    }
                    audioPlayer.playSound()
                    UIApplication.shared.isIdleTimerDisabled = true
                }
                self.isRunning.toggle()
            }) {
                Text(self.isRunning ? "Stop" : "Start")
                    .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
