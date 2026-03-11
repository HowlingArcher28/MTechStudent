/*
 String+Identifiable.swift
 
 Overview:
 A tiny utility type that wraps a String to conform to Identifiable. Useful for
 driving SwiftUI lists or alerts where an identifiable string is required.
*/

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

