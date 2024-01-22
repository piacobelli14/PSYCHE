//
//  PSYCHEPatients.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/21/24.
//

import SwiftUI

struct PSYCHEPatients: View {
    @Binding var currentView: AppView
    @State private var isChecked = false
    @State private var patientList = false
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x152234), Color(hex: 0x1D2951)]), startPoint: .top, endPoint: .bottom)
               .frame(maxWidth: .infinity, maxHeight: .infinity)
               .edgesIgnoringSafeArea(.all)
            
            VStack {
                GeometryReader { geometry in
                    VStack(alignment: .center) {
                        Spacer()
                        
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: geometry.size.width * 0.7)
                            .frame(height: geometry.size.height * 0.001)
                        
                        HStack(spacing: geometry.size.width * 0.08) {
                            Spacer()
                            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                                .foregroundColor(isChecked ? Color(hex: 0x4E7FD5) : .white)
                                .font(.system(size: geometry.size.height * 0.02))
                                .onTapGesture {
                                    isChecked.toggle()
                                }
                            
                            Text("Name")
                                .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                            
                            Text("ID #")
                                .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                            
                            Text("Age")
                                .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                            
                            Text("Sex")
                                .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                            
                            Text("Unit")
                                .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                            
                            Spacer()
                        }
                                    
                             
                        Spacer()
                    }
                        
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onAppear {
            fetchPatientInfo()
        }
    }
    private func fetchPatientInfo() {
        
        let url = URL(string: "http://172.20.10.3:8001/get-patients")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
               return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                return
            }
            
            if response.statusCode == 200 {
                currentView = .Login
            }
        }
        .resume()
    }
}

