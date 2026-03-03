//
//  Screen.swift
//  ScreenSmith
//
//  Created by Zachary Jensen on 2/26/26.
//
import SwiftUI

enum Screen: Hashable {
    case importView
    case enhanceView(image: UIImage)
    case perfectFitView(image: UIImage)
}
