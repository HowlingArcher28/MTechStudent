// RepresentativeCell.swift
import SwiftUI

struct RepresentativeCell: View {
    let rep: Representative

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(rep.name)
                    .font(.headline)
                Spacer()
                Text(rep.party)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            HStack(spacing: 12) {
                Label("\(rep.state)-\(rep.district)", systemImage: "mappin.and.ellipse")
                Label(rep.phone, systemImage: "phone.fill")
            }
            .font(.caption)
            .foregroundStyle(.secondary)

            if let url = URL(string: rep.link) {
                Link(destination: url) {
                    Label("Website", systemImage: "safari")
                }
                .font(.caption)
                .tint(.teal)
            }
        }
        .padding(.vertical, 6)
    }
}
