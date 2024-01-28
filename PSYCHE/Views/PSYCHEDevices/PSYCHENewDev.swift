//
//  PSYCHENewDev.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/24/24.
//

import SwiftUI
import UIKit
import SceneKit

struct PSYCHENewDev: View {
    @Binding var currentView: AppView
    
    @State private var devType: String = ""
    @State private var devID: String = ""
    
    let types = ["Fitbit Sense"]
    
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x1D2951), Color(hex: 0x1D2951)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            AnimatedStarsView()
            
            VStack {
                GeometryReader { geometry in
                    HStack {
                        Button(action: {
                            currentView = .Patients
                        }) {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width * 0.01)
                                .frame(height: geometry.size.height * 0.01)
                                .foregroundColor(.black)
                        }
                        .background(
                            Circle()
                                .fill(Color.white)
                                .frame(width: geometry.size.width * 0.05, height: geometry.size.height * 0.05)
                                .shadow(color: Color(hex: 0x4E7FD5), radius: 5, x: 0, y: 0)
                                .opacity(0.9)
                        )
                        .padding(.top, geometry.size.height * 0.03)
                        .padding(.leading, geometry.size.height * 0.035)
                    }
                    
                    VStack(alignment: .center) {
                        Spacer()
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                VStack(alignment: .center) {
                                    HStack {
                                        Spacer()
                                        Text("New Device Type")
                                            .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                            .foregroundColor(.white)
                                            .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Spacer()
                                        Menu {
                                            ForEach(types, id: \.self) { type in
                                                Button(type) {
                                                    devType = type
                                                }
                                            }
                                        } label: {
                                            Text(devType == "" ? "Select Device Type" : devType)
                                                .multilineTextAlignment(.center).foregroundColor(.black)
                                                .padding(.horizontal, geometry.size.width * 0.15)
                                                .padding(.vertical, geometry.size.width * 0.02)
                                                .font(.system(size: geometry.size.height * 0.014, weight: .light))
                                                .multilineTextAlignment(.center)
                                                .background(Color(hex: 0xF6FCFE))
                                                .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
                                                .cornerRadius(geometry.size.width * 0.01)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                                        .stroke(Color(hex: 0xDFE6E9), lineWidth: geometry.size.width * 0.004)
                                                )
                                                .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                        }
                                        .accentColor(.black)
                                        Spacer()
                                    }
                                }
                                .background(Color(hex: 0x1D2951))
                                
                                VStack(alignment: .center) {
                                    HStack {
                                        Spacer()
                                        Text("New Device ID")
                                            .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                            .foregroundColor(.white)
                                            .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Spacer()
                                        TextField("", text: $devID)
                                            .disableAutocorrection(true)
                                            .foregroundColor(.black)
                                            .font(.system(size: geometry.size.height * 0.014, weight: .light, design: .default))
                                            .multilineTextAlignment(.center)
                                            .padding(geometry.size.height * 0.014)
                                            .background(Color(hex: 0xF6FCFE))
                                            .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
                                            .cornerRadius(geometry.size.width * 0.01)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                                    .stroke(Color(hex: 0xDFE6E9), lineWidth: geometry.size.width * 0.004)
                                            )
                                            .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                        Spacer()
                                    }
                                    .background(Color(hex: 0x1D2951))
                                    
                                    Text("This is a unique value used to identify the device and control its distribution. Please make sure that it is enetered correctly. It can't be edited.")
                                        .font(.system(size: geometry.size.height * 0.01, weight: .regular))
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.center)
                                        .frame(width: geometry.size.width * 0.6)
                                        .background(Color(hex: 0x1D2951))
                                    
                                }
                                .frame(width: geometry.size.width * 0.6)
                                .padding(.top, geometry.size.height * 0.04)
                                
                                VStack {
                                    HStack {
                                        VStack(alignment: .trailing) {
                                            Text(devType != "" ? "Device Type: " : "")
                                                .font(.system(size: geometry.size.height * 0.012, weight: .heavy))
                                                .foregroundColor(Color.black)
                                            
                                            Text(devID != "" ? "Device ID: " : "")
                                                .font(.system(size: geometry.size.height * 0.012, weight: .heavy))
                                                .foregroundColor(Color.black)
                                                .padding(.top, geometry.size.height * 0.002)
                                                
                                        }
                                        VStack(alignment: .leading) {
                                            Text(devType)
                                                .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                                                .foregroundColor(Color.black)
                                                .italic()
                                            
                                            Text(devID)
                                                .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                                                .foregroundColor(Color.black)
                                                .italic()
                                                .padding(.top, geometry.size.height * 0.002)
                                        }
                                    }
                                    
                                    WatchView(devType: devType)
                                    
                                }
                                .frame(width: geometry.size.width * 0.38, height: geometry.size.height * 0.28)
                                .padding(geometry.size.height * 0.014)
                                .padding(.vertical, geometry.size.height * 0.005)
                                .background(Color(hex: 0xF6FCFE).opacity(0.8))
                                .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
                                .cornerRadius(geometry.size.width * 0.01)
                                .overlay(
                                    RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                        .stroke(Color(hex: 0xDFE6E9).opacity(0.6), lineWidth: geometry.size.width * 0.004)
                                )
                                .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                .padding(.top, geometry.size.height * 0.05)
                                
                                HStack {
                                    Button(action: {
                                        self.registerDevice()
                                    }) {
                                        HStack {
                                            Text("Register New Device")
                                                .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                .foregroundColor(Color(hex: 0xF5F5F5))
                                        }
                                        .frame(width: geometry.size.width * 0.5)
                                        .padding(geometry.size.height * 0.016)
                                        .background(Color(hex: 0x4E7FD5))
                                        .cornerRadius(geometry.size.width * 0.01)
                                        .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                    }
                                }
                                .padding(.top, geometry.size.height * 0.1)
                                .background(Color(hex: 0x1D2951))
                                
                                HStack {
                                    Button(action: {
                                        self.currentView = .Devices
                                    }) {
                                        HStack {
                                            Text("Cancel Registration")
                                                .font(.system(size: geometry.size.height * 0.012, weight: .semibold, design: .default))
                                                .foregroundColor(Color(hex: 0xF5F5F5))
                                                .underline(true)
                                        }
                                        .frame(width: geometry.size.width * 0.5)
                                        .background(Color.clear)
                                        .cornerRadius(geometry.size.width * 0.01)
                                        .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                    }
                                }
                                .padding(.top, geometry.size.height * 0.005)
                                .background(Color(hex: 0x1D2951))
                                
                                if let errorMessage = errorMessage {
                                    Text(errorMessage)
                                        .foregroundColor(.red)
                                        .font(.system(size: geometry.size.height * 0.012))
                                        .padding(.top, geometry.size.height * 0.02)
                                }
                                
                                
                                Spacer()
                                
                            }
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
    }
    private func registerDevice() {
        
        guard !devType.isEmpty, !devID.isEmpty else {
            self.errorMessage = "All fields are required."
            return
        }
        
        let requestBody: [String: Any] = [
            "devType": devType,
            "devID": devID,
        ]

        let url = URL(string: "http://172.20.10.3:8001/register-device")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "That device ID has already been used. Please select another."
                }
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.errorMessage = "That device ID has already been used. Please select another."
                }
                return
            }

            if response.statusCode == 200 {
                do {
                    DispatchQueue.main.async {
                        self.currentView = .Devices
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("Error decoding JSON: \(error.localizedDescription)")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "That device ID has already been used. Please select another."
                    return
                }
            }
        }
        .resume()
    }
}

