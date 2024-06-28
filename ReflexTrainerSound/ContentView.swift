//
//  ContentView.swift
//  ReflexTrainerSound
//
//  Created by Henrieke Baunack on 6/27/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        Button("Play sound"){
            AudioServicesPlaySystemSound(1103)
            // test
        }
    }
}

#Preview {
    ContentView()
}
