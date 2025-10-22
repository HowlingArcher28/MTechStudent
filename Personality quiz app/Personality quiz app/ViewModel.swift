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

    @Published private(set) var questions: [QuizQuestion] = [
        QuizQuestion(
            prompt: "Pick a weekend activity:",
            choices: [
                Choice(text: "Hiking", value: 1),
                Choice(text: "Reading", value: 2),
                Choice(text: "Concert", value: 3),
                Choice(text: "Cooking", value: 4)
            ],
            kind: .multipleChoice,
            selectionMode: .single
        ),
        QuizQuestion(
            prompt: "Choose your favorite time(s) of day (pick all that apply):",
            choices: [
                Choice(text: "Sunrise", value: 1),
                Choice(text: "Noon", value: 2),
                Choice(text: "Sunset", value: 3),
                Choice(text: "Midnight", value: 4)
            ],
            kind: .multipleChoice,
            selectionMode: .multiple
        ),
        QuizQuestion(
            prompt: "What fits you best?",
            choices: [
                Choice(text: "Calm", value: 1),
                Choice(text: "Bold", value: 2),
                Choice(text: "Playful", value: 3),
                Choice(text: "Mysterious", value: 4)
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
                Choice(text: "Beach", value: 1),
                Choice(text: "Mountains", value: 2),
                Choice(text: "City", value: 3),
                Choice(text: "Countryside", value: 4)
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

    private func mapSliderToValue(_ value: Double) -> Int {
        let v = Int(value.rounded())
        switch v {
        case ...3: return 1
        case 4...5: return 2
        case 6...8: return 3
        default: return 4
        }
    }
}



 


#Preview {
    NavigationStack {
        QuizView()
    }
}
