import SwiftUI

struct ProfileView: View {

    @EnvironmentObject var auth: AuthModel

    var body: some View {
        VStack(spacing: 16) {
            if let user = auth.user {
                Text("Logged in!")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Name:")
                        .font(.headline)
                    Text("\(user.firstName) \(user.lastName)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Username:")
                        .font(.headline)
                    Text(user.userName)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Email:")
                        .font(.headline)
                    Text(user.email)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

                Button(role: .destructive) {
                    auth.user = nil
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
