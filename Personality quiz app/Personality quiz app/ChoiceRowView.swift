//
//  ChoiceRowView.swift
//  Personality quiz app
//
//  Created by Zachary Jensen on 10/21/25.
//
import SwiftUI

struct ChoiceRow: View {
   let text: String
   let isSelected: Bool
   let tap: () -> Void

   var body: some View {
       Button(action: tap) {
           HStack(spacing: 12) {
               Text(text)
                   .font(.system(.body, design: .rounded))
                   .foregroundColor(.primary)

               Spacer()

               Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                   .font(.title3.weight(.semibold))
                   .foregroundStyle(isSelected ? .blue : .secondary.opacity(0.5))
                   .scaleEffect(isSelected ? 1.1 : 1.0)
           }
           .padding(.horizontal, 14)
           .padding(.vertical, 12)
           .background(
               RoundedRectangle(cornerRadius: 14, style: .continuous)
                   .fill(isSelected ? Color.blue.opacity(0.14) : Color.secondary.opacity(0.08))
                   .overlay(
                       RoundedRectangle(cornerRadius: 14, style: .continuous)
                           .strokeBorder(isSelected ? Color.blue.opacity(0.35) : Color.clear, lineWidth: 1)
                   )
           )
           .shadow(color: isSelected ? Color.blue.opacity(0.15) : .clear, radius: 8, x: 0, y: 4)
       }
       .buttonStyle(ScaleOnPressStyle())
   }
}
