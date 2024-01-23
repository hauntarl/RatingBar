//
//  RatingBar.swift
//  
//
//  Created by Sameer Mungole on 1/21/24.
//

import SwiftUI

public struct RatingBar<Content: Shape>: View {
    @Binding var rating: Double
    let width: Double
    let height: Double
    let parts: Int
    let spacing: Double
    let shape: Content
    let fillColor: Color
    let backgroundColor: Color
    let animation: Animation
    
    public init(
        rating: Binding<Double>,
        width: Double,
        height: Double,
        parts: Int,
        spacing: Double,
        shape: Content,
        fillColor: Color,
        backgroundColor: Color,
        animation: Animation = .bouncy
    ) {
        self._rating = rating
        self.width = width
        self.height = height
        self.parts = parts
        self.spacing = spacing
        self.shape = shape
        self.fillColor = fillColor
        self.backgroundColor = backgroundColor
        self.animation = animation
    }
    
    @State private var dragAmount: Double = .zero
    private var partWidth: Double {
        width / Double(parts)
    }
    
    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<parts, id: \.self, content: buildPart)
        }
        .highPriorityGesture(
            DragGesture()
                .onChanged { gesture in
                    withAnimation(animation) {
                        dragAmount = gesture.location.x
                    }
                }
        )
        .onAppear {
            updateDragAmount(for: rating)
        }
        .onChange(of: dragAmount) { oldValue, newValue in
            if oldValue == newValue {
                return
            }
            updateRating(for: newValue)
        }
        .onChange(of: rating) { _, newValue in
            updateDragAmount(for: newValue)
        }
    }
    
    private func buildPart(_ index: Int) -> some View {
        Rectangle()
            .fill(backgroundColor)
            .overlay {
                HStack {
                    Rectangle()
                        .fill(fillColor)
                        .frame(
                            width: min(fillAmount(index), partWidth),
                            height: height
                        )
                    Spacer(minLength: .zero)
                }
            }
            .frame(width: partWidth, height: height)
            .clipShape(shape)
    }
    
    private func fillAmount(_ index: Int) -> Double {
        max(.zero, dragAmount - Double(index) * (partWidth + spacing))
    }
    
    private func updateDragAmount(for rating: Double) {
        let totalWidth = width + (Double(parts) - 1) * spacing
        withAnimation(animation) {
            dragAmount = (rating * totalWidth) / Double(parts)
        }
    }
    
    private func updateRating(for dragAmount: Double) {
        let totalWidth = width + (Double(parts) - 1) * spacing
        let rawRating = (dragAmount / totalWidth) * Double(parts)
        rating = min(Double(parts), max(.zero, rawRating))
    }
}

#Preview {
    @State var rating = Double.zero
    return RatingBar(
        rating: $rating,
        width: 300,
        height: 70,
        parts: 5,
        spacing: 10,
        shape: RatingBarRoundedStar(cornerRadius: 5),
        fillColor: .yellow,
        backgroundColor: .primary.opacity(0.2),
        animation: .bouncy(duration: 0.5)
    )
}

