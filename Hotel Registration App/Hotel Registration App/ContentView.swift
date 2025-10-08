//
//  ContentView.swift
//  Hotel Registration App

import SwiftUI

struct ContentView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var roomNumber = ""
    @State private var numberOfGuests = ""
    @State private var lengthOfStay = ""
    @State private var nonSmoking = false
    @State private var registrationFeedback = 0
    @State private var submitted = false
    @FocusState private var isNameFocused: Bool

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack {
                HStack {
                    
                    // MARK: - Logo
                    
                    Image("mountainlandLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)

                    Text("Mountainland Inn")
                        .font(.custom("Verdana", size: 30))
                        .bold()
                        .foregroundStyle(Color.background)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.highlight)
                        }
                }

                Spacer()
                
                // MARK: - FIRST NAME
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Guest Name")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 10) {
                        Image(systemName: "person.fill")
                            .foregroundStyle(.highlight)

                        TextField("First Name", text: $firstName)
                            .textContentType(.name)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled(true)
                            .submitLabel(.done)
                    }
                    .modifier(RyanKnowsBest())
                }
                .padding(.horizontal)
                
                // MARK: - LAST NAME
                
                HStack(spacing: 10) {
                    Image(systemName: "person.fill")
                        .foregroundStyle(.highlight)

                    TextField("Last Name", text: $lastName)
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled(true)
                        .submitLabel(.done)
                }
                .modifier(RyanKnowsBest())
                .padding(.horizontal)
                
                // MARK: - ROOM NUMBER
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Room Number")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 10) {
                        Image(systemName: "key.fill")
                            .foregroundStyle(.highlight)

                        TextField("Room Number", text: $roomNumber)
                            .textContentType(.name)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled(true)
                            .submitLabel(.done)
                    }
                    .modifier(RyanKnowsBest())
                }
                .padding(.horizontal)
                
                // MARK: - NUMBER OF GUESTS
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Number of Guests")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 10) {
                        Image(systemName: "person.2.fill")
                            .foregroundStyle(.highlight)

                        TextField("Number of Guests", text: $numberOfGuests)
                            .textContentType(.name)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                            .submitLabel(.done)
                    }
                    .modifier(RyanKnowsBest())
                }
                .padding(.horizontal)
                
                // MARK: - LENGTH OF STAY
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Length of Stay (nights)")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 10) {
                        Image(systemName: "calendar")
                            .foregroundStyle(.highlight)

                        TextField("Nights", text: $lengthOfStay)
                            .keyboardType(.numberPad)
                            .submitLabel(.done)
                    }
                    .modifier(RyanKnowsBest())
                }
                .padding(.horizontal)
                
                // MARK: - NON-SMOKING
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Preferences")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    HStack {
                        Image(systemName: "nosign")
                            .foregroundStyle(.highlight)
                        Toggle(isOn: $nonSmoking) {
                            Text("Non-Smoking Room")
                        }
                        .tint(.highlight)
                    }
                    .modifier(RyanKnowsBest())
                }
                .padding(.horizontal)
                
                // MARK: - REGISTRATION FEEDBACK (1–5 stars)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Registration Feedback")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 8) {
                        ForEach(1...5, id: \.self) { star in
                            Button {
                                registrationFeedback = star
                            } label: {
                                Image(systemName: star <= registrationFeedback ? "star.fill" : "star")
                                    .foregroundStyle(star <= registrationFeedback ? Color.highlight
                                                                                   : Color.highlight.opacity(0.35))
                                    .imageScale(.large)
                                    .accessibilityLabel("\(star) star\(star == 1 ? "" : "s")")
                            }
                            .buttonStyle(.plain)
                        }
                        Spacer()
                        Text("\(registrationFeedback)/5")
                            .foregroundStyle(.secondary)
                    }
                    .modifier(RyanKnowsBest())
                }
                .padding(.horizontal)

                // MARK: - SUBMIT + POST-SUBMISSION RATING

                Button("Submit") {
                    submitted.toggle()
                }
                .buttonStyle(.borderedProminent)
                .tint(.highlight)
                .padding(.top, 8)

                if submitted {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Thank you for booking with us! How would you rate your experience?")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        HStack(spacing: 12) {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.highlight)

                            Slider(
                                value: Binding<Double>(
                                    get: { Double(registrationFeedback) },
                                    set: { registrationFeedback = Int($0) }
                                ),
                                in: 1...5,
                                step: 1
                            )
                            .tint(.highlight)
                        }

                        Text("\(registrationFeedback)/5 ⭐️s")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .modifier(RyanKnowsBest())
                    .padding(.horizontal)
                }

                Spacer()

            }
        }
    }
}

struct RyanKnowsBest: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.ultraThinMaterial)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(.highlight, lineWidth: 1)
            }
            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    ContentView()
}
