
import SwiftUI
import Observation

struct ContentView: View {
    @Environment(AppModel.self) private var model
    @State private var newName = ""

    var body: some View {
        @Bindable var model = model

        NavigationStack {
            VStack(spacing: 20) {

                // Add User
                HStack {
                    TextField("Enter name", text: $newName)
                        .textFieldStyle(.roundedBorder)

                    Button("Add") {
                        let trimmed = newName.trimmingCharacters(in: .whitespaces)
                        guard !trimmed.isEmpty else { return }
                        model.addPerson(name: trimmed)
                        newName = ""
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)

                // Selection Count
                Stepper(
                    "Select \(model.selectionCount) people",
                    value: $model.selectionCount,                 
                    in: 1...(max(model.people.count, 1))
                )
                .padding(.horizontal)

                // Random Selection Button
                Button("Pick Random") {
                    model.performSelection()
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)

                // User List
                List {
                    ForEach(model.people) { person in
                        HStack {
                            Text(person.name)
                            Spacer()
                            if model.selected.contains(person.id) {
                                Text("✓")
                                    .foregroundStyle(.green)
                                    .bold()
                            }
                        }
                    }
                    .onDelete(perform: model.delete)
                    .onMove(perform: model.move)
                }
            }
            .navigationTitle("Random Picker")
            .toolbar {
                EditButton()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AppModel())
}

