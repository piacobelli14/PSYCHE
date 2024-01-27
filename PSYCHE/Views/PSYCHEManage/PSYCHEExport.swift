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
    let rows: Int
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
    @State private var selectedFileRows: String = ""
    @State private var selectedFileCreation: String = ""
    
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
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Menu {
                                ForEach(availableSessions, id: \.self) { session in
                                    Button(action: {
                                        self.selectedSession = session.name
                                        self.selectedFileSize = "\(String(format: "%.2f MB", Double(session.sizeBytes) / 1024.0 / 1024.0))"
                                        self.selectedFileRows = "\(session.rows)"
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
                                        // Adjust the font size for the label if necessary
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
}
