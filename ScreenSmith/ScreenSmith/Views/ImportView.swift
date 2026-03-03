//
//  ImportView.swift
//  ScreenSmith
//
//  Created by Zachary Jensen on 2/26/26.
//

import SwiftUI

struct ImportView: View {

    var body: some View {

        VStack(spacing: 20) {

            Text("ScreenSmith")
                .font(.largeTitle)
                .foregroundColor(.blue)

            Text("Import")
                .font(.title2)

            GlassCard {

                VStack(spacing: 12) {

                    Image(systemName: "plus")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)

                    Text("Select Photo")

                }
                .frame(maxWidth: .infinity, minHeight: 140)

            }

            GlassCard {

                VStack(spacing: 16) {

                    ToggleRow(
                        title: "Smart Crop",
                        subtitle: "Automatically crop to fit your screen."
                    )

                    ToggleRow(
                        title: "Auto Enhance",
                        subtitle: "Automatically enhance photo quality."
                    )

                }

            }

            Spacer()

        }
        .padding()
        .background(
            LinearGradient(
                colors: [
                    Color.black,
                    Color.blue.opacity(0.2)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}
