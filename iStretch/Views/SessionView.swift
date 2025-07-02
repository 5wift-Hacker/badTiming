//
//  ContentView.swift
//  iStretch
//
//  Created by John Newman on 24/5/2025.
//

import SwiftUI
import Combine

struct SessionView: View {
    
    let stretchType: StretchTypes
    
    @State private var currentStretchIndex: Int = 0
    @Environment(\.dismiss) var dismiss
    @State var triggerButtonCelebration: Bool = false
    @State var isDisabled: Bool = false
    
    @State var wasTimerActiveBeforeHelp: Bool = false
    
    var currentStretch: Stretch {
        if stretchType.stretches.indices.contains(currentStretchIndex) {
            return stretchType.stretches[currentStretchIndex]
        }else {
            return Stretch(name: "Session Complete", image: "checkmark.circle.fill", instructions: ["You finished everything! Time to go back and complete another session!"])
        }
    }
    
    @State var showHowToSheet: Bool = false
    
    @State private var timeRemaining: Double = 60.0
    
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    @State private var timerActive = false
    
    @State private var showFinishedAlert: Bool = false
    
    // Computed property for progress
    var progress: Double {
        // Ensure total duration is not zero to prevent division by zero
        let totalDuration = Double(currentStretch.duration)
        guard totalDuration > 0 else { return 0.0 }
        
        // Calculate progress: how much time has elapsed relative to total
        let elapsed = totalDuration - Double(timeRemaining)
        return elapsed / totalDuration
    }
    
    var body: some View {
        
            
            ZStack {
                
                LinearGradient(colors: [
                    stretchType.theme[0], stretchType.theme[1]
                ],
                               startPoint: .top,
                               endPoint: .bottom)
                
                .ignoresSafeArea()
                
                Color.black.ignoresSafeArea()
                    .opacity(progress * 0.6)
                    .animation(.linear(duration: 0.05), value: progress)
                
                VStack {
                    
                    CurrentStretchView(
                        timeRemaining: $timeRemaining,
                        currentStretch: currentStretch,
                        progress: progress)
                    
                    TimerButtonView(
                        timerActive: $timerActive,
                        timeRemaining: $timeRemaining,
                        triggerCelebration: $triggerButtonCelebration,
                        isDisabled: $isDisabled)
                    .padding(.bottom, 50)
                }
            }
            .sheet(isPresented: $showHowToSheet, onDismiss: {
                print("\(wasTimerActiveBeforeHelp)")
                if wasTimerActiveBeforeHelp {
                    timerActive = true
                }
            }) {
                StretchHowToSheet(stretch: stretchType.stretches[currentStretchIndex])
                    .presentationBackground(.ultraThinMaterial)
                    .presentationBackgroundInteraction(.enabled)
            }
            .overlay(alignment: .topLeading) {
                Button {
                    dismiss()
                    isDisabled = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundStyle(Color.buttoncolorset)
                        .padding(10)
                        .shadow(radius: 2, x: 1, y: 3)
                        .glassEffect(.regular.interactive(), in: .circle)
                        .shadow(radius: 2, x: 3, y: 5)
                        .padding(.leading, 50)
                }
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    wasTimerActiveBeforeHelp = timerActive
                    timerActive = false
                    showHowToSheet.toggle()
                    
                } label: {
                    Image(systemName: "info.circle")
                        .font(.title2)
                        .foregroundStyle(Color.buttoncolorset)
                        .padding(10)
                        .shadow(radius: 2, x: 1, y: 3)
                        .glassEffect(.regular.interactive(), in: .circle)
                        .shadow(radius: 2, x: 3, y: 5)
                        .padding(.trailing, 50)
                }
                //fix for going outside index crash
                .disabled(isDisabled)
                .opacity(isDisabled ? 0.5 : 1)
            }
        
        .navigationBarBackButtonHidden(true)
        .navigationTitle(stretchType.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if !stretchType.stretches.isEmpty {
                timeRemaining = stretchType.stretches[currentStretchIndex].duration
            }else {
                timeRemaining = 0
            }
            timerActive = false
        }
        .onReceive(timer) { _ in
            guard timerActive else {
                print("GUARD: Timer not active, returning.")
                return
            } // Only proceed if the timer is logically active
            
            
            if self.timeRemaining <= 0.05 {
                print("CONDITION MET: timeRemaining <= 0.05.")
                self.timeRemaining = 0.0
                timerActive = false
                self.triggerButtonCelebration = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    print("ASYNC AFTER: Delay finished. Calling moveToNextStretch().")
                    self.moveToNextStretch()
                    print("After moveToNextStretch: currentStretchIndex=\(currentStretchIndex), timeRemaining=\(timeRemaining), timerActive=\(timerActive), showFinishedAlert=\(showFinishedAlert)")
                    self.triggerButtonCelebration = false
                    print("triggerCelebration set to false.")
                    if currentStretchIndex < stretchType.stretches.count {
                        print("Reactivating timer: currentStretchIndex (\(currentStretchIndex)) < stretches.count (\(stretchType.stretches.count)) is TRUE.")
                        timerActive = true
                    }else {
                        print("NOT Reactivating timer: currentStretchIndex (\(currentStretchIndex)) < stretches.count (\(stretchType.stretches.count)) is FALSE. Timer remains inactive.")
                        // Explicitly ensure timerActive is false if session complete
                        timerActive = false
                    }
                    print("ASYNC AFTER END: timerActive=\(timerActive)")
                }
                print("  CONDITION MET END: timerActive=\(timerActive). Returning from this tick.")
                return
            }else {
                self.timeRemaining -= 0.05
                print("  Decrementing timeRemaining: \(timeRemaining)")
            }
            print("--- onReceive End ---")
        }
        .onChange(of: currentStretchIndex) { oldIndex, newIndex in
            // MARK: - !!! NEW: Additional safeguard for session completion !!!
            // If the currentStretchIndex moves beyond the last actual stretch,
            // ensure the timer is off.
            if newIndex >= stretchType.stretches.count {
                print("SessionView: onChange(currentStretchIndex) detected session complete. Setting timerActive = false.")
                timerActive = false
            } else if newIndex != oldIndex {
                // This part ensures timeRemaining is updated if moved to next stretch
                // You already do this in moveToNextStretch, but this provides a fallback/reinforcement.
                // It's generally better to let moveToNextStretch handle the timeRemaining update.
            }
        }
        .alert("Great Job!", isPresented: $showFinishedAlert) {
            Button("WOO! 🎉") {
                showFinishedAlert.toggle()
                isDisabled = true
            }
        } message: {
            Text("You finished all your stretches! Tap the X to go back and choose a new stretch type.")
        }
    }
    
    private func moveToNextStretch() {
        print("moveToNextStretch called. currentStretchIndex: \(currentStretchIndex), stretches.count: \(stretchType.stretches.count)")
        if currentStretchIndex < stretchType.stretches.count - 1 {
            currentStretchIndex += 1
            self.timeRemaining = Double(stretchType.stretches[currentStretchIndex].duration)
            print("  Moved to next stretch (\(currentStretchIndex)). New timeRemaining: \(timeRemaining).")
        } else {
            print("  Session complete. currentStretchIndex is last or beyond.")
            currentStretchIndex = stretchType.stretches.endIndex
            timerActive = false
            showFinishedAlert = true
            isDisabled = true
            print("  Session complete states set: timerActive=\(timerActive), showFinishedAlert=\(showFinishedAlert).")
        }
    }
}

#Preview {
    NavigationStack {
        SessionView(stretchType: recovery)
    }
}
