//
//  StretchHowToSheet.swift
//  iStretch
//
//  Created by John Newman on 30/5/2025.
//

import SwiftUI

struct StretchHowToSheet: View {
    
    let stretch: Stretch
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 50) {
                        
                        ForEach(stretch.instructions.indices, id: \.self) { index in
                            
                            HStack(alignment: .top) {
                                
                                Text("\(index + 1).")
                                    .font(.title3)
                                    .padding(.leading, 35)
                                Text("\(stretch.instructions[index])")
                                    .font(.title)
                                    .padding(.horizontal, 10)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.top, 40)
            }
            .navigationTitle("How-To: \(stretch.name)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    StretchHowToSheet(stretch: Stretch(name: "Stretch", image: "", instructions: ["Try to curl into a ball, while laying on your back", "Open your mouth while I feed you nonsense", "Learn to code faster, you damn moron"]))
}
