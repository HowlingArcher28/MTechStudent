import SwiftUI

struct LoginView: View {

    @EnvironmentObject var auth: AuthModel
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Spacer()
                
                // App Title
                Text("Calender App")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                // Error Message
                if let error = auth.errorMessage {
                    Text(error)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(8)
                }
                
                // Email Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.headline)
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                }
                
                // Password Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.headline)
                    SecureField("Enter your password", text: $password)
                        .textContentType(.password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                }
                
                // Sign In Button
                Button(action: {
                    Task {
                        await auth.signIn(email: email, password: password)
                    }
                }) {
                    if auth.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else {
                        Text("Sign In")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(auth.isLoading || email.isEmpty || password.isEmpty)
                .opacity((email.isEmpty || password.isEmpty) ? 0.6 : 1.0)
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}
