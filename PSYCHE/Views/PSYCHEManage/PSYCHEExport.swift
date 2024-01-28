//
//  PSYCHEExport.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/27/24.
//

import Foundation
import SwiftUI


struct Session: Decodable, Hashable {
    let name: String
    let sizeBytes: Int
    let creationTime: String
}

struct SessionResponse: Decodable {
    let sessions: [Session]
}

struct PSYCHEExport: View {
    @Binding var currentView: AppView
    
    @State private var availableSessions: [Session] = []
    @State private var selectedSessionIndex: Int? = nil
    @State private var selectedSession: String = ""
    
    @State private var selectedFileSize: String = ""
    @State private var selectedFileCreation: String = ""
    
    @State private var validationCheck = false
    
    @State private var errorMessage: String = ""
    
    var body: some View {
        
        ZStack {
            AnimatedStarsView()
                .ignoresSafeArea()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: 0x1D2951), Color(hex: 0x1D2951)]), startPoint: .top, endPoint: .bottom)
                )
            
            VStack {
                GeometryReader { geometry in
                    
                    HStack {
                        Button(action: {
                            currentView = .Devices
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
                                .opacity(0.9)
                        )
                        .padding(.top, geometry.size.height * 0.03)
                        .padding(.leading, geometry.size.height * 0.035)
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            
                            Image(systemName: "square.and.arrow.down.on.square")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width * 0.04, height: geometry.size.height * 0.04)
                                .padding(.trailing, geometry.size.width * 0.025)
                                                                
                            Text("Download a Session")
                                .font(.system(size: geometry.size.height * 0.025, weight: .heavy))
                                .multilineTextAlignment(.center)
                      
                            Spacer()
                        }
                        .foregroundColor(Color.white)
                        
                        HStack {
                            Spacer()
                            Menu {
                                ForEach(availableSessions, id: \.self) { session in
                                    Button(action: {
                                        self.selectedSession = session.name
                                        self.selectedFileSize = "\(String(format: "%.2f MB", Double(session.sizeBytes) / 1024.0 / 1024.0))"
                                        self.selectedFileCreation = session.creationTime
                                    }) {
                                        Text(session.name)
                                            .foregroundColor(.black)
                                            .font(.system(size: geometry.size.height * 0.02))
                                            .padding(.vertical, 5)
                                        }
                                    }
                            } label: {
                                Text(selectedSession.isEmpty ? "Select Session" : selectedSession)
                                    .foregroundColor(.black)
                                    .frame(width: geometry.size.width * 0.6)
                                    .font(.system(size: geometry.size.height * 0.016, weight: .light, design: .default))
                                    .multilineTextAlignment(.center)
                                    .padding(geometry.size.height * 0.016)
                                    .background(Color(hex: 0xF6FCFE))
                                    .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
                                    .cornerRadius(geometry.size.width * 0.01)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                            .stroke(Color(hex: 0xDFE6E9), lineWidth: geometry.size.width * 0.004)
                                    )
                                    .shadow(color: .gray, radius: geometry.size.width * 0.004)
                            }
                            .frame(width: geometry.size.width * 0.6)
                            Spacer()
                        }
                        .padding(.top, geometry.size.height * 0.12)
                        
                        HStack {
                            Text(selectedFileSize != "" ? "File Size: \(selectedFileSize)" : "")
                                .foregroundColor(Color.white)
                                .font(.system(size: geometry.size.height * 0.016, weight: .semibold))
                            
                            Spacer()
                            
                            Text(selectedFileSize != "" ? "Created: \(selectedFileCreation)" : "")
                                .foregroundColor(Color.white)
                                .font(.system(size: geometry.size.height * 0.016, weight: .semibold))
                        }
                        .frame(width: geometry.size.width * 0.6)
                        .padding(.top, geometry.size.height * 0.02)
                        
                        HStack {
                            Image(systemName: validationCheck ? "checkmark.square.fill" : "square")
                                .frame(width: geometry.size.width * 0.025)
                                .foregroundColor(.white) // Set the checkmark color to white
                                .font(.system(size: geometry.size.height * 0.025))
                                .onTapGesture {
                                    validationCheck.toggle()
                                }
                            
                            Text("I understand that downloading this session will remove it from storage on the PSYCHE servers and end the current session. This cannot be undone.")
                                .font(.system(size: geometry.size.height * 0.01, weight: .semibold))
                                .foregroundColor(Color.white)
                                .opacity(0.9)
                                .padding(.leading, geometry.size.width * 0.02)
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.top, geometry.size.height * 0.01)
                        .frame(width: geometry.size.width * 0.6)
                        
                        HStack {
                            Button(action: {
                                if (validationCheck) {
                                    self.downloadSessionFile()
                                }
                            }) {
                                HStack {
                                    Text("Confirm Download")
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
                        .padding(.top, geometry.size.height * 0.12)
                        
                        HStack {
                            Button(action: {
                                self.currentView = .Devices
                            }) {
                                HStack {
                                    Text("Cancel Download")
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
                        
                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.system(size: geometry.size.height * 0.012))
                                .padding(.top, geometry.size.height * 0.02)
                        }
                       Spacer()
                    }
                        
                }
            }
        }
        .onAppear {
            getDeviceInfo()
        }
    }
    
    private func getDeviceInfo() {
        let url = URL(string: "http://172.20.10.3:8001/get-sessions")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    print(self.errorMessage)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received from the server"
                    print(self.errorMessage)
                }
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.errorMessage = "Server error"
                    print(self.errorMessage)
                }
                return
            }

            do {
                let sessionResponse = try JSONDecoder().decode(SessionResponse.self, from: data)
                DispatchQueue.main.async {
                    self.availableSessions = sessionResponse.sessions
                    print(sessionResponse.sessions) // Now correctly prints the sessions
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "JSON decoding error: \(error.localizedDescription)"
                    print(self.errorMessage)
                }
            }
        }
        .resume()
    }
    private func downloadSessionFile() {
        guard !self.selectedSession.isEmpty else {
            self.errorMessage = "No session selected."
            return
        }

        let url = URL(string: "http://172.20.10.3:8001/export-sessions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["fileName": self.selectedSession]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.downloadTask(with: request) { (tempURL, response, error) in
            guard let tempURL = tempURL else {
                DispatchQueue.main.async {
                    self.errorMessage = "Download failed: \(error?.localizedDescription ?? "Unknown error")"
                }
                return
            }

            do {
                let fileManager = FileManager.default
                let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let destinationURL = documentsPath.appendingPathComponent(self.selectedSession)

                // Delete any existing file
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                }

                try fileManager.moveItem(at: tempURL, to: destinationURL)

                DispatchQueue.main.async {
                    self.currentView = .Devices
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "File save error: \(error.localizedDescription)"
                }
            }
        }
        task.resume()
    }
}
