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
    @State private var patients: [PatientInfo] = []
    @State private var selectedPatientID: String?
    @State private var patientSearch: String = ""

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x1D2951), Color(hex: 0x1D2951)]), startPoint: .top, endPoint: .bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)

            VStack {
                GeometryReader { geometry in
                    
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
                        .padding(.leading, geometry.size.height * 0.035)
                        Spacer()
                    }
                    
                    VStack(alignment: .center) {
                        HStack {
                            Spacer()
                            VStack {
                                HStack {
                                    Spacer()
                                    ZStack {
                                        TextField("", text: $patientSearch)
                                            .disableAutocorrection(true)
                                            .foregroundColor(.black)
                                            .font(.system(size: geometry.size.height * 0.01, weight: .light, design: .default))
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
                                                .foregroundColor(Color.black)
                                                .frame(width: geometry.size.width * 0.06)
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
                            .frame(width: geometry.size.width * 0.8)
                            .padding(.top, geometry.size.height * 0.1)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            List(patients, id: \.ptid) { patient in
                                HStack {
                                    Spacer()
                                    Image(systemName: selectedPatientID == patient.ptid ? "checkmark.square.fill" : "square")
                                        .frame(width: geometry.size.width * 0.025)
                                        .foregroundColor(selectedPatientID == patient.ptid ? .white : .white) // Set the checkmark color to white
                                        .font(.system(size: geometry.size.height * 0.025))
                                        .onTapGesture {
                                            if selectedPatientID == patient.ptid {
                                                selectedPatientID = nil
                                            } else {
                                                selectedPatientID = patient.ptid
                                            }
                                        }
                                    
                                    HStack {
                                        VStack {
                                            Text(patient.ptname)
                                                .font(.system(size: geometry.size.height * 0.02, weight: .bold))
                                                
                                            Text("ID: \(patient.ptid)")
                                                .font(.subheadline)
                                                .font(.system(size: geometry.size.height * 0.015, weight: .semibold))
                                        }
                                        .frame(width: geometry.size.width * 0.4)
                                        .multilineTextAlignment(.center)
                                        
                                        VStack(spacing: geometry.size.height * 0.005) {
                                            Text("Age: \(patient.ptage)").font(.subheadline)
                                            Text("Sex: \(patient.ptsex)").font(.subheadline)
                                            Text("Unit: \(patient.pttag)").font(.subheadline)
                                        }
                                        .frame(width: geometry.size.width * 0.25)
                                        .font(.system(size: geometry.size.height * 0.015, weight: .semibold))
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
                                .padding(.vertical, geometry.size.height * 0.01)
                                .background(Color.clear)
                                .listRowBackground(Color.clear)
                            }
                            .listStyle(PlainListStyle())
                            .frame(width: geometry.size.width * 0.8)
                            .frame(height: geometry.size.height * 0.8)
                            Spacer()
                        }

                        ZStack {
                            RoundedRectangle(cornerRadius: geometry.size.width * 0.004)
                                .stroke(Color.white, lineWidth: geometry.size.width * 0.002)
                                .background(Color(hex: 0xF5F5F5))
                                .frame(height: geometry.size.height * 0.08)
                                .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                .opacity(0.9)
                            
                            HStack {
                                Spacer()
                                HStack(spacing: geometry.size.width * 0.05) {
                                    Image(systemName: "person.badge.plus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width * 0.02, height: geometry.size.height * 0.02)
                                        .foregroundColor(Color(hex: 0x152234))
                                        .shadow(color: .gray, radius: geometry.size.width * 0.01)
                                    
                                    Image(systemName: "person.badge.minus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width * 0.02, height: geometry.size.height * 0.02)
                                        .foregroundColor(Color(hex: 0x152234))
                                        .shadow(color: .gray, radius: geometry.size.width * 0.01)
                                    
                                    Image(systemName: "square.and.pencil")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width * 0.02, height: geometry.size.height * 0.02)
                                        .foregroundColor(Color(hex: 0x152234))
                                        .shadow(color: .gray, radius: geometry.size.width * 0.01)
                                    
                                    Image(systemName: "applewatch")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width * 0.02, height: geometry.size.height * 0.02)
                                        .foregroundColor(Color(hex: 0x152234))
                                        .shadow(color: .gray, radius: geometry.size.width * 0.01)
                                }
                            }
                            .frame(width: geometry.size.width * 0.9)
                            .padding(.bottom, geometry.size.height * 0.02)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    }
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onAppear {
            fetchPatientInfo()
        }
    }

    private func fetchPatientInfo() {
            let url = URL(string: "http://10.111.26.70:8001/get-patients-current")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

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
