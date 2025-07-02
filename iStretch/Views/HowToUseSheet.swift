//
//  HowToUseView.swift
//  iStretch
//
//  Created by John Newman on 25/5/2025.
//

import SwiftUI

struct HowToUseView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
               
                VStack(alignment: .leading, spacing: 50) {
                    
                    Text("Step 1: Choose the stretch category that will help you the most in the moment, and tap that category.")
                    
                    Text("Step 2: Review the stretch on the screen, and press start to initiate the timer.")
                    
                    Text("Step 3: Complete each stretch for the 60 seconds on the timer. The screen will automatically swap to the next stretch on the list until you complete all of them.")
                    
                    Text("Step 4: Finish the routine and relax. OR go back and run through another category of stretches.")
                }
                .foregroundStyle(.primary)
                .font(.title3)
                .bold()
                .padding(.horizontal)
            }
            
            .safeAreaInset(edge: .bottom, content: {
                VStack {
                    Text("You can never be too flexible!")
                        .foregroundStyle(.primary)
                        .font(.title3)
                        .bold()
                        .padding(.bottom)
                }
            })
            .navigationTitle("How To Use The App")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrowshape.down.circle")
                            .font(.title2)
                            .foregroundStyle(Color.buttoncolorset)
                    }
                }
            }
        }
    }
}

#Preview {
    HowToUseView()
}
