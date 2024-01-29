//
//  PSYCHEPatients.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/21/24.
//

import SwiftUI

struct PatientInfo: Codable {
    let ptid: String
    let ptname: String
    let ptsex: String
    let ptage: Int
    let pttag: String
}

struct PSYCHEPatients: View {
    @Binding var currentView: AppView
    @Binding var selectedPatientID: String
    @State private var patients: [PatientInfo] = []
    @State private var patientSearch: String = ""
    @State private var isCurrent = true
    
    private var filteredPatients: [PatientInfo] {
        if patientSearch.isEmpty {
            return patients
        } else {
            return patients.filter { patient in
                return patient.ptname.lowercased().contains(patientSearch.lowercased())
            }
        }
    }

    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x1D2951), Color(hex: 0x1D2951)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            AnimatedStarsView()
            
            VStack {
                Spacer()
                GeometryReader { geometry in
                    VStack {
                        HStack {
                            HStack {
                                Button(action: {
                                    currentView = .Login
                                }) {
                                    Image(systemName: "lock")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width * 0.015)
                                        .frame(height: geometry.size.height * 0.015)
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
                                
                                Spacer()
                                
                                Button(action: {
                                    currentView = .Devices
                                }) {
                                    Image(systemName: "applewatch")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width * 0.015)
                                        .frame(height: geometry.size.height * 0.015)
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
                            }
                            .padding(.leading, geometry.size.height * 0.035)
                            .frame(width: geometry.size.width * 0.15)
                            
                            Spacer()
                        }
                        
                        VStack {
                            HStack {
                                Spacer()
                                VStack {
                                    HStack {
                                        Spacer()
                                        ZStack {
                                            TextField("", text: $patientSearch)
                                                .disableAutocorrection(true)
                                                .foregroundColor(.black)
                                                .font(.system(size: geometry.size.height * 0.02, weight: .light, design: .default))
                                                .padding(.leading, geometry.size.width * 0.06)
                                                .padding(geometry.size.height * 0.01)
                                                .background(Color(hex: 0xF6FCFE))
                                                .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
                                                .accentColor(.black)
                                                .cornerRadius(geometry.size.width * 0.01)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                                        .stroke(Color(hex: 0xDFE6E9), lineWidth: geometry.size.width * 0.004)
                                                )
                                                .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                            
                                            HStack {
                                                Image(systemName: "magnifyingglass")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: geometry.size.width * 0.02)
                                                    .frame(height: geometry.size.height * 0.02)
                                                    .foregroundColor(.black)
                                                    .padding(.leading, geometry.size.width * 0.02)
                                                Spacer()
                                            }
                                        }
                                    }
                                    .padding(.bottom, geometry.size.height * 0.005)
                                    
                                    Rectangle()
                                        .background(Color.white)
                                        .border(Color.white, width: 0.004)
                                        .foregroundColor(Color.white)
                                        .frame(height: geometry.size.height * 0.001)
                                }
                                .frame(width: geometry.size.width * 0.9)
                                .padding(.top, geometry.size.height * 0.05)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                List(filteredPatients, id: \.ptid) { patient in
                                    HStack {
                                        Spacer()
                                        Image(systemName: selectedPatientID == patient.ptid ? "checkmark.square.fill" : "square")
                                            .frame(width: geometry.size.width * 0.025)
                                            .foregroundColor(selectedPatientID == patient.ptid ? .white : .white)
                                            .font(.system(size: geometry.size.height * 0.025))
                                            .onTapGesture {
                                                if selectedPatientID == patient.ptid {
                                                    selectedPatientID = ""
                                                } else {
                                                    selectedPatientID = patient.ptid
                                                }
                                            }
                                        
                                        HStack {
                                            VStack {
                                                Text(patient.ptname)
                                                    .font(.system(size: geometry.size.height * 0.016, weight: .bold))
                                                    
                                                Text("ID: \(patient.ptid)")
                                                    .font(.system(size: geometry.size.height * 0.015, weight: .semibold))
                                            }
                                            .frame(width: geometry.size.width * 0.4)
                                            .padding(.leading, geometry.size.width * 0.02)
                                            .multilineTextAlignment(.center)
                                            
                                            VStack(spacing: geometry.size.height * 0.005) {
                                                Text("Age: \(patient.ptage)")
                                                    .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                                                Text("Sex: \(patient.ptsex)")
                                                    .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                                                Text("Unit: \(patient.pttag)")
                                                    .font(.system(size: geometry.size.height * 0.012, weight: .semibold))
                                            }
                                            .frame(width: geometry.size.width * 0.25)
                                        }
                                        .frame(width: geometry.size.width * 0.6)
                                        .foregroundColor(Color.white)
                                        Spacer()
                                    }
                                    .padding(geometry.size.height * 0.01)
                                    .cornerRadius(geometry.size.width * 0.01)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                            .stroke(Color.white, lineWidth: geometry.size.width * 0.004)
                                            .opacity(0.9)
                                            .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                    )
                                    .padding(.vertical, geometry.size.height * 0.005)
                                    .background(Color(hex: 0x1D2951))
                                    .listRowBackground(Color.clear)
                                }
                                .listStyle(PlainListStyle())
                                .frame(width: geometry.size.width * 0.9)
                                .frame(maxHeight: geometry.size.height * 0.6)
                                Spacer()
                            }
                            
                            Spacer()

                            ZStack {
                                HStack {
                                    Spacer()
                                    HStack(spacing: geometry.size.width * 0.05) {
                                        HStack {
                                            Text("Archive")
                                                .font(.system(size: geometry.size.height * 0.01, weight: isCurrent ? .regular : .bold))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(isCurrent ? Color(hex: 0x152234) : Color(hex: 0x4E7FD5))
                                                .scaleEffect(isCurrent ? 1.0 : 1.2)
                                            
                                            Toggle(isOn: $isCurrent) {}
                                                .toggleStyle(SwitchToggleStyle(tint: Color(hex: 0x4E7FD5)))
                                                .scaleEffect(geometry.size.width * 0.0014)
                                                .labelsHidden()
                                                .multilineTextAlignment(.center)
                                                .onChange(of: isCurrent) { newValue in
                                                    self.fetchPatientInfo()
                                                }
                                                .frame(width: geometry.size.width * 0.1)

                                            Text("Current")
                                                .font(.system(size: geometry.size.height * 0.01, weight: isCurrent ? .bold : .regular))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(isCurrent ? Color(hex: 0x4E7FD5) : Color(hex: 0x152234))
                                                .scaleEffect(isCurrent ? 1.2 : 1.0)
                                                
                                            Spacer()
                                        }
                                        .frame(width: geometry.size.width * 0.4)
                                        
                                        Spacer()
                                        
                                        Button(
                                            action: {
                                                self.currentView = .Enroll
                                            },
                                            label: {
                                                Image(systemName: "person.badge.plus")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: geometry.size.width * 0.02, height: geometry.size.height * 0.02)
                                                    .foregroundColor(Color(hex: 0x152234))
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.01)
                                            }
                                        )
                                        
                                        Button(
                                            action: {
                                                self.currentView = .Archive
                                            },
                                            label: {
                                                Image(systemName: "person.badge.minus")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: geometry.size.width * 0.02, height: geometry.size.height * 0.02)
                                                    .foregroundColor(Color(hex: 0x152234))
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.01)
                                            }
                                        )
                                        .disabled(selectedPatientID == "" ? true : false)
                                        .opacity(selectedPatientID == "" ? 0.6 : 1)
                                        
                                        Button(
                                            action: {
                                                self.currentView = .Edit
                                            },
                                            label: {
                                                Image(systemName: "square.and.pencil")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: geometry.size.width * 0.02, height: geometry.size.height * 0.02)
                                                    .foregroundColor(Color(hex: 0x152234))
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.01)
                                            }
                                        )
                                        .disabled(selectedPatientID == "" ? true : false)
                                        .opacity(selectedPatientID == "" ? 0.6 : 1)
                                        
                                        Button(
                                            action: {
                                                self.currentView = .Swap
                                            },
                                            label: {
                                                Image(systemName: "applewatch")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: geometry.size.width * 0.02, height: geometry.size.height * 0.02)
                                                    .foregroundColor(Color(hex: 0x152234))
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.01)
                                            }
                                        )
                                        .disabled(selectedPatientID == "" ? true : false)
                                        .opacity(selectedPatientID == "" ? 0.6 : 1)
                                    }
                                    .padding(.top, geometry.size.height * 0.01)
                                }
                                .frame(width: geometry.size.width * 0.9)
                            }
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: geometry.size.width * 0.004)
                                    .fill(Color(hex: 0xF5F5F5))
                                    .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                    .opacity(0.9)
                                    .edgesIgnoringSafeArea(.bottom)
                            )
                        }
                    }
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onAppear {
            self.fetchPatientInfo()
        }
    }

    private func fetchPatientInfo() {
        
        let requestBody: [String: Any] = [
            "patientTable": (isCurrent ? "current" : "archive"),
        ]

        let url = URL(string: "https://psyche-api.vercel.app/get-patients")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error: \(error.localizedDescription)")
                }
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    print("No data or response.")
                }
                return
            }

            if response.statusCode == 200 {
                do {
                    let decodedData = try JSONDecoder().decode([PatientInfo].self, from: data)
                    DispatchQueue.main.async {
                        self.patients = decodedData
                        print("Fetched patients: \(self.patients)")
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("Error decoding JSON: \(error.localizedDescription)")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    print("HTTP Status Code: \(response.statusCode)")
                }
            }
        }
        .resume()
    }
}
