//
//  String+Identifiable.swift
//  social media app
//
//  Created by Zachary Jensen on 3/4/26.
//

import Foundation

// Do NOT globally make String Identifiable; it conflicts with SwiftUI and other extensions.
// Instead, use a wrapper if you need Identifiable conformance.

struct IdentifiableString: Identifiable {
    let value: String
    var id: String { value }
}
