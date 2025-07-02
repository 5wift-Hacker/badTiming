//
//  TimerButton.swift
//  iStretch
//
//  Created by John Newman on 24/5/2025.
//

import SwiftUI

import SwiftUI

struct TimerButtonView: View {
    
    @Binding var timerActive: Bool
    @Binding var timeRemaining: Double
    @Binding var triggerCelebration: Bool
    @Binding var isDisabled: Bool
    
    @State var tapBounceScale: CGFloat = 1.0
    @State var localCelebratoryBounce: Bool = false
    
    var body: some View {
        Button(action: {
            if !timerActive { // This is the "Start" action
                
                timerActive = true // This is the crucial line that triggers SessionView's onChange
                localCelebratoryBounce = false
            } else { // This is the "Stop and Reset" action
                timeRemaining = 60 // Reset to original duration (or 3 for testing)
                timerActive = false // This will trigger SessionView's onChange to cancel subscription
                localCelebratoryBounce = false
            }
        }, label: {
            Image(systemName: timerActive ? "arrow.trianglehead.counterclockwise" : "play.circle.fill")
                .font(.system(size: timerActive ? 40 : 50))
                .offset(CGSize(width: 0, height: timerActive ? -1.2 : 0))
                .foregroundStyle(.white)
                .animation(.easeOut(duration: 0.5), value: timerActive)
        })
        .frame(width: 55, height: 55)
        .padding(5)
        .shadow(radius: 2, x: 1, y: 3)
        .glassEffect(.regular.interactive())
        .shadow(radius: 2, x: 3, y: 5)
        
        .scaleEffect(tapBounceScale)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.interpolatingSpring(stiffness: 170, damping: 8)) {
                        tapBounceScale = 0.7
                    }
                }
                .onEnded { _ in
                    withAnimation(.interpolatingSpring(stiffness: 170, damping: 8)) {
                        tapBounceScale = 1.0
                    }
                }
        )
        .scaleEffect(localCelebratoryBounce ? 1.2 : 1, anchor: .center)
        .animation(.interpolatingSpring(stiffness: 170, damping: 8), value: localCelebratoryBounce)
        
        .onChange(of: triggerCelebration) { oldValue, newValue in
            if newValue {
                localCelebratoryBounce = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    localCelebratoryBounce = false
                }
            }
        }
        .disabled(isDisabled)
    }
}


#Preview {
    
    @Previewable @State var timeRemaining: Double = 10
    
    @Previewable @State var timerActive: Bool = false
    
    @Previewable @State var triggerCelebration: Bool = false
    @Previewable @State var isDisabled: Bool = false
    
    TimerButtonView(timerActive: $timerActive, timeRemaining: $timeRemaining, triggerCelebration: $triggerCelebration, isDisabled: $isDisabled)
}
