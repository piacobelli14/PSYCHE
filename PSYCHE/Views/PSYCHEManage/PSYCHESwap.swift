//
//  PSYCHESwap.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/24/24.
//

import SwiftUI

struct AssignmentResponse: Codable {
    var ptName: String
    var currentDevID: String
    var currentDevType: String
}

struct PSYCHESwap: View {
    @Binding var currentView: AppView
    @Binding var selectedPatientID: String
    
    @State private var ptName: String = ""
    @State private var currentDevID: String = ""
    @State private var currentDevType: String = ""
    @State private var newDevID: String = ""
    @State private var newDevType: String = ""
    
    @State private var availableDevIDs: [String] = []
    @State private var watchDataList: [WatchData] = []
    
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x1D2951), Color(hex: 0x1D2951)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                GeometryReader { geometry in
                    HStack {
                        Button(action: {
                            currentView = .Patients
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
                    
                    VStack(alignment: .center) {
                        
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    
                                    Image(systemName: "applewatch")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width * 0.04, height: geometry.size.height * 0.04)
                                        .padding(.trailing, geometry.size.width * 0.025)
                                                                        
                                    Text("Swap Device for \(ptName)")
                                        .font(.system(size: geometry.size.height * 0.025, weight: .heavy))
                                        .multilineTextAlignment(.center)
                              
                                    Spacer()
                                }
                                .foregroundColor(Color.white)
                                
                                if (currentDevType != "None" && currentDevID != "None") {
                                    VStack {
                                        HStack {
                                            
                                            VStack(alignment: .trailing) {
                                                Text(currentDevType != "None" ? "Device Type: " : "")
                                                    .font(.system(size: geometry.size.height * 0.012, weight: .heavy))
                                                    .foregroundColor(Color.black)
                                                
                                                Text(currentDevID != "None" ? "Device ID: " : "")
                                                    .font(.system(size: geometry.size.height * 0.012, weight: .heavy))
                                                    .foregroundColor(Color.black)
                                                    .padding(.top, geometry.size.height * 0.002)
                                                    
                                            }
                                            VStack(alignment: .leading) {
                                                Text(currentDevType)
                                                    .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                                                    .foregroundColor(Color.black)
                                                    .italic()
                                                
                                                Text(currentDevID)
                                                    .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                                                    .foregroundColor(Color.black)
                                                    .italic()
                                                    .padding(.top, geometry.size.height * 0.002)
                                            }
                                        }
                                        
                                        WatchView(devType: currentDevType)
                                        
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
                                    .padding(.top, geometry.size.height * 0.02)
                                } else {
                                    Text("\(ptName) is not currently assigned a device. Choose an available device below to get them started!")
                                        .font(.system(size: geometry.size.height * 0.016, weight: .semibold))
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.center)
                                        .padding(.top, geometry.size.height * 0.04)
                                        .frame(width: geometry.size.width * 0.7)
                                }
                                
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
                                        Picker("", selection: $newDevID) {
                                            ForEach(availableDevIDs, id: \.self) { id in
                                                Text(id).tag(id)
                                            }
                                        }
                                        .id(availableDevIDs)
                                        .pickerStyle(MenuPickerStyle())
                                        .onChange(of: newDevID) { newValue in
                                            updateSelectedDeviceType()
                                        }
                                        .pickerStyle(MenuPickerStyle())
                                        .padding(geometry.size.height * 0.014)
                                        .frame(width: geometry.size.width * 0.5)
                                        .font(.system(size: geometry.size.height * 0.014, weight: .light))
                                        .background(Color(hex: 0xF6FCFE))
                                        .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
                                        .cornerRadius(geometry.size.width * 0.01)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                                .stroke(Color(hex: 0xDFE6E9), lineWidth: geometry.size.width * 0.004)
                                        )
                                        .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                        .accentColor(.black)
                                        Spacer()
                                    }
                                }
                                .padding(.top, geometry.size.height * 0.05)
                                
                                if (newDevID != "") {
                                    Text("Assign \(ptName) device \(newDevID) and start collecting data?")
                                        .font(.system(size: geometry.size.height * 0.016, weight: .semibold))
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.center)
                                        .padding(.top, geometry.size.height * 0.04)
                                        .frame(width: geometry.size.width * 0.7)
                                } else {
                                    Text("")
                                        .font(.system(size: geometry.size.height * 0.016, weight: .semibold))
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.center)
                                        .padding(.top, geometry.size.height * 0.04)
                                        .frame(width: geometry.size.width * 0.7)
                                }
                                
                                HStack {
                                    Button(action: {
                                        self.swapDevice()
                                    }) {
                                        HStack {
                                            Text("Confirm New Device Assignment")
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
                                .padding(.top, geometry.size.height * 0.04)
                                
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
                                
                                if let errorMessage = errorMessage {
                                    Text(errorMessage)
                                        .foregroundColor(.red)
                                        .font(.system(size: geometry.size.height * 0.012))
                                        .padding(.top, geometry.size.height * 0.02)
                                }
                                Spacer()
                            }
                            .frame(width: geometry.size.width * 0.8)
                            Spacer()
                        }
                    }
                }
            }
        }
        .onAppear {
            self.getAssignmentInfo()
            self.getDeviceInfo()
        }
    }
    private func getAssignmentInfo() {
        
        let requestBody: [String: Any] = [
            "ptID": selectedPatientID,
        ]

        let url = URL(string: "http://172.20.10.3:8001/get-assignment-info")!
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

            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let assignmentResponse = try JSONDecoder().decode(AssignmentResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.ptName = assignmentResponse.ptName
                        self.currentDevID = assignmentResponse.currentDevID
                        self.currentDevType = assignmentResponse.currentDevType
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
    private func updateSelectedDeviceType() {
        if let selectedDevice = watchDataList.first(where: { $0.devID == newDevID }) {
            newDevType = selectedDevice.devType
        }
    }
    private func getDeviceInfo() {
        let url = URL(string: "http://172.20.10.3:8001/get-devices")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
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
                        let filteredData = decodedData.filter { $0.assignedTo == "None" || $0.assignedTo.isEmpty }
                        self.watchDataList = filteredData
                        self.availableDevIDs = [""] + filteredData.map { $0.devID }
                        print(availableDevIDs)
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
    private func swapDevice() {
        
        guard !newDevID.isEmpty else {
            self.errorMessage = "All fields are required."
            return
        }
        
        let requestBody: [String: Any] = [
            "newDevID": newDevID,
            "oldDevID": currentDevID,
            "ptID": selectedPatientID,
            "ptName": ptName,
        ]

        let url = URL(string: "http://172.20.10.3:8001/swap-device")!
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
                        self.currentView = .Patients
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

