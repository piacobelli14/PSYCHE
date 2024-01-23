//
//  PSYCHESwap.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/22/24.
//

import SwiftUI
import SceneKit

struct WatchView: UIViewRepresentable {
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = SCNScene(named: "apple watch series 6")
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





struct PSYCHESwap: View {
    @Binding var currentView: AppView
    @Binding var selectedPatientID: String
    
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
                                    VStack {
                                        HStack {
                                            VStack(alignment: .trailing) {
                                                Text("Device Type: ")
                                                    .font(.system(size: geometry.size.height * 0.015, weight: .heavy))
                                                
                                                Text("Device ID: ")
                                                    .font(.system(size: geometry.size.height * 0.015, weight: .heavy))
                                                    .padding(.top, geometry.size.height * 0.002)
                                            }
                                            VStack(alignment: .leading) {
                                                Text("Fitbit Sense")
                                                    .font(.system(size: geometry.size.height * 0.015, weight: .regular))
                                                    .italic()
                                                
                                                Text("123456")
                                                    .font(.system(size: geometry.size.height * 0.015, weight: .regular))
                                                    .italic()
                                                    .padding(.top, geometry.size.height * 0.002)
                                            }
                                        }
                                        
                                        WatchView()
                                        
                                        VStack {
                                            HStack {
                                                Spacer()
                                                Text("In Use: ")
                                                    .font(.system(size: geometry.size.height * 0.015, weight: .heavy))
                                                Text("Peter I.")
                                                    .font(.system(size: geometry.size.height * 0.015, weight: .regular))
                                                Spacer()
                                            }
                                            .frame(width: geometry.size.width * 0.3)
                                            .padding(.vertical, geometry.size.height * 0.01)
                                            .background(Color(hex: 0x5BBA6F).opacity(0.2))
                                            .foregroundColor(Color(hex: 0x6BC17D).opacity(1))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                                    .stroke(Color(hex: 0x6BC17D), lineWidth: geometry.size.width * 0.004)
                                            )
                                            
                                            HStack {
                                                Spacer()
                                                Text("Not Charged: ")
                                                    .font(.system(size: geometry.size.height * 0.015, weight: .heavy))
                                                Text("21%")
                                                    .font(.system(size: geometry.size.height * 0.015, weight: .regular))
                                                Spacer()
                                            }
                                            .frame(width: geometry.size.width * 0.3)
                                            .padding(.vertical, geometry.size.height * 0.01)
                                            .background(Color(hex: 0xE54B4B).opacity(0.2))
                                            .foregroundColor(Color(hex: 0xE54B4B).opacity(1))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                                    .stroke(Color(hex: 0xE54B4B), lineWidth: geometry.size.width * 0.004)
                                            )
                                            .padding(.top, geometry.size.height * 0.005)
                                        }
                                    }
                                    .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.4)
                                    .padding(geometry.size.height * 0.014)
                                    .background(Color(hex: 0xF6FCFE))
                                    .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
                                    .cornerRadius(geometry.size.width * 0.01)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                            .stroke(Color(hex: 0xDFE6E9), lineWidth: geometry.size.width * 0.004)
                                    )
                                    .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                    
                                    
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                }
            }
            
        }
    }
}
