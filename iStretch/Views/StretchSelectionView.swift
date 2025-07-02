//
//  StretchSelectionView.swift
//  iStretch
//
//  Created by John Newman on 24/5/2025.
//

import SwiftUI

//TODO: refine the UI in sessionview
//add images for currentstretchview
//go over info screens to confirm accuracy
//add notification sounds for finishing a stretch & finishing the session
//select / get background for app

//set ternary .dark color change for how to use app info button on main screen

//TODO: PROBLEMS TO SOLVE

/*
 BUG: running through all stretches
 */

//revert preferred color scheme later - pre launch
//update info button color - pre launch

//set up system where certain stretches run for different times - post launch

struct StretchSelectionView: View {
    
    @State private var path = NavigationPath()
    
    @State private var howTo = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                
//                Color.launchbackground.ignoresSafeArea()
                
//                Image("stretchselectbg")
//                    .resizable()
//                    .ignoresSafeArea()
                
                Image("cherry")
                    .resizable()
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        StretchSets(path: $path)
                    }
                    .padding(.top, 30)
                }
            }
            .navigationTitle("Stretch Sets")
            .navigationDestination(for: StretchTypes.self) { stretchType in
                SessionView(stretchType: stretchType)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        howTo.toggle()
                    }label: {
                        Image(systemName: "info.circle")
                            .font(.title2)
                            .foregroundStyle(Color.buttoncolorset)
                    }
                }
            }
            .sheet(isPresented: $howTo) {
                HowToUseView()
                    .presentationBackgroundInteraction(.enabled)
            }
        }
    }
}


#Preview {
    
    StretchSelectionView()
}

struct StretchSets: View {
    
    @Binding var path: NavigationPath
    
    var body: some View {
        
        Grid(alignment: .center, horizontalSpacing: 20, verticalSpacing: 20) {
                
                GridRow {
                    
                    ForEach(stretchTypes.prefix(2)) { stretchType in
                        SelectStretchSessionButton(stretchType: stretchType, path: $path)
                    }
                }
                
                GridRow {
                    
                    ForEach(stretchTypes.dropFirst(2).prefix(2)) { stretchType in
                        SelectStretchSessionButton(stretchType: stretchType, path: $path)
                    }
                }
            }
        .padding()
    }
}

#Preview {
    @Previewable @State var previewPath = NavigationPath()
    StretchSets(path: $previewPath)
}

struct SelectStretchSessionButton: View {
    
    let stretchType: StretchTypes
    @Binding var path: NavigationPath
    
    
    var body: some View {
        
        Button {
            path.append(stretchType)
        } label: {
            VStack(spacing: 25) {
                
                //add init image here for Stretch Types
                Image(systemName: stretchType.image)
                    .font(.system(size: 60))
                
                Text(stretchType.name)
                    .font(.title2)
            }
            .bold()
            .foregroundStyle(.buttoncolorset)
            .fontDesign(.rounded)
            .frame(minHeight: 180)
            .frame(maxWidth: .infinity)
            .shadow(radius: 5, x: 2, y: 5)
        }
        .buttonStyle(SelectStretchSessionGlassButtonStyle(cornerRadius: 20))
        .shadow(radius: 5, x: 2, y: 5)
    }
    
}

struct SelectStretchSessionGlassButtonStyle: ButtonStyle {
    let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        // Apply the interactive glass effect directly to the label's content
        // and specify the shape here for the interactive part.
            .glassEffect(.regular.interactive(), in: RoundedRectangle(cornerRadius: cornerRadius))
        // You can add your internal shadow here if it's meant to be within the glass
            .shadow(radius: 5, x: 2, y: 5)
        // Apply scale effect for interactive feedback, if the .glassEffect doesn't fully handle it
        // or if you want custom control. The .interactive() should provide some,
        // but you can fine-tune it.
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0) // Slight scale on press
            .animation(.interpolatingSpring(stiffness: 300, damping: 20), value: configuration.isPressed)
            .contentShape(RoundedRectangle(cornerRadius: cornerRadius)) // Ensures tap area matches visual
    }
}
