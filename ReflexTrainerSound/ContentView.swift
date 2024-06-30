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

    var body: some View {
//        Button("Play sound"){
//            AudioServicesPlaySystemSound(1103)
//            // test
//        }
        VStack {
                   Button(action: {
                       audioPlayer.playSound()
                   }) {
                       Text("Play Sound")
                           .font(.largeTitle)
                           .padding()
                           .background(Color.blue)
                           .foregroundColor(.white)
                           .cornerRadius(10)
                   }
               }
    }
    

}

#Preview {
    ContentView()
}
