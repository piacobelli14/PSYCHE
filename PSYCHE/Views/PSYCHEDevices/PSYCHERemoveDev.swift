//
//  PSYCHERemoveDev.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/24/24.
//

import SwiftUI

struct PSYCHERemoveDev: View {
    @Binding var currentView: AppView
    
    @State private var selectedDevType = ""
    @State private var selectedDevID = ""
    
    @State private var devIDs: [String] = []
    @State private var watchDataList: [WatchData] = []
    
    @State private var validationCheck = false
    
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
                            currentView = .Devices
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
                                        Text("Selecte Device To Remove")
                                            .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                            .foregroundColor(.white)
                                            .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Spacer()
                                        Menu {
                                            ForEach(devIDs, id: \.self) { id in
                                                Button(id) {
                                                    selectedDevID = id
                                                    self.updateSelectedDeviceType()
                                                }
                                            }
                                        } label: {
                                            Text(selectedDevID == "" ? "Select A Device" : selectedDevID)
                                                .foregroundColor(.black)
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
                                
                                VStack {
                                    HStack {
                                        VStack(alignment: .trailing) {
                                            Text(selectedDevType != "" ? "Device Type: " : "")
                                                .font(.system(size: geometry.size.height * 0.012, weight: .heavy))
                                                .foregroundColor(Color.black)
                                            
                                            Text(selectedDevID != "" ? "Device ID: " : "")
                                                .font(.system(size: geometry.size.height * 0.012, weight: .heavy))
                                                .foregroundColor(Color.black)
                                                .padding(.top, geometry.size.height * 0.002)
                                                
                                        }
                                        VStack(alignment: .leading) {
                                            Text(selectedDevType)
                                                .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                                                .foregroundColor(Color.black)
                                                .italic()
                                            
                                            Text(selectedDevID)
                                                .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                                                .foregroundColor(Color.black)
                                                .italic()
                                                .padding(.top, geometry.size.height * 0.002)
                                        }
                                    }
                                    
                                    WatchView(devType: selectedDevType)
                                    
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
                                    Image(systemName: validationCheck ? "checkmark.square.fill" : "square")
                                        .frame(width: geometry.size.width * 0.025)
                                        .foregroundColor(.white) // Set the checkmark color to white
                                        .font(.system(size: geometry.size.height * 0.025))
                                        .onTapGesture {
                                            validationCheck.toggle()
                                        }
                                    
                                    Text("I understand that all of this device's information will be permanently deleted. This change can not be undone.")
                                        .font(.system(size: geometry.size.height * 0.01, weight: .semibold))
                                        .foregroundColor(Color.white)
                                        .opacity(0.9)
                                        .padding(.leading, geometry.size.width * 0.02)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(.top, geometry.size.height * 0.025)
                                .frame(width: geometry.size.width * 0.5)
                                .background(Color(hex: 0x1D2951))
                                
                                HStack {
                                    Button(action: {
                                        self.removeDevice()
                                    }) {
                                        HStack {
                                            Text("Remove Device")
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
                                .padding(.top, geometry.size.height * 0.08)
                                .background(Color(hex: 0x1D2951))
                                
                                HStack {
                                    Button(action: {
                                        self.currentView = .Devices
                                    }) {
                                        HStack {
                                            Text("Cancel Removal")
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
        .onAppear {
            self.getDeviceInfo()
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    private func updateSelectedDeviceType() {
        if let selectedDevice = watchDataList.first(where: { $0.devID == selectedDevID }) {
            selectedDevType = selectedDevice.devType
        }
    }
    private func getDeviceInfo() {
        let url = URL(string: "https://psyche-api.vercel.app/get-devices")!
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

            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid response from the server"
                    print(self.errorMessage)
                }
                return
            }

            if response.statusCode == 200 {
                do {
                    let decodedData = try JSONDecoder().decode([WatchData].self, from: data)
                    DispatchQueue.main.async {
                        self.watchDataList = decodedData
                        self.devIDs = decodedData.map { $0.devID }
                        print(devIDs)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "JSON decoding error: \(error.localizedDescription)"
                        print(self.errorMessage)
                    }
                }

            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Server error with status code: \(response.statusCode)"
                    print(self.errorMessage)
                }
            }
        }
        .resume()
    }
    private func removeDevice() {
        
        guard !selectedDevID.isEmpty else {
            self.errorMessage = "All fields are required."
            return
        }
        
        let requestBody: [String: Any] = [
            "devID": selectedDevID,
        ]

        let url = URL(string: "https://psyche-api.vercel.app/remove-device")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
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
               return
            }
        }
        .resume()
    }
}
