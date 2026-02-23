//
//  ServicesModel.swift
//  social media app
//
//  Created by Zachary Jensen on 2/20/26.
//
import Foundation
import Observation

@MainActor
@Observable
final class ServicesModel {
    var api: APIClient
    var cohort: String {
        didSet {
            UserDefaults.standard.set(cohort, forKey: Self.cohortKey)
        }
    }

    private static let cohortKey = "settings.cohort"

    init(api: APIClient = APIClient()) {
        self.api = api
        self.cohort = UserDefaults.standard.string(forKey: Self.cohortKey) ?? "fall2025"
    }
}
