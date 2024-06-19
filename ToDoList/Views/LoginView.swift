import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "To Do List", subTitle: "Get things done", angle: 15, backGroundColor: Color.pink)
            
                
                Form {
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    TLButtonView(title: "Login", backGroundColor: .blue) {
                        viewModel.login()
                    }
                }
                
                VStack {
                    Text("New around here?")
                    NavigationLink("Create an account",destination: RegisterView())
                }
                .padding(.bottom, 50)
            }
            .padding(.top, 50)
        }
    }
}

#Preview {
    LoginView()
}
