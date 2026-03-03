//
//  PerfectFitView.swift
//  ScreenSmith
//
//  Created by Zachary Jensen on 2/26/26.
//

import SwiftUI

struct PerfectFitView: View {

    let image: UIImage
//    @EnvironmentObject var pipeline: ImagePipeline

    var body: some View {

        VStack(spacing: 20) {

            Text("Perfect Fit")
                .font(.title)

            GlassCard {

                ToggleRow(
                    title: "Smart Crop",
                    subtitle: "Accurately fits your screen size."
                )

            }

            PrimaryButton(title: "Save to Gallery")

            Spacer()

        }
        .padding()
    }
}

