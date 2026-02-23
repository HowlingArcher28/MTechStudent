import SwiftUI

struct LoginView: View {
    @Environment(AuthModel.self) private var auth
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            VStack(spacing: 8) {
                Text("Welcome Back")
                    .font(.largeTitle.bold())
                Text("Sign in to continue")
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .textContentType(.username)
                    .autocorrectionDisabled()
                    .padding(12)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))

                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .padding(12)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))

                if let error = auth.errorMessage, !error.isEmpty {
                    Text(error)
                        .foregroundStyle(.red)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .transition(.opacity)
                }

                Button(action: signIn) {
                    HStack {
                        if auth.isLoading {
                            ProgressView()
                                .tint(.white)
                        }
                        Text(auth.isLoading ? "Signing In…" : "Sign In")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(AppTheme.primaryRed)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(auth.isLoading)

                Button {
                    Task {
                        let result = await auth.testServer()
                        if result == nil {
                            // errorMessage is set in the model; nothing to do here
                        }
                    }
                } label: {
                    HStack {
                        Text("Test Server")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .foregroundStyle(AppTheme.primaryRed)
                }
                .disabled(auth.isLoading)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .background(
            LinearGradient(colors: [.black.opacity(0.05), .clear], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }

    private func signIn() {
        Task { await auth.login(email: email, password: password) }
    }
}

#Preview {
    LoginView()
        .environment(AuthModel())
}
