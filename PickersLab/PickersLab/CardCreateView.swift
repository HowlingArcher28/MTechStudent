import SwiftUI
import PhotosUI

struct CardCreateView: View {
    @EnvironmentObject private var store: CardStore

    @State var descriptionText: String = ""
    @State var date: Date = .now
    @State var backgroundColor: Color = .pink
    @State var selectedItem: PhotosPickerItem? = nil
    @State var imageData: Data? = nil

    private func resetForm() {
        descriptionText = ""
        date = .now
        selectedItem = nil
        imageData = nil
    }

    var currentCard: Card {
        Card(description: descriptionText, date: date, backgroundColor: backgroundColor, imageData: imageData)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Description") {
                    TextField("Party details (who/what/where)", text: $descriptionText, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                }

                Section("Date & Time") {
                    DatePicker("When", selection: $date, displayedComponents: [.date, .hourAndMinute])
                }

                Section("Background Color") {
                    ColorPicker("Pick a color", selection: $backgroundColor, supportsOpacity: true)
                }

                Section("Theme Photo") {
                    PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                        HStack {
                            Image(systemName: "photo.on.rectangle")
                            Text(selectedItem == nil ? "Choose a photo" : "Change photo")
                            Spacer()
                            if imageData != nil {
                                Image(uiImage: UIImage(data: imageData!)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 44, height: 44)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }
                    .onChange(of: selectedItem) { _, newItem in
                        guard let newItem else { return }
                        Task {
                            if let data = try? await newItem.loadTransferable(type: Data.self) {
                                await MainActor.run {
                                    self.imageData = data
                                }
                            }
                        }
                    }

                    if let imageData, let uiImage = UIImage(data: imageData) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Selected Photo Preview")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
                    }
                }
            }
            .navigationTitle("Create Card")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        store.add(currentCard)
                        resetForm()
                    }
                    .disabled(descriptionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    CardCreateView()
        .environmentObject(CardStore())
}
