import SwiftUI

struct LoginView: View {

    @EnvironmentObject var auth: AuthModel
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggingIn = false

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {

                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                Button(action: {
                    Task {
                        isLoggingIn = true
                        await auth.signIn(email: email, password: password)
                        isLoggingIn = false
                    }
                }) {
                    if isLoggingIn {
                        ProgressView()
                    } else {
                        Text("Sign In")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }

            }
            .padding()
            .navigationTitle("Login")
            .alert(item: $auth.alertMessage) { alert in
                Alert(title: Text("Error"), message: Text(alert.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}
