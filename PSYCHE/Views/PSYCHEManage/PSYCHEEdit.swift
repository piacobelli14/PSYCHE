//
//  PSYCHEEdit.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/22/24.
//

import SwiftUI

struct PatientPlaceholdersEdit: Codable {
    var ptIDPlaceholder: String
    var ptFirstNamePlaceholder: String
    var ptLastNamePlaceholder: String
    var ptSexPlaceholder: String
    var ptAgePlaceholder: String
    var ptTagPlaceholder: String
}

struct PSYCHEEdit: View {
    @Binding var currentView: AppView
    @Binding var selectedPatientID: String
    
    @State private var ptFirstNameEdit: String = ""
    @State private var ptLastNameEdit: String = ""
    @State private var selectedUnitEdit: String = ""
    @State private var selectedAgeEdit: String = ""
    @State private var selectedSexEdit: String = ""
    @State private var ptIDEdit: String = ""
    
    private let ages = (Array(0...100)).map { String($0) }
    private let units = ["ATP", "ATP-STS", "Compass", "CPAS", "Adult Program", "Bridge"]
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
                                    
                                    Image(systemName: "square.and.pencil")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width * 0.04, height: geometry.size.height * 0.04)
                                        .padding(.trailing, geometry.size.width * 0.025)
                                                                        
                                    Text("Edit Patient Info")
                                        .font(.system(size: geometry.size.height * 0.025, weight: .heavy))
                                        .multilineTextAlignment(.center)
                              
                                    Spacer()
                                }
                                .foregroundColor(Color.white)
                                
                                VStack {
                                    HStack(spacing: geometry.size.width * 0.02) {
                                        VStack(alignment: .center) {
                                            HStack {
                                                Spacer()
                                                Text("First Name")
                                                    .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                    .foregroundColor(.white)
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Spacer()
                                                TextField("\(ptFirstNameEdit)", text: $ptFirstNameEdit)
                                                    .disableAutocorrection(true)
                                                    .foregroundColor(.black)
                                                    .font(.system(size: geometry.size.height * 0.014, weight: .light, design: .default))
                                                    .multilineTextAlignment(.center)
                                                    .padding(geometry.size.height * 0.014)
                                                    .background(Color(hex: 0xF6FCFE))
                                                    .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
                                                    .cornerRadius(geometry.size.width * 0.01)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                                            .stroke(Color(hex: 0xDFE6E9), lineWidth: geometry.size.width * 0.004)
                                                    )
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                                Spacer()
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .center) {
                                            HStack {
                                                Spacer()
                                                Text("Last Name")
                                                    .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                    .foregroundColor(.white)
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Spacer()
                                                TextField("\(ptLastNameEdit)", text: $ptLastNameEdit)
                                                    .disableAutocorrection(true)
                                                    .foregroundColor(.black)
                                                    .font(.system(size: geometry.size.height * 0.014, weight: .light, design: .default))
                                                    .multilineTextAlignment(.center)
                                                    .padding(geometry.size.height * 0.014)
                                                    .background(Color(hex: 0xF6FCFE))
                                                    .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
                                                    .cornerRadius(geometry.size.width * 0.01)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                                            .stroke(Color(hex: 0xDFE6E9), lineWidth: geometry.size.width * 0.004)
                                                    )
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                                Spacer()
                                            }
                                        }
                                    }
                                    .frame(width: geometry.size.width * 0.8)
                                    .padding(.top, geometry.size.height * 0.08)
                                    
                                    HStack(spacing: geometry.size.width * 0.02) {
                                        VStack(alignment: .center) {
                                            HStack {
                                                Spacer()
                                                Text("Unit")
                                                    .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                    .foregroundColor(.white)
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Spacer()
                                                Picker("", selection: $selectedUnitEdit) {
                                                    ForEach(units, id: \.self) { unit in
                                                        Text(unit).tag(unit) // Display options excluding the empty string
                                                    }
                                                }
                                                .pickerStyle(MenuPickerStyle())
                                                .padding(geometry.size.height * 0.014)
                                                .frame(width: geometry.size.width * 0.3)
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
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .center) {
                                            HStack {
                                                Spacer()
                                                Text("Biological Sex")
                                                    .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                    .foregroundColor(.white)
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Spacer()
                                                Picker("", selection: $selectedSexEdit) {
                                                    ForEach(0..<["Male", "Female"].count, id: \.self) { index in
                                                        Text("\(["Male", "Female"][index])")
                                                            .tag(["Male", "Female"][index])
                                                    }
                                                }
                                                .pickerStyle(MenuPickerStyle())
                                                .padding(geometry.size.height * 0.014)
                                                .frame(width: geometry.size.width * 0.3)
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
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .center) {
                                            HStack {
                                                Spacer()
                                                Text("Age")
                                                    .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                    .foregroundColor(.white)
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Spacer()
                                                Picker("", selection: $selectedAgeEdit) {
                                                    ForEach(0..<ages.count, id: \.self) { index in
                                                        Text("\(ages[index])")
                                                            .tag(ages[index])
                                                    }
                                                }
                                                .pickerStyle(MenuPickerStyle())
                                                .padding(geometry.size.height * 0.014)
                                                .frame(width: geometry.size.width * 0.1)
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
                                    }
                                    .frame(width: geometry.size.width * 0.8)
                                    .padding(.top, geometry.size.height * 0.04)
                                    
                                    HStack {
                                        VStack(alignment: .center) {
                                            HStack {
                                                Spacer()
                                                Text("Patient ID")
                                                    .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                    .foregroundColor(.white)
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Spacer()
                                                TextField("", text: $ptIDEdit)
                                                    .disableAutocorrection(true)
                                                    .foregroundColor(.black)
                                                    .font(.system(size: geometry.size.height * 0.014, weight: .light, design: .default))
                                                    .multilineTextAlignment(.center)
                                                    .padding(geometry.size.height * 0.014)
                                                    .background(Color(hex: 0xF6FCFE))
                                                    .border(Color(hex: 0xDFE6E9), width: geometry.size.width * 0.003)
                                                    .cornerRadius(geometry.size.width * 0.01)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                                            .stroke(Color(hex: 0xDFE6E9), lineWidth: geometry.size.width * 0.004)
                                                    )
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                                    .frame(width: geometry.size.width * 0.6)
                                                    .disabled(true)
                                                    .opacity(0.9)
                                                Spacer()
                                            }
                                            
                                            Text("This is a unique value used to identify the patient and control their information. Please make sure that it is enetered correctly. It can't be edited.")
                                                .font(.system(size: geometry.size.height * 0.01, weight: .regular))
                                                .foregroundColor(Color.white)
                                                .multilineTextAlignment(.center)
                                                .frame(width: geometry.size.width * 0.6)
                                        }
                                    }
                                    .frame(width: geometry.size.width * 0.8)
                                    .padding(.top, geometry.size.height * 0.04)
                                    
                                    HStack {
                                        Button(action: {
                                            editPatient()
                                        }) {
                                            HStack {
                                                Text("Confirm Patient Edits")
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
                                            self.currentView = .Patients
                                        }) {
                                            HStack {
                                                Text("Cancel Edits")
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
            editPatientPlaceholders(patientID: selectedPatientID)
        }
    }
    func editPatientPlaceholders(patientID: String) {
        guard let url = URL(string: "http://172.20.10.3:8001/selected-patient-placeholders") else { return }
        
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
                let decodedResponse = try JSONDecoder().decode(PatientPlaceholdersEdit.self, from: data)
                DispatchQueue.main.async {
                    self.ptFirstNameEdit = decodedResponse.ptFirstNamePlaceholder
                    self.ptLastNameEdit = decodedResponse.ptLastNamePlaceholder
                    self.selectedSexEdit = decodedResponse.ptSexPlaceholder
                    self.selectedAgeEdit = decodedResponse.ptAgePlaceholder
                    self.ptIDEdit = decodedResponse.ptIDPlaceholder
                    self.selectedUnitEdit = decodedResponse.ptTagPlaceholder
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
    private func editPatient() {
        let requestBody: [String: Any] = [
            "patientName": ptFirstNameEdit + " " + ptLastNameEdit,
            "patientUnit": selectedUnitEdit,
            "patientSex": selectedSexEdit,
            "patientAge": selectedAgeEdit,
            "patientID": ptIDEdit
        ]

        let url = URL(string: "http://172.20.10.3:8001/edit-patient")!
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
