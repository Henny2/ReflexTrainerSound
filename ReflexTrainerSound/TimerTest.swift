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
    @State private var upperLimit = 30.0
    @State private var lowerLimit = 10.0
    var audioPlayer = AudioPlayerClass()

     var body: some View {
         VStack(alignment: .center) {
             Text("Lower interval limit - Upper interval limit")
             HStack{
                 Spacer()
                 TextField("Enter the lower interval limit", value: $lowerLimit, format: .number)
                     .frame(width: 50)
                     .multilineTextAlignment(.center)
//                     .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                     .textFieldStyle(.roundedBorder)
                     
                 
                 

                 Text("-").foregroundStyle(.secondary)
                 TextField("Enter the upper interval limit", value: $upperLimit, format: .number)
                     .frame(width: 50)
                     .textFieldStyle(.roundedBorder)
                     .multilineTextAlignment(.center)
//                     .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                 Spacer()
             }
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
         let randomInterval = Double.random(in: lowerLimit...upperLimit) // Random interval between 1 and 5 seconds
         timer = Timer.publish(every: randomInterval, on: .main, in: .common)
             .autoconnect()
             .sink { _ in
                 audioPlayer.playSound()
                 print("Timer triggered at interval: \(randomInterval) seconds")
                 self.timer?.cancel()
                 self.scheduleTimer() // Schedule the timer again with a new random interval
             }
     }
}

#Preview {
    TimerTest()
}
