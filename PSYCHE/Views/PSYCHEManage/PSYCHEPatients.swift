//
//  PSYCHEPatients.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/21/24.
//

import SwiftUI

struct PSYCHEPatients: View {
    @Binding var currentView: AppView
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x152234), Color(hex: 0x1D2951)]), startPoint: .top, endPoint: .bottom)
               .frame(maxWidth: .infinity, maxHeight: .infinity)
               .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                HStack {
                    Button(action: {
                        currentView = .Login
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                            .font(.system(size: geometry.size.height * 0.015))
                    }
                    .background(
                        Circle()
                            .fill(Color.white)
                            .frame(width: geometry.size.width * 0.04, height: geometry.size.height * 0.04)
                            .shadow(color: Color(hex: 0x4E7FD5), radius: 5, x: 0, y: 0)
                    )
                    .padding(.top, geometry.size.height * 0.03)
                    .padding(.leading, geometry.size.height * 0.035)
                    Spacer()
                }
                
                VStack {
                    
                    
                    
                    
                }
            }
        }

    }
}
