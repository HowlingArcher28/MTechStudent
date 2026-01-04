//
//  TodoItemsView.swift
//  SwiftDataTodoList
//
//  Created by Parker Rushton on 5/30/25.
//

import SwiftUI
import SwiftData

struct TodoItemsView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var items: [TodoItem]
    
    @State private var isShowingAddAlert = false
    @State private var newItemTitle = ""

    private var activeItems: [TodoItem] {
        items.filter { !$0.isCompleted }.sorted(by: { $0.createdAt > $1.createdAt })
    }

    private var completedItems: [TodoItem] {
        items
            .filter { $0.isCompleted }
            .sorted(by: { ($0.completedAt ?? .distantPast) > ($1.completedAt ?? .distantPast) })
    }

    var body: some View {
        NavigationStack {
            ZStack {
                if items.isEmpty {
                    emptyStateView()
                } else {
                    List {
                        if !activeItems.isEmpty {
                            activeSectionView()
                        }
                        if !completedItems.isEmpty {
                            completedSectionView()
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { isShowingAddAlert = true }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add Task")
                }
            }
            .alert("Add New Task", isPresented: $isShowingAddAlert) {
                alertContent()
            }
        }
        .animation(.default, value: items)
    }

    // Builder funcs

    private func emptyStateView() -> some View {
        VStack(spacing: 16) {
            Text("No Tasks Yet!")
                .font(.title)
                .foregroundColor(.secondary)

            Button(action: { isShowingAddAlert = true }) {
                Label("Add Your First Task", systemImage: "plus.circle.fill")
                    .font(.headline)
            }
        }
        .padding()
    }

    private func activeSectionView() -> some View {
        Section("Active") {
            ForEach(activeItems) { item in
                TodoItemRow(item: item) {
                    toggleCompletion(for: item)
                }
            }
            .onDelete { offsets in
                deleteItems(from: activeItems, at: offsets)
            }
        }
    }

    private func completedSectionView() -> some View {
        Section("Completed") {
            ForEach(completedItems) { item in
                TodoItemRow(item: item) {
                    toggleCompletion(for: item)
                }
            }
            .onDelete { offsets in
                deleteItems(from: completedItems, at: offsets)
            }
        }
    }

    private func alertContent() -> some View {
        Group {
            TextField("Task Title", text: $newItemTitle)
            Button("Cancel", role: .cancel) {
                newItemTitle = ""
            }
            Button("Add") {
                addItem()
            }
            .disabled(newItemTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }

}

// MARK: - Private extension

private extension TodoItemsView {

    func addItem() {
        let trimmed = newItemTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        withAnimation {
            let newItem = TodoItem(title: trimmed)
            modelContext.insert(newItem)
            newItemTitle = ""
            save()
        }
    }

    func deleteItems(from sectionItems: [TodoItem], at offsets: IndexSet) {
        let itemsToDelete = offsets.map { sectionItems[$0] }
        itemsToDelete.forEach { modelContext.delete($0) }
        save()
    }

    func toggleCompletion(for item: TodoItem) {
        item.completedAt = item.isCompleted ? nil : Date()
        save()
    }
    
    func showNewItemAlert() {
        isShowingAddAlert = true
    }
    
    func save() {
        try? modelContext.save()
    }

}

#Preview {
    TodoItemsView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
