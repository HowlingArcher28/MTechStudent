//
//  ContentView.swift
//  GeomitryReaderLab
//
//  Created by Zachary Jensen on 1/6/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private let spacing: CGFloat = 12
    private let horizontalPadding: CGFloat = 16


    var body: some View {
        GeometryReader { geometry in
            // (2 for compact, 3 for regular)
            let columns: Int = (horizontalSizeClass == .regular) ? 3 : 2

            let totalSpacingWidth = spacing * CGFloat(columns - 1)
            let availableWidth = geometry.size.width - (horizontalPadding * 2) - totalSpacingWidth
            let cellWidth = max(0, availableWidth / CGFloat(columns))

            // figures out number of rows needed
            let rowCount = Int(ceil(Double(profiles.count) / Double(columns)))

            ScrollView {
                VStack(alignment: .center, spacing: spacing) {
                    ForEach(0..<rowCount, id: \.self) { row in
                        HStack(spacing: spacing) {
                            ForEach(0..<columns, id: \.self) { col in
                                let index = row * columns + col
                                if index < profiles.count {
                                    ProfileCardView(profile: profiles[index], width: cellWidth)
                                } else {
                                    // Invisible placeholder so that alignment and spacing is consistent
                                    Color.clear
                                        .frame(width: cellWidth, height: cellWidth * 1.25)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, spacing)
                .frame(maxWidth: .infinity)
            }
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    ContentView()
}
