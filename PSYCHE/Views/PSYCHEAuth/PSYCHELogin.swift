//
//  PSYCHELogin.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/20/24.
//

import SwiftUI
import UIKit
import LocalAuthentication

struct passwordInputDynamicStyle: ViewModifier {
    let geometry: GeometryProxy

    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .foregroundColor(.black)
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
}

struct AnimatedStarsView: View {
    let numberOfStars = 100
    let starSize = CGSize(width: 2, height: 2)
    
    var body: some View {
        Canvas { context, size in
            for _ in 0..<numberOfStars {
                var star = Path()
                let xPosition = Double.random(in: 0..<size.width)
                let yPosition = Double.random(in: 0..<size.height)

                star.addEllipse(in: CGRect(x: xPosition, y: yPosition, width: starSize.width, height: starSize.height))
                context.fill(star, with: .color(.white))
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PSYCHELogin: View {
    @Binding var currentView: AppView
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoginSuccessful = false
    @State private var isPasswordVisible = false
    
    var body: some View {
        ZStack {
            
            AnimatedStarsView()
                .ignoresSafeArea()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: 0x1D2951), Color(hex: 0x093571)]), startPoint: .top, endPoint: .bottom)
                )
            
            VStack {
                GeometryReader { geometry in

                    VStack(alignment: .center) {
                        HStack {
                            Spacer()
                            Image("psycheLogo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.2)
                                .shadow(color: .gray, radius: geometry.size.width * 0.01)
                            Spacer()
                        }
                        .padding(.top, geometry.size.height * 0.05)

                        HStack {
                            Spacer()
                            Text("PSYCHE")
                                .font(.system(size: geometry.size.height * 0.06, weight: .bold, design: .default))
                                .foregroundColor(.white)
                                .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                
                            Spacer()
                        }
                        .padding(.leading, geometry.size.width * 0.006)
                        .padding(.top, geometry.size.height * -0.02)
                        
                        HStack {
                            Spacer()
                            ForEach("Psychiatric System for Yielding Comprehensive Health Evaluations".split(separator: " "), id: \.self) { word in
                                if word == "for" {
                                    Text(verbatim: String(word))
                                        .font(.system(size: geometry.size.height * 0.012, weight: .regular, design: .default))
                                        .foregroundColor(.white)
                                } else {
                                    Text(verbatim: String(word.first!))
                                        .font(.system(size: geometry.size.height * 0.012, weight: .heavy, design: .default))
                                
                                        .foregroundColor(.white) +
                                    Text(verbatim: String(word.dropFirst()))
                                        .font(.system(size: geometry.size.height * 0.012, weight: .regular, design: .default))
                                        .foregroundColor(.white)
                                }
                            }
                            .shadow(color: .gray, radius: geometry.size.width * 0.004)
                            Spacer()
                        }
                        .padding(.leading, geometry.size.width * 0.003)
                        .padding(.bottom, geometry.size.height * 0.1)
                        
                        
                        VStack(alignment: .center) {
                            HStack {
                                Spacer()
                                Text("Username")
                                    .font(.system(size: geometry.size.height * 0.02, weight: .semibold, design: .default))
                                    .foregroundColor(.white)
                                    .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                TextField("Username", text: $username)
                                    .disableAutocorrection(true)
                                    .foregroundColor(.black)
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
                                    .frame(width: geometry.size.width * 0.8)
                                    .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                Button(
                                    action: {
                                        self.currentView = .Register
                                    },
                                    label: {
                                        Text("Create an account.")
                                            .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                            .foregroundColor(Color(hex: 0x4E7FD5))
                                            .underline(true)
                                            .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                    }
                                )
                                .padding(.trailing, geometry.size.width * 0.003)
                            }
                            .frame(width: geometry.size.width * 0.8)
                        }
                        
                        VStack(alignment: .center) {
                            HStack {
                                Spacer()
                                Text("Password")
                                    .font(.system(size: geometry.size.height * 0.02, weight: .semibold, design: .default))
                                    .foregroundColor(.white)
                                    .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                ZStack {
                                    if isPasswordVisible {
                                        TextField("Password", text: $password)
                                            .modifier(passwordInputDynamicStyle(geometry: geometry))
                                    } else {
                                        SecureField("Password", text: $password)
                                            .modifier(passwordInputDynamicStyle(geometry: geometry))
                                    }
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            isPasswordVisible.toggle()
                                        }) {
                                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                                .foregroundColor(Color(hex: 0x828B8E))
                                                .font(.system(size: geometry.size.height * 0.016))
                                        }
                                        .padding(.trailing, geometry.size.width * 0.03)
                                    }
                                }
                                .frame(width: geometry.size.width * 0.8)
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                Button(
                                    action: {
                                        self.currentView = .Reset
                                    },
                                    label: {
                                        Text("Forgot password?")
                                            .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                            .foregroundColor(Color(hex: 0x4E7FD5))
                                            .underline(true)
                                            .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                    }
                                )
                                .padding(.trailing, geometry.size.width * 0.003)
                            }
                            .frame(width: geometry.size.width * 0.8)
                        }
                        .padding(.top, geometry.size.height * 0.02)
                        
                        HStack {
                            Button(action: {
                                authenticateUser()
                            }) {
                                HStack {
                                    Text("Login to System")
                                        .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                        .foregroundColor(Color(hex: 0xF5F5F5))
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.white)
                                        .font(.system(size: geometry.size.height * 0.016))
                                    
                                }
                                .frame(width: geometry.size.width * 0.5)
                                .padding(geometry.size.height * 0.016)
                                .background(Color(hex: 0x4E7FD5))
                                .cornerRadius(geometry.size.width * 0.01)
                                .shadow(color: .gray, radius: geometry.size.width * 0.004)
                            }
                        }
                        .padding(.top, geometry.size.height * 0.1)
                    }
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    private func authenticateUser() {
        
        let requestBody: [String: Any] = [
            "username": username,
            "password": password
        ]

        let url = URL(string: "http://172.20.10.3:8001/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.isLoginSuccessful = false
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                self.isLoginSuccessful = false
                return
            }

            if response.statusCode == 200 {
                self.isLoginSuccessful = true
                self.currentView = .Patients
            } else {
                self.isLoginSuccessful = false
            }
        }.resume()
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
