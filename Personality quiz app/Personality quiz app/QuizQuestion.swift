//
//  QuizQuestion.swift
//  Personality quiz app
//
//  Created by Zachary Jensen on 10/21/25.
//
import Foundation

enum QuestionKind: Equatable {
    case multipleChoice
    case slider(min: Double, max: Double, step: Double)
}

enum SelectionMode: Equatable {
    case single
    case multiple
}

struct Choice: Identifiable, Equatable, Hashable {
    let id = UUID()
    let text: String
    let value: Int
}

struct QuizQuestion: Identifiable, Equatable {
    let id = UUID()
    let prompt: String
    let choices: [Choice]
    let kind: QuestionKind
    let selectionMode: SelectionMode
}
