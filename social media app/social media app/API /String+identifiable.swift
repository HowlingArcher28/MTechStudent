//
//  String+Identifiable.swift
//  social media app
//
//  Created by Zachary Jensen on 3/4/26.
//

import Foundation

struct IdentifiableString: Identifiable {
    let value: String
    var id: String { value }
}
