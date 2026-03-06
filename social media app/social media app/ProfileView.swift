import SwiftUI

struct ProfileView: View {

    @EnvironmentObject var auth: AuthModel

    var body: some View {
        VStack(spacing: 16) {
            if let token = auth.bearerToken {
                Text("Logged in!")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Bearer Token:")
                        .font(.headline)
                    Text(token)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                        .truncationMode(.middle)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

                if let secret = auth.userSecret {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("User Secret:")
                            .font(.headline)
                        Text(secret)
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .lineLimit(3)
                            .truncationMode(.middle)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                }

                Button(role: .destructive) {
                    auth.bearerToken = nil
                    auth.userSecret = nil
                    auth.isLoggedIn = false
                } label: {
                    Text("Sign Out")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            } else {
                Text("Not logged in")
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
    }
}
