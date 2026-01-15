//
//  LoadingButton.swift
//  Log-In-Screen
//
//  Created by Zachary Jensen on 1/5/26.
//

import SwiftUI

struct LoadingButton: View {
    let title: String
    let isLoading: Bool
    let isDisabled: Bool
    let action: () -> Void

    var body: some View {
        Button {
            guard !isLoading else { return }
            action()
        } label: {
            HStack {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                }
                Text(title)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
        }
        .buttonStyle(CustomButtonStyle())
        .disabled(isDisabled || isLoading) 
    }
}

