//
//  PSYCHEEnroll.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/22/24.
//

import SwiftUI

struct PSYCHEEnroll: View {
    @Binding var currentView: AppView
    @Binding var selectedPatientID: String
    
    @State private var ptFirstName: String = ""
    @State private var ptLastName: String = ""
    @State private var ptID: String = ""
    @State private var isMale = true
    let ages = (Array(0...100)).map { String($0) }
    private let units = ["ATP", "ATP-STS", "Compass", "CPAS", "Adult Program", "Bridge"]
    @State private var selectedUnit: String = ""
    @State private var selectedAge: String = ""
    @State private var selectedSex: String = ""
    @State private var errorMessage: String? = nil

    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x1D2951), Color(hex: 0x1D2951)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            AnimatedStarsView()
            
            VStack {
                GeometryReader { geometry in
                    HStack {
                        Button(action: {
                            currentView = .Patients
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
                        
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    
                                    Image(systemName: "person.badge.plus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width * 0.04, height: geometry.size.height * 0.04)
                                        .padding(.trailing, geometry.size.width * 0.025)
                                                                        
                                    Text("Enroll A New Patient")
                                        .font(.system(size: geometry.size.height * 0.025, weight: .heavy))
                                        .multilineTextAlignment(.center)
                              
                                    Spacer()
                                }
                                .foregroundColor(Color.white)
                                .background(Color(hex: 0x1D2951))
                                
                                VStack {
                                    HStack(spacing: geometry.size.width * 0.02) {
                                        VStack(alignment: .center) {
                                            HStack {
                                                Spacer()
                                                Text("First Name")
                                                    .font(.system(size: geometry.size.height * 0.02, weight: .semibold, design: .default))
                                                    .foregroundColor(.white)
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Spacer()
                                                TextField("", text: $ptFirstName)
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
                                        .background(Color(hex: 0x1D2951))
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .center) {
                                            HStack {
                                                Spacer()
                                                Text("Last Name")
                                                    .font(.system(size: geometry.size.height * 0.02, weight: .semibold, design: .default))
                                                    .foregroundColor(.white)
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Spacer()
                                                TextField("", text: $ptLastName)
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
                                        .background(Color(hex: 0x1D2951))
                                    }
                                    .frame(width: geometry.size.width * 0.8)
                                    .padding(.top, geometry.size.height * 0.08)
                                    
                                    
                                    HStack {
                                        VStack(alignment: .center) {
                                            HStack {
                                                Spacer()
                                                Text("Unit")
                                                    .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                    .foregroundColor(.white)
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                                    .frame(width: geometry.size.width * 0.2)
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Spacer()
                                                Menu {
                                                    ForEach(units, id: \.self) { unit in
                                                        Button(unit) {
                                                            selectedUnit = unit
                                                        }
                                                    }
                                                } label: {
                                                    Text(selectedUnit.isEmpty ? "" : selectedUnit)
                                                        .foregroundColor(.black)
                                                        .frame(width: geometry.size.width * 0.2)
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
                                                Spacer()
                                            }
                                        }
                                        .background(Color(hex: 0x1D2951))
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .center) {
                                            HStack {
                                                Spacer()
                                                Text("Biological Sex")
                                                    .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                    .foregroundColor(.white)
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                                    .frame(width: geometry.size.width * 0.2)
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Spacer()
                                                Menu {
                                                    ForEach(["Male", "Female"], id: \.self) { sex in
                                                        Button(sex) {
                                                            selectedSex = sex
                                                        }
                                                    }
                                                } label: {
                                                    Text(selectedSex.isEmpty ? "" : selectedSex)
                                                        .foregroundColor(.black)
                                                        .frame(width: geometry.size.width * 0.2)
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
                                                Spacer()
                                            }
                                        }
                                        .background(Color(hex: 0x1D2951))
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .center) {
                                            HStack {
                                                Spacer()
                                                Text("Age")
                                                    .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                    .foregroundColor(.white)
                                                    .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                                    .frame(width: geometry.size.width * 0.2)
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Spacer()
                                                Menu {
                                                    ForEach(ages, id: \.self) { age in
                                                        Button(age) {
                                                            selectedAge = age
                                                        }
                                                    }
                                                } label: {
                                                    Text(selectedAge.isEmpty ? "" : selectedAge)
                                                        .foregroundColor(.black)
                                                        .frame(width: geometry.size.width * 0.2)
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
                                                Spacer()
                                            }
                                        }
                                        .background(Color(hex: 0x1D2951))
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
                                                TextField("", text: $ptID)
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
                                                Spacer()
                                            }
                                            
                                            Text("This is a unique value used to identify the patient and control their information. Please make sure that it is enetered correctly. It can't be edited.")
                                                .font(.system(size: geometry.size.height * 0.01, weight: .regular))
                                                .foregroundColor(Color.white)
                                                .multilineTextAlignment(.center)
                                                .frame(width: geometry.size.width * 0.6)
                                        }
                                        .background(Color(hex: 0x1D2951))
                                    }
                                    .frame(width: geometry.size.width * 0.8)
                                    .padding(.top, geometry.size.height * 0.04)
                                    
                                    HStack {
                                        Button(action: {
                                            self.enrollPatient()
                                        }) {
                                            HStack {
                                                Text("Confirm New Patient")
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
                                                Text("Cancel Enrollment")
                                                    .font(.system(size: geometry.size.height * 0.012, weight: .semibold, design: .default))
                                                    .foregroundColor(Color(hex: 0xF5F5F5))
                                                    .underline(true)
                                            }
                                            .frame(width: geometry.size.width * 0.5)
                                            .background(Color.clear)
                                            .cornerRadius(geometry.size.width * 0.01)
                                            .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                            .background(Color(hex: 0x1D2951))
                                        }
                                    }
                                    .padding(.top, geometry.size.height * 0.005)
                                    
                                    if let errorMessage = errorMessage {
                                        Text(errorMessage)
                                            .foregroundColor(.red)
                                            .font(.system(size: geometry.size.height * 0.012))
                                            .padding(.top, geometry.size.height * 0.02)
                                            .background(Color(hex: 0x1D2951))
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
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    private func enrollPatient() {
        
        guard !ptFirstName.isEmpty, !ptLastName.isEmpty, !ptID.isEmpty, !selectedAge.isEmpty, !selectedSex.isEmpty, !selectedUnit.isEmpty else {
            self.errorMessage = "All fields are required."
            return
        }
        
        let requestBody: [String: Any] = [
            "patientName": ptFirstName + " " + ptLastName,
            "patientUnit": selectedUnit,
            "patientSex": selectedSex,
            "patientAge": selectedAge,
            "patientID": ptID
        ]

        let url = URL(string: "http://172.20.10.3:8001/enroll-patient")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "That patient ID has already been used. Please select another."
                }
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.errorMessage = "That patient ID has already been used. Please select another."
                }
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
                DispatchQueue.main.async {
                    self.errorMessage = "That patient ID has already been used. Please select another."
                    return
                }
            }
        }
        .resume()
    }
}
