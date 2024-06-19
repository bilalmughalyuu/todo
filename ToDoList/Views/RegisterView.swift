import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = RegisterViewModel()
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(
                    title: "Register",
                    subTitle: "Start orginizing todos",
                    angle: -15,
                    backGroundColor: .orange
                )
                
                Form {
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Full name", text: $viewModel.fullName)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    HStack {
                        if(viewModel.isPasswordVisible) {
                            TextField("Password", text: $viewModel.password)
                                .textFieldStyle(DefaultTextFieldStyle())
                        } else {
                            SecureField("Password", text: $viewModel.password)
                                .textFieldStyle(DefaultTextFieldStyle())
                        }
                        
                        Button(action: {
                            viewModel.isPasswordVisible.toggle()
                                    }) {
                                        Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                                    }
                    }
                    
                    TLButtonView(title: "Create Account", backGroundColor: Color.green, action: {
                        viewModel.register()
                    })
                }
                
                VStack {
                    Text("Already have account!")
                    Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    Text("Go to Login Screen")
                                }
                }
                .padding(.bottom, 50)
                
            }
            .padding(.top, 16)
        }
    }
}

#Preview {
    RegisterView()
}
