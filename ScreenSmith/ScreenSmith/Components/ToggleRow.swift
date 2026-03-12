//
//  ToggleRow.swift
//  ScreenSmith
//
//  Created by Zachary Jensen on 2/26/26.
//

import SwiftUI

struct ToggleRow: View {

    let title: String
    let subtitle: String

    @State private var isOn = true

    var body: some View {

        HStack {

            VStack(alignment: .leading, spacing: 4) {

                Text(title)
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.9))

                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))

            }

            Spacer()

            Toggle("", isOn: $isOn)
                .tint(NeonColors.neonBlue)

        }
    }
}
