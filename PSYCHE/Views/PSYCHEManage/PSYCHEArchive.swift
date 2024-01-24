//
//  PSYCHEArchive.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/22/24.
//

import SwiftUI

struct PatientPlaceholdersArchive: Codable {
    var ptIDPlaceholder: String
    var ptFirstNamePlaceholder: String
    var ptLastNamePlaceholder: String
}

struct PSYCHEArchive: View {
    @Binding var currentView: AppView
    @Binding var selectedPatientID: String
    
    @State private var ptFirstNameArchive: String = ""
    @State private var ptLastNameArchive: String = ""
    @State private var ptIDArchive: String = ""
    @State private var validationCheck = false
    
    @State private var errorMessage: String? = nil

    
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
                                    
                                    Image(systemName: "person.badge.minus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width * 0.04, height: geometry.size.height * 0.04)
                                        .padding(.trailing, geometry.size.width * 0.025)
                                                                        
                                    Text("Archive Patient")
                                        .font(.system(size: geometry.size.height * 0.025, weight: .heavy))
                                        .multilineTextAlignment(.center)
                              
                                    Spacer()
                                }
                                .foregroundColor(Color.white)
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        
                                        Text("Are you sure that you want to archive patient \(ptFirstNameArchive) \(ptLastNameArchive) (ID: \(ptIDArchive))?")
                                            .font(.system(size: geometry.size.height * 0.02, weight: .semibold))
                                            .foregroundColor(Color.white)
                                            .multilineTextAlignment(.center)
                                        
                                        Spacer()
                                    }
                                    .frame(width: geometry.size.width * 0.8)
                                    .padding(.top, geometry.size.height * 0.2)
                                    
                                    HStack {
                                        Image(systemName: validationCheck ? "checkmark.square.fill" : "square")
                                            .frame(width: geometry.size.width * 0.025)
                                            .foregroundColor(.white) // Set the checkmark color to white
                                            .font(.system(size: geometry.size.height * 0.025))
                                            .onTapGesture {
                                                validationCheck.toggle()
                                            }
                                        
                                        Text("I understand that all of this patient's information will be moved to the archive. It will be accessable, but can no longer be edited. This change can not be undone.")
                                            .font(.system(size: geometry.size.height * 0.01, weight: .semibold))
                                            .foregroundColor(Color.white)
                                            .opacity(0.9)
                                            .padding(.leading, geometry.size.width * 0.02)
                                            .multilineTextAlignment(.leading)
                                    }
                                    .padding(.top, geometry.size.height * 0.025)
                                    .frame(width: geometry.size.width * 0.6)
                                    
                                    HStack {
                                        Button(action: {
                                            if (validationCheck) {
                                                archivePatient()
                                            } else {
                                                errorMessage = "Please check the box above to confirm the archive."
                                            }
                                        }) {
                                            HStack {
                                                Text("Confirm Patient Archive")
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
                                    .padding(.top, geometry.size.height * 0.2)
                                    
                                    HStack {
                                        Button(action: {
                                            self.currentView = .Patients
                                        }) {
                                            HStack {
                                                Text("Cancel Archive")
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
            archivePatientPlaceholders(patientID: selectedPatientID)
        }
    }
    func archivePatientPlaceholders(patientID: String) {
        guard let url = URL(string: "http://10.111.26.70:8001/selected-patient-placeholders") else { return }
        
        let requestBody: [String: Any] = ["patientID": patientID]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data in response.")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(PatientPlaceholdersArchive.self, from: data)
                DispatchQueue.main.async {
                    self.ptFirstNameArchive = decodedResponse.ptFirstNamePlaceholder
                    self.ptLastNameArchive = decodedResponse.ptLastNamePlaceholder
                    self.ptIDArchive = decodedResponse.ptIDPlaceholder
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
    private func archivePatient() {
        let requestBody: [String: Any] = [
            "patientID": ptIDArchive,
        ]

        let url = URL(string: "http://10.111.26.70:8001/archive-patient")!
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
            }
        }
        .resume()
    }
}