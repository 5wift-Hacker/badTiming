//
//  CurrentStretchView.swift
//  iStretch
//
//  Created by John Newman on 24/5/2025.
//

import SwiftUI

struct CurrentStretchView: View {
    
    @Binding var timeRemaining: Double
    let currentStretch: Stretch
    
    let progress: Double
    
    let progressBarHeight: CGFloat = 50
    
    var body: some View {
        
        VStack {
            
            ZStack {
                
                Color.clear
                    .shadow(radius: 2, x: 1, y: 3)
                    .glassEffect(.regular.interactive(), in: .circle)
                    .shadow(radius: 2, x: 3, y: 5)
                    .frame(width: 380)
                
                Color.clear
                    .shadow(radius: 2, x: 1, y: 3)
                    .glassEffect(.regular.interactive(), in: .circle)
                    .shadow(radius: 2, x: 3, y: 5)
                    .frame(width: 350)
                                
                Image(currentStretch.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 320)
                    .glassEffect(.regular.interactive(), in: .circle)
                    .clipShape(.circle)
                    .shadow(radius: 2, x: 3, y: 5)
            }
            
            ZStack {
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // Background track of the progress bar
                        // MARK: - !!! Change 1: Removed cornerRadius from inner RoundedRectangle !!!
                        Rectangle()
                            .fill(.ultraThinMaterial) // Background color
                            .frame(height: progressBarHeight)
                        
                        // Foreground fill of the progress bar
                        Rectangle()
                            .fill(.progressbar) // Progress color
                            .frame(width: geometry.size.width * progress, height: progressBarHeight)
                            .animation(.linear(duration: 0.05), value: progress)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: progressBarHeight / 2))
                }
                .frame(width: 350, height: progressBarHeight) // Set the overall frame for the custom bar
                .glassEffect(.regular.interactive())
                .shadow(radius: 2, x: 3, y: 5)
                
                Text(currentStretch.name)
                    .font(.title2)
                    .fontDesign(.rounded)
                    .bold()
                    .foregroundStyle(.primary)
                
            }
        }
        
    }
}

#Preview {
    
    @Previewable @State var timeRemaining: Double = 10
    @Previewable var currentStretch: Stretch = Stretch(name: "test stretch", image: "lyinghamstringr", instructions: [])
    
    CurrentStretchView(timeRemaining: $timeRemaining, currentStretch: currentStretch, progress: 10)
}
