//
//  TimerTest.swift
//  ReflexTrainerSound
//
//  Created by Henrieke Baunack on 6/30/24.
//

import SwiftUI
import Combine
import AVFAudio

// idea: adding the icon at the top of the view because it's adorable

// info on playing sounds
//https://developer.apple.com/documentation/avfaudio/avaudiosession/category/1616509-playback

struct TimerTest: View {
    @State private var timer: AnyCancellable?
    @State private var isRunning = false
    @State private var upperLimit = 5.0
    @State private var lowerLimit = 1.0
    @State private var intervals: [Double] = []
    @FocusState private var lowerLimitIsFocused: Bool
    @FocusState private var upperLimitIsFocused: Bool
    var audioPlayer = AudioPlayerClass()
    
    
    var body: some View {
        NavigationStack{
            Form {
                VStack(alignment: .center) {
                    Text("Interval limits in seconds")
                    HStack{
                        Spacer()
                        TextField("", value: $lowerLimit, format: .number)
                            .frame(width: 50)
                            .multilineTextAlignment(.center)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .focused($lowerLimitIsFocused)
                        
                        
                        
                        
                        Text("-").foregroundStyle(.secondary)
                        TextField("", value: $upperLimit, format: .number)
                            .frame(width: 50)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .focused($upperLimitIsFocused)
                        Spacer()
                    }
                    Button(action: {
                        if self.isRunning {
                            self.stopTimer()
                            UIApplication.shared.isIdleTimerDisabled = false
                            do {
                                try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
                                try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
                                try AVAudioSession.sharedInstance().setActive(true)
                                
                            }
                            catch {
                                print("New audio session for ambient cannot be initialized")
                            }
                        } else {
                            self.startTimer()
                            UIApplication.shared.isIdleTimerDisabled = true
                            do {
                                
                                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers])
                                try AVAudioSession.sharedInstance().setActive(true)
                            }
                            catch {
                                print("Could not create audio session")
                            }
                        }
                        self.isRunning.toggle()
                    }) {
                        Text(self.isRunning ? "Stop" : "Start")
                            .padding()
                    }
                    .disabled(upperLimit<lowerLimit)
                    .buttonStyle(BorderlessButtonStyle()) // so that only clicking in the frame triggers the button
                    Button("Reset", action: reset)
//                        .disabled(intervals.count<=0 || isRunning)
                        .disabled(isRunning) // resetting the change of interval makes sense as well, so reset only disabled when running
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
//            .onAppear{
//                UIApplication.shared.isIdleTimerDisabled = false
//            }
            .navigationTitle("POP UP NOW")
            .toolbar {
                if lowerLimitIsFocused || upperLimitIsFocused {
                    Button("Done"){
                        lowerLimitIsFocused = false
                        upperLimitIsFocused = false
                    }
                }
            }
            .onAppear{
                UIApplication.shared.isIdleTimerDisabled = false
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
