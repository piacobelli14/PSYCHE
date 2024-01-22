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

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x152234), Color(hex: 0x1D2951)]), startPoint: .top, endPoint: .bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)

            VStack {
                GeometryReader { geometry in
                    VStack(alignment: .center) {
                        Spacer()
                        HStack {
                            Spacer()
                            List(patients, id: \.ptid) { patient in
                                HStack {
                                    Spacer()
                                    Image(systemName: selectedPatientID == patient.ptid ? "checkmark.square.fill" : "square")
                                        .frame(width: geometry.size.width * 0.025)
                                        .foregroundColor(selectedPatientID == patient.ptid ? Color(hex: 0x4E7FD5) : .white)
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
                                            Text("Unit: \(patient.ptage)").font(.subheadline)
                                        }
                                        .frame(width: geometry.size.width * 0.25)
                                        .font(.system(size: geometry.size.height * 0.015, weight: .semibold))
                                    }
                                    .frame(width: geometry.size.width * 0.6)
                                    .foregroundColor(Color.white)
                                    Spacer()
                                }
                                .padding(geometry.size.height * 0.025)
                                .border(Color.white)
                                .cornerRadius(geometry.size.width * 0.01)
                                .overlay(
                                    RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                        .stroke(Color.white, lineWidth: geometry.size.width * 0.004)
                                )
                                .background(Color.clear)
                                .listRowBackground(Color.clear)
                            }
                            .listStyle(PlainListStyle())
                            .frame(width: geometry.size.width * 0.8)
                            .frame(height: geometry.size.height * 0.7)
                            .background(Color.purple)
                            Spacer()
                        }
                        Spacer()
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
