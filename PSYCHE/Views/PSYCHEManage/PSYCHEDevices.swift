//
//  PSYCHESwap.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/22/24.
//

import SwiftUI
import SceneKit

struct WatchData: Codable {
    let devType: String
    let devID: String
    let assignedTo: String
    let lastAssigned: String
    let battery: String
}

struct WatchView: UIViewRepresentable {
    let devType: String

    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        
        sceneView.scene = SCNScene(named: devType)
        sceneView.backgroundColor = UIColor.clear
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true

        let rootNode = sceneView.scene?.rootNode

        rootNode?.scale = SCNVector3(3.5, 3.5, 3.5)

        rootNode?.eulerAngles.y = 1 * .pi / 1.26
        rootNode?.eulerAngles.x = 1 * .pi / 0.5
        rootNode?.eulerAngles.z = -1 * .pi / 0.5

        rootNode?.position = SCNVector3(-2.8, 0, 0)

        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.light?.castsShadow = true
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        rootNode?.addChildNode(lightNode)

        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) { }
}

struct PSYCHEDevices: View {
    @Binding var currentView: AppView
    
    @State private var deviceInfo: [WatchData] = []
    
    @State private var errorMessage: String = ""
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
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
                                    .opacity(0.9)
                            )
                            .padding(.top, geometry.size.height * 0.03)
                            
                            Spacer()
                            
                            Button(action: {
                                currentView = .Patients
                            }) {
                                Image(systemName: "person.2")
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
                        }
                        .padding(.leading, geometry.size.height * 0.035)
                        .frame(width: geometry.size.width * 0.15)
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                currentView = .NewDev
                            }) {
                                Image(systemName: "plus")
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
                           
                            Spacer()
                            
                            Button(action: {
                                currentView = .RemoveDev
                            }) {
                                Image(systemName: "minus")
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
                            .padding(.leading, geometry.size.width * 0.015)
                            
                        }
                        .padding(.trailing, geometry.size.height * 0.035)
                        .frame(width: geometry.size.width * 0.15)
                    }
                    
                 
                    VStack(alignment: .center) {
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                ScrollView {
                                    LazyVGrid(columns: columns, spacing: geometry.size.width * 0.05) {
                                            ForEach(deviceInfo, id: \.devID) { device in
                                                deviceCell(for: device, geometry: geometry)
                                            }
                                        }
                                    }
                                Spacer()
                            }
                            .frame(width: geometry.size.width * 0.9)
                            .frame(height: geometry.size.height * 0.86)
                            Spacer()
                        }
                        .padding(.top, geometry.size.height * 0.1)
                    }
                }
            }
        }
        .onAppear {
            self.getDeviceInfo()
        }
    }
    private func deviceCell(for device: WatchData, geometry: GeometryProxy) -> some View {
            VStack {
                HStack {
                    VStack(alignment: .trailing) {
                        Text("Device Type: ")
                            .font(.system(size: geometry.size.height * 0.012, weight: .heavy))
                            .foregroundColor(Color.black)
                        
                        Text("Device ID: ")
                            .font(.system(size: geometry.size.height * 0.012, weight: .heavy))
                            .foregroundColor(Color.black)
                            .padding(.top, geometry.size.height * 0.002)
                            
                    }
                    VStack(alignment: .leading) {
                        Text(device.devType)
                            .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                            .foregroundColor(Color.black)
                            .italic()
                        
                        Text(device.devID)
                            .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                            .foregroundColor(Color.black)
                            .italic()
                            .padding(.top, geometry.size.height * 0.002)
                    }
                }
                
                WatchView(devType: device.devType)

                
                VStack {
                    HStack {
                        Spacer()
                        Text(device.assignedTo != "None" ? "In Use: " : "Available")
                            .font(.system(size: geometry.size.height * 0.01, weight: .heavy))
                        Text(device.assignedTo != "None" ? device.assignedTo : "")
                            .font(.system(size: geometry.size.height * 0.01, weight: .regular))
                        Spacer()
                    }
                    .frame(width: geometry.size.width * 0.3)
                    .padding(.vertical, geometry.size.height * 0.01)
                    .background(device.assignedTo != "None" ? Color(hex: 0x5BBA6F).opacity(0.2) : Color(hex: 0xBD9B19).opacity(0.2))
                    .foregroundColor(device.assignedTo != "None" ? Color(hex: 0x6BC17D).opacity(1) : Color(hex: 0xBD9B19))
                    .overlay(
                        RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                            .stroke(device.assignedTo != "None" ? Color(hex: 0x6BC17D).opacity(1) : Color(hex: 0xBD9B19), lineWidth: geometry.size.width * 0.004)
                    )
                    
                    let batteryStatusText = Int(device.battery) ?? 0 < 20 ? "Not Charged: " : "Charged: "
                    let batteryStatusPrimaryColor = Int(device.battery) ?? 0 < 20 ? Color(hex: 0xE54B4B).opacity(1) : Color(hex: 0x6BC17D).opacity(1)
                    let batteryStatusSecondaryColor = Int(device.battery) ?? 0 < 20 ? Color(hex: 0xE54B4B).opacity(0.2) : Color(hex: 0x5BBA6F).opacity(0.2)
                    HStack {
                        Spacer()
                        Text(batteryStatusText)
                            .font(.system(size: geometry.size.height * 0.01, weight: .heavy))
                        Text("\(device.battery)%")
                            .font(.system(size: geometry.size.height * 0.01, weight: .regular))
                        Spacer()
                    }
                    .frame(width: geometry.size.width * 0.3)
                    .padding(.vertical, geometry.size.height * 0.01)
                    .background(batteryStatusSecondaryColor)
                    .foregroundColor(batteryStatusPrimaryColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                            .stroke(batteryStatusPrimaryColor, lineWidth: geometry.size.width * 0.004)
                    )
                }
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
        }
    
    private func getDeviceInfo() {
        let url = URL(string: "http://10.111.26.70:8001/get-devices")!
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
                        self.deviceInfo = decodedData
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

}
