//
//  PSYCHEExport.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/27/24.
//

import SwiftUI

struct SessionResponse: Decodable {
    let sessions: [String]
}

struct PSYCHEExport: View {
    @Binding var currentView: AppView
    
    @State private var availableSessions: [String] = []
    @State private var selectedSession: String = ""
    
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
                        
                        Spacer()
                        
                        Menu {
                            ForEach(availableSessions, id: \.self) { session in
                                Button(action: {
                                    selectedSession = session
                                }) {
                                    Text(session)
                                        .foregroundColor(.black)
                                }
                            }
                        } label: {
                            Text(selectedSession.isEmpty ? "Select Session" : selectedSession)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(5)
                        }
                        .padding()
                        
                        Spacer()
                        
                    }
                }
            }
        }
        .onAppear {
            getDeviceInfo()  // Call getDeviceInfo() when the view appears
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
