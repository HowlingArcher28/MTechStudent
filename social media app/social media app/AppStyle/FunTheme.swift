/*
 FunTheme.swift
 
 Overview:
 Supplemental theming utilities used for playful UI elements like cards and
 accents. Defines gradients and color palettes used across reusable components.
*/

import SwiftUI

struct FunTheme {
    
    static let cardGradient = LinearGradient(
        colors: [Color.white, Color.white],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let accentGradient = LinearGradient(
        colors: [AppTheme.primaryRed, AppTheme.primaryRed],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let funColors: [Color] = [
        AppTheme.primaryRed, .gray, .blue, .teal, .indigo
    ]
}

