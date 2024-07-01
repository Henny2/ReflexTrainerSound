//
//  TimerTest.swift
//  ReflexTrainerSound
//
//  Created by Henrieke Baunack on 6/30/24.
//

import SwiftUI
import Combine

struct TimerTest: View {
    @State private var timer: AnyCancellable?
     @State private var isRunning = false

     var body: some View {
         VStack {
             Button(action: {
                 if self.isRunning {
                     self.stopTimer()
                 } else {
                     self.startTimer()
                 }
                 self.isRunning.toggle()
             }) {
                 Text(self.isRunning ? "Stop" : "Start")
                     .padding()
                     .background(Color.blue)
                     .foregroundColor(.white)
                     .cornerRadius(10)
             }
         }
     }

     private func startTimer() {
         scheduleTimer()
     }

     private func stopTimer() {
         timer?.cancel()
         timer = nil
     }

     private func scheduleTimer() {
         let randomInterval = Double.random(in: 1...5) // Random interval between 1 and 5 seconds
         timer = Timer.publish(every: randomInterval, on: .main, in: .common)
             .autoconnect()
             .sink { _ in
                 print("Timer triggered at interval: \(randomInterval) seconds")
                 self.timer?.cancel()
                 self.scheduleTimer() // Schedule the timer again with a new random interval
             }
     }
}

#Preview {
    TimerTest()
}
