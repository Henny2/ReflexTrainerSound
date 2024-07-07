//
//  TimerTest.swift
//  ReflexTrainerSound
//
//  Created by Henrieke Baunack on 6/30/24.
//

import SwiftUI
import Combine

// need to make sure the sounds are playing even if silent mode is on
//https://developer.apple.com/documentation/avfaudio/avaudiosession/category/1616509-playback

struct TimerTest: View {
    @State private var timer: AnyCancellable?
    @State private var isRunning = false
    @State private var upperLimit = 5.0
    @State private var lowerLimit = 1.0
    @State private var intervals: [Double] = []
    var audioPlayer = AudioPlayerClass()

     var body: some View {
         Form {
             VStack(alignment: .center) {
                 Text("Interval limits in seconds")
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
                 }
                 .disabled(upperLimit<lowerLimit)
                 .buttonStyle(BorderlessButtonStyle()) // so that only clicking in the frame triggers the button
                 Button("Reset", action: reset)
                 .disabled(intervals.count<=0 || isRunning)
                 .buttonStyle(BorderlessButtonStyle())
             }
             // make another VStack and print the trigger times of the run through
             Section("Intervals") {
                 List() {
                     ForEach(intervals, id: \.self) {
                             Text("\($0, specifier: "%.1f")")
                         }
                     
                 }
             }
         }
        
     }
    private func reset() {
        intervals = []
        upperLimit = 5.0
        lowerLimit = 1.0
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
                 intervals.append(randomInterval)
                 self.timer?.cancel()
                 self.scheduleTimer() // Schedule the timer again with a new random interval
             }
     }
}

#Preview {
    TimerTest()
}
