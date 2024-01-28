//
//  PSYCHEReset.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/20/24.
//

import SwiftUI

struct resetPasswordDynamicStyle: ViewModifier {
    let geometry: GeometryProxy

    func body(content: Content) -> some View {
        content
            .frame(width: geometry.size.width * 0.5)
            .padding(geometry.size.height * 0.016)
            .background(Color(hex: 0x4E7FD5))
            .cornerRadius(geometry.size.width * 0.01)
            .shadow(color: .gray, radius: geometry.size.width * 0.004)
    }
}

struct newPasswordEntryDynamicStyle: ViewModifier {
    let geometry: GeometryProxy
    
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .foregroundColor(.black)
            .font(.system(size: geometry.size.height * 0.02, weight: .light, design: .default))
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

struct PSYCHEReset: View {
    
    @Binding var currentView: AppView
    
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var resetResultMessage: String = ""
    @State private var resetCode: String = ""
    @State private var resetExpiration: String = ""
    @State private var enteredResetCode: String = ""
    @State private var isReset = true
    @State private var isResetValid = false
    @State private var errorMessage: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var passwordErrorMessage: String = ""
    @State private var isPasswordValid: String = ""
    @State private var currentPassword: String = ""
    @State private var resetErrorMessage: String = ""
    @State private var passwordsMatch = false
    @State private var passwordMeetsCriteria = false
    @State private var passwordResetText: String = "Confirm New Password"
    @State private var passwordResetImage: String = "checkmark"
    @State private var isNewPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x1D2951), Color(hex: 0x1D2951)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            AnimatedStarsView()
            
            VStack {
                GeometryReader { geometry in
                    HStack {
                        Button(action: {
                            currentView = .Login
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
                        )
                        .padding(.top, geometry.size.height * 0.03)
                        .padding(.leading, geometry.size.height * 0.035)
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                        if isReset {
                            
                            HStack {
                                Spacer()
                                Text("Enter Your Email Address")
                                    .font(.system(size: geometry.size.height * 0.02, weight: .semibold, design: .default))
                                    .foregroundColor(.white)
                                    .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                TextField("", text: $email)
                                    .disableAutocorrection(true)
                                    .foregroundColor(.black)
                                    .font(.system(size: geometry.size.height * 0.02, weight: .light, design: .default))
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
                                    .multilineTextAlignment(.center)
                                    .onTapGesture {
                                        email = ""
                                    }
                                Spacer()
                            }
                            .frame(width: geometry.size.width * 0.7)
                            .background(Color(hex: 0x1D2951))
                            
                            HStack {
                                Spacer()
                                Text(resetResultMessage)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .font(.system(size: geometry.size.height * 0.015, weight: .semibold, design: .default))
                                    .padding(.top, geometry.size.height * 0.02)
                                    .padding(.bottom, geometry.size.height * 0.015)
                                Spacer()
                            }
                            .frame(width: geometry.size.width * 0.8)
                            .background(Color(hex: 0x1D2951))
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.initiatePasswordReset()
                                }) {
                                    HStack {
                                        Text("Reset Password")
                                            .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                            .foregroundColor(Color(hex: 0xF5F5F5))
                                        
                                        Image(systemName: "envelope")
                                            .foregroundColor(.white)
                                            .font(.system(size: geometry.size.height * 0.016))
                                    }
                                    .frame(width: geometry.size.width * 0.5)
                                    .padding(geometry.size.height * 0.016)
                                    .background(Color(hex: 0x4E7FD5))
                                    .cornerRadius(geometry.size.width * 0.01)
                                    .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                }
                                .background(Color(hex: 0x1D2951))
                                Spacer()
                            }
                        } else {
                            if !isResetValid {
                                VStack (alignment: .center) {
                                    VStack(alignment: .center) {
                                        HStack {
                                            Spacer()
                                            Text("Enter Your Password Reset Code")
                                                .font(.system(size: geometry.size.height * 0.02, weight: .semibold, design: .default))
                                                .foregroundColor(.white)
                                                .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                            Spacer()
                                        }
                                        .background(Color(hex: 0x1D2951))
                                        
                                        HStack {
                                            Spacer()
                                            TextField("", text: $enteredResetCode)
                                                .disableAutocorrection(true)
                                                .foregroundColor(.black)
                                                .font(.system(size: geometry.size.height * 0.02, weight: .light, design: .default))
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
                                                
                                                .onChange(of: enteredResetCode) { newValue in
                                                    let dateFormatter = DateFormatter()
                                                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"

                                                    if let expirationTime = dateFormatter.date(from: resetExpiration), newValue == resetCode {
                                                        let currentTime = Date()
                                                        if currentTime < expirationTime {
                                                            isResetValid = true
                                                            resetErrorMessage = ""
                                                        } else {
                                                            isResetValid = false
                                                            resetErrorMessage = "Reset code has expired."
                                                        }
                                                    } else {
                                                        isResetValid = false
                                                        resetErrorMessage = ""
                                                    }
                                                }



                                            Spacer()
                                        }
                                        .frame(width: geometry.size.width * 0.6)
                                        .background(Color(hex: 0x1D2951))
                                    }
                                }
                                .frame(width: geometry.size.width * 1)
                                
                                VStack(alignment: .center) {
                                    
                                    
                                    HStack {
                                        Spacer()
                                        Text(resetErrorMessage)
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                            .font(.system(size: geometry.size.height * 0.015, weight: .semibold, design: .default))
                                            .padding(.top, geometry.size.height * 0.02)
                                            .padding(.bottom, geometry.size.height * 0.015)
                                            .background(Color(hex: 0x1D2951))
                                        Spacer()
                                    }
                                    .frame(width: geometry.size.width * 0.8)
                                }
                            } else {
                                VStack(alignment: .center) {
                                    VStack(alignment: .center) {
                                        HStack {
                                            Spacer()
                                            Text("New Password")
                                                .font(.system(size: geometry.size.height * 0.02, weight: .semibold, design: .default))
                                                .foregroundColor(.white)
                                                .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                            Spacer()
                                        }
                                        .background(Color(hex: 0x1D2951))
                                        
                                        HStack {
                                            Spacer()
                                            ZStack {
                                                if isNewPasswordVisible {
                                                    TextField("", text: $newPassword)
                                                        .modifier(newPasswordEntryDynamicStyle(geometry: geometry))
                                                } else {
                                                    SecureField("", text: $newPassword)
                                                        .modifier(newPasswordEntryDynamicStyle(geometry: geometry))
                                                }
                                                HStack {
                                                    Spacer()
                                                    Button(action: {
                                                        isNewPasswordVisible.toggle()
                                                    }) {
                                                        Image(systemName: isNewPasswordVisible ? "eye.slash" : "eye")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: geometry.size.width * 0.016)
                                                            .frame(height: geometry.size.height * 0.016)
                                                            .foregroundColor(Color(hex: 0x828B8E))
                                                    }
                                                    .padding(.trailing, geometry.size.width * 0.03)
                                                }
                                            }
                                            Spacer()
                                        }
                                        .background(Color(hex: 0x1D2951))
                                    }
                                    .frame(width: geometry.size.width * 0.6)
                                    
                                    VStack(alignment: .center) {
                                        HStack {
                                            Spacer()
                                            Text("Confirm Password")
                                                .font(.system(size: geometry.size.height * 0.02, weight: .semibold, design: .default))
                                                .foregroundColor(.white)
                                                .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                                .background(Color(hex: 0x1D2951))
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            Spacer()
                                            ZStack {
                                                if isConfirmPasswordVisible {
                                                    TextField("", text: $confirmPassword)
                                                        .modifier(newPasswordEntryDynamicStyle(geometry: geometry))
                                                } else {
                                                    SecureField("", text: $confirmPassword)
                                                        .modifier(newPasswordEntryDynamicStyle(geometry: geometry))
                                                }
                                                HStack {
                                                    Spacer()
                                                    Button(action: {
                                                        isConfirmPasswordVisible.toggle()
                                                    }) {
                                                        Image(systemName: isConfirmPasswordVisible ? "eye.slash" : "eye")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: geometry.size.width * 0.016)
                                                            .frame(height: geometry.size.height * 0.016)
                                                            .foregroundColor(Color(hex: 0x828B8E))
                                                    }
                                                    .padding(.trailing, geometry.size.width * 0.03)
                                                }
                                            }
                                            Spacer()
                                        }
                                        .background(Color(hex: 0x1D2951))
                                    }
                                    .frame(width: geometry.size.width * 0.6)
                                    .padding(.top, geometry.size.height * 0.02)
                                }
                                .frame(width: geometry.size.width * 1)
                                
                                
                                HStack {
                                    Spacer()
                                    Text(passwordErrorMessage)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                        .font(.system(size: geometry.size.height * 0.015, weight: .semibold, design: .default))
                                        .padding(.top, geometry.size.height * 0.02)
                                        .padding(.bottom, geometry.size.height * 0.015)
                                        .background(Color(hex: 0x1D2951))
                                    Spacer()
                                }
                                .frame(width: geometry.size.width * 0.6)
                                
                                HStack {
                                    Button(action: {
                                        self.validateNewPassword()
                                    }) {
                                        if passwordsMatch && passwordMeetsCriteria {
                                            HStack {
                                                Image(systemName: passwordResetImage)
                                                    .foregroundColor(.white)
                                                    .font(.system(size: geometry.size.height * 0.016))
                                                
                                                Text(passwordResetText)
                                                    .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                    .foregroundColor(Color(hex: 0xF5F5F5))
                                            }
                                            .modifier(resetPasswordDynamicStyle(geometry: geometry))
                                            .background(Color(hex: 0x1D2951))
                                        } else {
                                            HStack {
                                                Text(passwordResetText)
                                                    .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                    .foregroundColor(Color(hex: 0xF5F5F5))
                                                
                                                Image(systemName: passwordResetImage)
                                                    .foregroundColor(.white)
                                                    .font(.system(size: geometry.size.height * 0.016))
                                            }
                                            .modifier(resetPasswordDynamicStyle(geometry: geometry))
                                            .background(Color(hex: 0x1D2951))
                                        }
                                    }
                                }
                                if let errorMessage = errorMessage {
                                    Text(errorMessage)
                                        .foregroundColor(.red)
                                        .font(.system(size: geometry.size.height * 0.012))
                                        .padding(.top, geometry.size.height * 0.02)
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    private func initiatePasswordReset() {
        guard let url = URL(string: "http://172.20.10.3:8001/reset-password") else {
            return
        }

        let requestBody: [String: Any] = ["email": email]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.resetResultMessage = "Error: \(error.localizedDescription)"
                    } else if let data = data {
                        do {
                            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                if let message = jsonResponse["message"] as? String {
                                    self.resetResultMessage = message
                                    
                                    if message == "Password reset code sent." {
                                        self.resetCode = jsonResponse["resetCode"] as? String ?? "N/A"
                                        self.resetExpiration = jsonResponse["resetExpiration"] as? String ?? "N/A"
                                        self.currentPassword = jsonResponse["currentPassword"] as? String ?? "N/A"
                                        self.isReset = false
                                        self.isResetValid = false
                                    } else {
                                        self.resetCode = ""
                                        self.resetExpiration = ""
                                        self.isReset = true
                                    }
                                }
                            } else {
                                self.resetResultMessage = "Invalid API response."
                            }
                        } catch {
                            self.resetResultMessage = "Failed to parse JSON response."
                        }
                    }
                }
            }.resume()
        } catch {
            resetResultMessage = "Failed to serialize request body."
        }
    }
    private func validateNewPassword() {
        guard !newPassword.isEmpty, !confirmPassword.isEmpty else {
            self.errorMessage = "All fields are required."
            return
        }

        guard newPassword == confirmPassword else {
            self.errorMessage = "Passwords do not match."
            return
        }

        guard isValidPassword(newPassword) else {
            self.errorMessage = "Password must contain at least 8 characters, including uppercase, lowercase, digits, and special characters."
            return
        }
        self.setNewPassword()
    }
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    private func setNewPassword() {
        let requestBody: [String: Any] = [
            "newPassword": newPassword,
            "email": email
        ]
        
        let url = URL(string: "http://172.20.10.3:8001/change-password")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.errorMessage = "Password reset failed: \(error.localizedDescription)."
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                self.errorMessage = "Password reset failed: No response received."
                return
            }
            
            if response.statusCode == 200 {
                currentView = .Login
            }
        }
        .resume()
    }
}
