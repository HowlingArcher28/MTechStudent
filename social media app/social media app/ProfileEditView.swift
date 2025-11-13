//
//  ProfileEditView.swift
//  social media app
//
//  Created by Zachary Jensen on 11/12/25.
//

import SwiftUI

struct ProfileEditView: View {
    @EnvironmentObject var model: AppModel
    @Environment(\.dismiss) private var dismiss

    @State private var draft: UserProfile
    @State private var bioCharLimit: Int = 160

    init() {
        // Initialize with a placeholder; real value injected in .onAppear
        _draft = State(initialValue: UserProfile(firstName: "", lastName: "", username: "", bio: "", profileImageName: nil, coverImageName: nil))
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("First name", text: $draft.firstName)
                        .textContentType(.givenName)
                    TextField("Last name", text: $draft.lastName)
                        .textContentType(.familyName)
                }

                Section("Username") {
                    TextField("Username", text: $draft.username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }

                Section("Bio") {
                    ZStack(alignment: .bottomTrailing) {
                        TextEditor(text: $draft.bio)
                            .frame(minHeight: 100)
                            .onChange(of: draft.bio) { _, newValue in
                                if newValue.count > bioCharLimit {
                                    draft.bio = String(newValue.prefix(bioCharLimit))
                                }
                            }
                        Text("\(draft.bio.count)/\(bioCharLimit)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .padding(.trailing, 6)
                            .padding(.bottom, 4)
                    }
                }

                // Placeholder for future avatar editing
                // Section("Avatar") { ... PhotosPicker ... }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .disabled(draft.username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
        .onAppear {
            // Load the current profile into the draft
            draft = model.profile
        }
    }

    private func save() {
        draft.firstName = draft.firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        draft.lastName = draft.lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        draft.username = draft.username.trimmingCharacters(in: .whitespacesAndNewlines)
        model.profile = draft
        dismiss()
    }
}

#Preview {
    let model = AppModel()
    return ProfileEditView()
        .environmentObject(model)
}

