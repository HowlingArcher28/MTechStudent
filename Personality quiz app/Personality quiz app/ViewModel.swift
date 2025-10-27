//
//  QuizView.swift
//  Personality quiz app
//
//  Created by Zachary Jensen on 10/13/25.
//

import SwiftUI
import Combine

// MARK: - ViewModel

@MainActor
final class QuizViewModel: ObservableObject {

    // Value-to-color mapping used throughout:
    // 1 = Red (energetic, direct, warm)
    // 2 = Yellow (social, optimistic, playful)
    // 3 = Blue (calm, organized, thoughtful)
    // 4 = Purple (creative, imaginative, mysterious)

    @Published private(set) var questions: [QuizQuestion] = [
    
        QuizQuestion(
            prompt: "Pick a weekend activity:",
            choices: [
                Choice(text: "Hiking", value: 1),   // Red
                Choice(text: "Reading", value: 3),  // Blue
                Choice(text: "Concert", value: 2),  // Yellow
                Choice(text: "Cooking", value: 4)   // Purple
            ],
            kind: .multipleChoice,
            selectionMode: .single
        ),
        QuizQuestion(
            prompt: "Choose your favorite time(s) of day (pick all that apply):",
            choices: [
                Choice(text: "Sunrise", value: 1),  // Red
                Choice(text: "Noon", value: 2),     // Yellow
                Choice(text: "Sunset", value: 3),   // Blue
                Choice(text: "Midnight", value: 4)  // Purple
            ],
            kind: .multipleChoice,
            selectionMode: .multiple
        ),
        QuizQuestion(
            prompt: "What fits you best?",
            choices: [
                Choice(text: "Calm", value: 3),        // Blue
                Choice(text: "Bold", value: 1),        // Red
                Choice(text: "Playful", value: 2),     // Yellow
                Choice(text: "Mysterious", value: 4)   // Purple
            ],
            kind: .multipleChoice,
            selectionMode: .single
        ),
        QuizQuestion(
            prompt: "How active are you from 1 to 10?",
            choices: [],
            kind: .slider(min: 1, max: 10, step: 1),
            selectionMode: .single
        ),
        QuizQuestion(
            prompt: "Pick your ideal vacation:",
            choices: [
                Choice(text: "Beach", value: 1),        // Red
                Choice(text: "Mountains", value: 3),    // Blue
                Choice(text: "City", value: 2),         // Yellow
                Choice(text: "Countryside", value: 4)   // Purple
            ],
            kind: .multipleChoice,
            selectionMode: .single
        ),
        QuizQuestion(
            prompt: "Pick a soundtrack for your day:",
            choices: [
                Choice(text: "Upbeat pop/EDM", value: 2),        // Yellow
                Choice(text: "Ambient/chill", value: 3),         // Blue
                Choice(text: "Indie/alternative", value: 4),     // Purple
                Choice(text: "Rock/anthemic", value: 1)          // Red
            ],
            kind: .multipleChoice,
            selectionMode: .single
        ),
        QuizQuestion(
            prompt: "Which traits describe you? (pick all that apply)",
            choices: [
                Choice(text: "Adventurous", value: 1),  // Red
                Choice(text: "Loyal", value: 3),        // Blue
                Choice(text: "Creative", value: 4),     // Purple
                Choice(text: "Social", value: 2)        // Yellow
            ],
            kind: .multipleChoice,
            selectionMode: .multiple
        ),
        QuizQuestion(
            prompt: "Your ideal workspace:",
            choices: [
                Choice(text: "Minimal and tidy", value: 3), // Blue
                Choice(text: "Colorful and inspiring", value: 2), // Yellow
                Choice(text: "Cozy and warm", value: 1),    // Red
                Choice(text: "Moody and modern", value: 4)  // Purple
            ],
            kind: .multipleChoice,
            selectionMode: .single
        ),
        QuizQuestion(
            prompt: "How organized are you from 1 to 10?",
            choices: [],
            kind: .slider(min: 1, max: 10, step: 1),
            selectionMode: .single
        ),
        QuizQuestion(
            prompt: "Pick your favorite weather:",
            choices: [
                Choice(text: "Sunny with a breeze", value: 2), // Yellow
                Choice(text: "Light rain", value: 3),          // Blue
                Choice(text: "Autumn chill", value: 4),        // Purple
                Choice(text: "Warm summer, clear sky", value: 1) // Red
            ],
            kind: .multipleChoice,
            selectionMode: .single
        ),
        QuizQuestion(
            prompt: "Favorite hobbies (pick all that apply):",
            choices: [
                Choice(text: "Sports/outdoors", value: 1),  // Red
                Choice(text: "Art/music", value: 4),        // Purple
                Choice(text: "Games/puzzles", value: 3),    // Blue
                Choice(text: "Social events", value: 2)     // Yellow
            ],
            kind: .multipleChoice,
            selectionMode: .multiple
        ),
        QuizQuestion(
            prompt: "Choose a dessert:",
            choices: [
                Choice(text: "Pumpkin pie", value: 2),        // Yellow
                Choice(text: "Chocolate", value: 4),          // Purple
                Choice(text: "Vanilla ice cream", value: 3),  // Blue
                Choice(text: "Cinnamon roll", value: 1)       // Red
            ],
            kind: .multipleChoice,
            selectionMode: .single
        ),
        QuizQuestion(
            prompt: "What do you value most in friends? (pick all that apply)",
            choices: [
                Choice(text: "Honesty", value: 1),     // Red
                Choice(text: "Fun", value: 2),         // Yellow
                Choice(text: "Reliability", value: 3), // Blue
                Choice(text: "Trust", value: 4)        // Purple
            ],
            kind: .multipleChoice,
            selectionMode: .multiple
        ),
        QuizQuestion(
            prompt: "Pick an element:",
            choices: [
                Choice(text: "Fire", value: 1),   // Red
                Choice(text: "Earth", value: 2),  // Yellow
                Choice(text: "Water", value: 3),  // Blue
                Choice(text: "Air", value: 4)     // Purple
            ],
            kind: .multipleChoice,
            selectionMode: .single
        ),
        QuizQuestion(
            prompt: "Your way to communicate:",
            choices: [
                Choice(text: "Direct and brief", value: 1),            // Red
                Choice(text: "Enthusiastic and lively", value: 2),     // Yellow
                Choice(text: "Thoughtful and measured", value: 3),     // Blue
                Choice(text: "Quiet and shy", value: 4)                // Purple
            ],
            kind: .multipleChoice,
            selectionMode: .single
        )
    ]

    // Navigation
    @Published var showResult: Bool = false

    // Progress
    @Published private(set) var currentIndex: Int = 0

    // Selection state
    @Published var selectedChoiceID: Choice.ID? = nil       // single-select
    @Published var selectedChoiceIDs: Set<Choice.ID> = []   // multi-select

    // Slider state
    @Published var sliderValue: Double = 1
    @Published var sliderHasInteracted: Bool = false

    // Collected answers
    @Published private(set) var collectedValues: [Int] = []

    var currentQuestion: QuizQuestion {
        questions[currentIndex]
    }

    var isLastQuestion: Bool {
        currentIndex == questions.count - 1
    }

    var progressText: String {
        "Question \(currentIndex + 1) of \(questions.count)"
    }

    var progressFraction: CGFloat {
        guard questions.count > 0 else { return 0 }
        return CGFloat(currentIndex + 1) / CGFloat(questions.count)
    }

    var isCurrentQuestionAnswered: Bool {
        switch currentQuestion.kind {
        case .multipleChoice:
            switch currentQuestion.selectionMode {
            case .single:
                return selectedChoiceID != nil
            case .multiple:
                return !selectedChoiceIDs.isEmpty
            }
        case .slider:
            return sliderHasInteracted
        }
    }

    var buttonTitle: String {
        isLastQuestion ? "See Result" : "Next"
    }

    var buttonIconName: String {
        isLastQuestion ? "sparkles" : "arrow.right.circle.fill"
    }

    var buttonBackground: AnyShapeStyle {
        if !isCurrentQuestionAnswered {
            return AnyShapeStyle(Color.gray.opacity(0.6))
        } else {
            let gradient = LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing)
            return AnyShapeStyle(gradient)
        }
    }

    // MARK: - Intents

    func onAppear() {
        // Ensure slider state matches question when appearing first time
        syncStateForCurrentQuestion()
    }

    func onQuestionIndexChanged() {
        syncStateForCurrentQuestion()
    }

    func handleChoiceTap(_ choice: Choice) {
        let mode = currentQuestion.selectionMode
        switch mode {
        case .single:
            if selectedChoiceID == choice.id {
                selectedChoiceID = nil
            } else {
                selectedChoiceID = choice.id
            }
        case .multiple:
            if selectedChoiceIDs.contains(choice.id) {
                selectedChoiceIDs.remove(choice.id)
            } else {
                selectedChoiceIDs.insert(choice.id)
            }
        }
    }

    func isChoiceSelected(_ choice: Choice) -> Bool {
        let mode = currentQuestion.selectionMode
        switch mode {
        case .single:
            return selectedChoiceID == choice.id
        case .multiple:
            return selectedChoiceIDs.contains(choice.id)
        }
    }

    func sliderChanged(to newValue: Double) {
        sliderValue = newValue
        sliderHasInteracted = true
    }

    func goToNext() {
        guard isCurrentQuestionAnswered else { return }

        let question = currentQuestion
        switch question.kind {
        case .multipleChoice:
            switch question.selectionMode {
            case .single:
                if let id = selectedChoiceID,
                   let choice = question.choices.first(where: { $0.id == id }) {
                    collectedValues.append(choice.value)
                }
            case .multiple:
                let selected = question.choices.filter { selectedChoiceIDs.contains($0.id) }
                collectedValues.append(contentsOf: selected.map { $0.value })
            }
        case .slider:
            let mapped = mapSliderToValue(sliderValue)
            collectedValues.append(mapped)
        }

        if currentIndex < questions.count - 1 {
            currentIndex += 1
            onQuestionIndexChanged()
        } else {
            showResult = true
        }
    }

    func resetQuiz() {
        currentIndex = 0
        selectedChoiceID = nil
        selectedChoiceIDs.removeAll()
        sliderHasInteracted = false
        sliderValue = 1
        collectedValues.removeAll()
        showResult = false
        syncStateForCurrentQuestion()
    }

    // MARK: - Result

    func finalColor() -> (Color, String) {
        guard !collectedValues.isEmpty else { return (.gray, "Gray") }
        let counts = Dictionary(grouping: collectedValues, by: { $0 }).mapValues { $0.count }
        let best = counts.max { a, b in a.value < b.value }?.key ?? 1
        switch best {
        case 1: return (.red, "Red")
        case 2: return (.yellow, "Yellow")
        case 3: return (.blue, "Blue")
        case 4: return (.purple, "Purple")
        default: return (.gray, "Gray")
        }
    }

    // MARK: - Private

    private func syncStateForCurrentQuestion() {
        switch currentQuestion.kind {
        case .multipleChoice:
            clearSelection()
        case let .slider(min, _, _):
            sliderValue = min
            sliderHasInteracted = false
            clearSelection()
        }
    }

    private func clearSelection() {
        selectedChoiceID = nil
        selectedChoiceIDs.removeAll()
    }

    // Global slider mapping used by all sliders to keep consistency with color bands.
    private func mapSliderToValue(_ value: Double) -> Int {
        let v = Int(value.rounded())
        switch v {
        case ...3: return 1    // Red
        case 4...5: return 2   // Yellow
        case 6...8: return 3   // Blue
        default: return 4      // Purple
        }
    }
}

#Preview {
    NavigationStack {
        QuizView()
    }
}
