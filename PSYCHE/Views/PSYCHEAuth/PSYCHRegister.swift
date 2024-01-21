//
//  PSYCHRegister.swift
//  PSYCHE
//
//  Created by Peter Iacobelli on 1/20/24.
//

import SwiftUI
import PhotosUI

struct createPasswordDynamicStyle: ViewModifier {
    let geometry: GeometryProxy

    func body(content: Content) -> some View {
        content
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
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var onSelect: (UIImage) -> Void

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        if let uiImage = image as? UIImage {
                            self.parent.image = uiImage
                            self.parent.onSelect(uiImage)  // Pass the selected image
                        }
                    }
                }
            }
        }
    }
}

struct ImagePickerView: View {
    @Binding var showImagePicker: Bool
    @Binding var selectedImage: UIImage?
    @Binding var imageBase64: String

    var body: some View {
        if showImagePicker {
            PhotoPicker(image: $selectedImage) { uiImage in
                self.selectedImage = uiImage
                if let base64String = convertImageToBase64String(img: uiImage) {
                    DispatchQueue.main.async {
                        self.imageBase64 = base64String
                    }
                }
                self.showImagePicker = false
            }
        }
    }

    private func convertImageToBase64String(img: UIImage) -> String? {
        guard let imageData = img.jpegData(compressionQuality: 1.0) else { return nil } // Reduced quality
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
}


struct PSYCHRegister: View {
    @Binding var currentView: AppView
        
    @State private var imageBase64: String = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var isNewPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    @State private var errorMessage: String? = nil


    var body: some View {
        ZStack {
            
            AnimatedStarsView()
                .ignoresSafeArea()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: 0x152234), Color(hex: 0x1D2951)]), startPoint: .top, endPoint: .bottom)
                )
            
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
                        )
                        .padding(.top, geometry.size.height * 0.03)
                        .padding(.leading, geometry.size.height * 0.035)
                        Spacer()
                    }

                    VStack(alignment: .center) {
                        HStack {
                            Spacer()
                           
                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.12)
                                    .shadow(color: .gray, radius: geometry.size.width * 0.01)
                            } else {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.12)
                                    .shadow(color: .gray, radius: geometry.size.width * 0.01)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        .padding(.top, geometry.size.height * 0.05)

                        HStack {
                            Spacer()
                            if !showImagePicker {
                                Button(action: {
                                    if selectedImage != nil {
                                        selectedImage = nil
                                    } else {
                                        showImagePicker = true
                                    }
                                }) {
                                    if selectedImage != nil {
                                        HStack {
                                            Text("Remove Selected Photo?")
                                                .font(.system(size: geometry.size.height * 0.01, weight: .semibold, design: .default))
                                                .foregroundColor(Color(hex: 0xF5F5F5))
                                        }
                                        .frame(width: geometry.size.width * 0.3)
                                        .padding(geometry.size.height * 0.016)
                                        .cornerRadius(geometry.size.width * 0.01)
                                        .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                    } else {
                                        HStack {
                                            Text("Upload Profile Picture?")
                                                .font(.system(size: geometry.size.height * 0.01, weight: .semibold, design: .default))
                                                .foregroundColor(Color(hex: 0xF5F5F5))
                                        }
                                        .frame(width: geometry.size.width * 0.3)
                                        .padding(geometry.size.height * 0.016)
                                        .cornerRadius(geometry.size.width * 0.01)
                                        .shadow(color: .gray, radius: geometry.size.width * 0.004)
                                    }
                                }
                                .background(selectedImage !== nil ? Color(hex: 0x4E7FD5) : Color.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                        .stroke(Color(hex: 0xDFE6E9), lineWidth: geometry.size.width * 0.004)
                                )
                                .padding(.top, geometry.size.height * 0.04)

                            }
                            Spacer()
                        }
                        .padding(.leading, geometry.size.width * 0.006)
                        .padding(.top, geometry.size.height * -0.02)
                        
                        ZStack {
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
                                            TextField("First Name", text: $firstName)
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
                                            TextField("Last Name", text: $lastName)
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
                                .padding(.top, geometry.size.height * 0.1)
                                
                                HStack(spacing: geometry.size.width * 0.02) {
                                    VStack(alignment: .center) {
                                        HStack {
                                            Spacer()
                                            Text("Email")
                                                .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                .foregroundColor(.white)
                                                .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            Spacer()
                                            TextField("Email", text: $email)
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
                                            Text("Username")
                                                .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                .foregroundColor(.white)
                                                .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            Spacer()
                                            TextField("Username", text: $username)
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
                                .padding(.top, geometry.size.height * 0.04)
                                
                                HStack(spacing: geometry.size.width * 0.02) {
                                    VStack(alignment: .center) {
                                        HStack {
                                            Spacer()
                                            Text("New Password")
                                                .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                .foregroundColor(.white)
                                                .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            Spacer()
                                            ZStack {
                                                if isNewPasswordVisible {
                                                    TextField("New Password", text: $newPassword)
                                                        .modifier(createPasswordDynamicStyle(geometry: geometry))
                                                } else {
                                                    SecureField("New Password", text: $newPassword)
                                                        .modifier(createPasswordDynamicStyle(geometry: geometry))
                                                }
                                                HStack {
                                                    Spacer()
                                                    Button(action: {
                                                        isNewPasswordVisible.toggle()
                                                    }) {
                                                        Image(systemName: isNewPasswordVisible ? "eye.slash" : "eye")
                                                            .foregroundColor(Color(hex: 0x828B8E))
                                                            .font(.system(size: geometry.size.height * 0.012))
                                                    }
                                                    .padding(.trailing, geometry.size.width * 0.03)
                                                }
                                            }
                                            Spacer()
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .center) {
                                        HStack {
                                            Spacer()
                                            Text("Confirm Password")
                                                .font(.system(size: geometry.size.height * 0.016, weight: .semibold, design: .default))
                                                .foregroundColor(.white)
                                                .shadow(color: .gray, radius: geometry.size.width * 0.0004)
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            Spacer()
                                            ZStack {
                                                if isConfirmPasswordVisible {
                                                    TextField("Confirm Password", text: $confirmPassword)
                                                        .modifier(createPasswordDynamicStyle(geometry: geometry))
                                                } else {
                                                    SecureField("Confirm Password", text: $confirmPassword)
                                                        .modifier(createPasswordDynamicStyle(geometry: geometry))
                                                }
                                                HStack {
                                                    Spacer()
                                                    Button(action: {
                                                        isConfirmPasswordVisible.toggle()
                                                    }) {
                                                        Image(systemName: isConfirmPasswordVisible ? "eye.slash" : "eye")
                                                            .foregroundColor(Color(hex: 0x828B8E))
                                                            .font(.system(size: geometry.size.height * 0.012))
                                                    }
                                                    .padding(.trailing, geometry.size.width * 0.03)
                                                }
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                                .frame(width: geometry.size.width * 0.8)
                                .padding(.top, geometry.size.height * 0.04)
                                
                                
                                HStack {
                                    Button(action: {
                                        self.validateAndRegisterUser()
                                    }) {
                                        HStack {
                                            Text("Create New Account")
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
                                .padding(.top, geometry.size.height * 0.1)
                                
                                if let errorMessage = errorMessage {
                                    Text(errorMessage)
                                        .foregroundColor(.red)
                                        .font(.system(size: geometry.size.height * 0.012))
                                        .padding(.top, geometry.size.height * 0.02)
                                }
                            }
                            
                            ImagePickerView(showImagePicker: $showImagePicker, selectedImage: $selectedImage, imageBase64: $imageBase64)
                                                            .padding(.top, geometry.size.height * 0.05)
                        }
                    }
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    private func validateAndRegisterUser() {
        guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !username.isEmpty, !newPassword.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "All fields are required."
            return
        }

        guard newPassword == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        guard isValidPassword(newPassword) else {
            errorMessage = "Password must contain at least 8 characters, including uppercase, lowercase, digits, and special characters."
            return
        }
        registerUser()
    }
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    private func registerUser() {
        guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !username.isEmpty, !newPassword.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "All fields are required."
            return
        }

        guard newPassword == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        guard isValidPassword(newPassword) else {
            errorMessage = "Password must contain at least 8 characters, including uppercase, lowercase, digits, and special characters."
            return
        }
        
        guard !imageBase64.isEmpty else {
                errorMessage = "Please select an image."
                return
        }

        let requestBody: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "username": username,
            "password": newPassword,
            "image": imageBase64,
        ]

        let url = URL(string: "http://172.20.10.3:8001/register-user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        // Perform the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // Handle the error - Error making the request
                errorMessage = "Registration failed: \(error.localizedDescription)"
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                // Handle the error - No data or response
                errorMessage = "Registration failed: No response received."
                return
            }

            if response.statusCode == 200 {
                self.currentView = .Login
            } else {
                errorMessage = "This username or email is already taken. Please choose a different username or email."
            }
        }.resume()
    }
}

