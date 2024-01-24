//
//  RatingBar.swift
//  
//
//  Created by Sameer Mungole on 1/21/24.
//

import SwiftUI

/**
 An interactive rating bar that utilizes drag gestures and animations to let users
 leave a rating for a product.
 
 This view enables two-way interactions:
 1. Control the rating using drag gestures
 2. Control the rating by externally managing the `rating` property
 
 The following example shows how to use the RatingBar:
 ```swift
 RatingBar(
     rating: $rating1,
     shape: Capsule(),
     fillColor: .accentColor,
     backgroundColor: .primary.opacity(0.2)
 )
 ```
 
 The following example shows two-way interactions using the RatingBar:
 ```swift
 VStack {
     RatingBar(
         rating: $rating,
         width: 300,
         height: 50,
         parts: 5,
         spacing: 5,
         shape: Capsule(),
         fillColor: .yellow,
         backgroundColor: .primary.opacity(0.2),
         animation: .smooth
     )
 
     TextField("Rating", text: Binding(get: {
         String(format: "%.2f", rating)
     }, set: { newValue in
         rating = Double(newValue) ?? .zero
     }))
 }
 ```
 
 The view makes sure that the rating ranges in `[0, parts]`, it basically won't let
 the user feed erroneous values to the `rating` property externally.
 
 >Note: Sometimes the shapes might get clipped when interacting, it can be easily fixed
 >by providing more height to the view.
 */
@available(iOS 17.0, macOS 14.0, *)
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
    
    /**
     Creates a rating bar with specified width, height, parts, and shape.
     
     - Parameters:
        - rating: A binding that lets you manage the rating
        - width: Total width all of the shapes can take combined
        - height: Maximum height each shape can take
        - parts: Count of shapes you want drawn, also acts as upper limit for rating
        - spacing: Controls the spacing between each shape, this affects the total width of the view overall
        - shape: Expects a `Shape` that is used of the rating system
        - fillColor: Color when the `shape` is either completely or partially filled
        - backgroundColor: Color when the `shape` is either completely or partially empty
        - animation: Controls how the view follows user's interaction
     */
    public init(
        rating: Binding<Double>,
        width: Double = 300,
        height: Double = 60,
        parts: Int = 5,
        spacing: Double = 5,
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
    
    // Keeps track of user's gesture
    @State private var dragAmount: Double = .zero
    // Calculate the width each shape can take
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
            // When the view appears for the first time and the rating is a non-zero value,
            // fill the rating bar accordingly
            updateDragAmount(for: rating)
        }
        .onChange(of: dragAmount) { oldValue, newValue in
            if oldValue == newValue {
                return
            }
            // As and when the drag amount changes, update the rating
            updateRating(for: newValue)
        }
        .onChange(of: rating) { _, newValue in
            // As and when the rating changes (externally), update the drag amount
            updateDragAmount(for: newValue)
        }
    }
    
    // Each part represents an individual shape that handles it fill amount based on the drag amount value
    private func buildPart(_ index: Int) -> some View {
        Rectangle()
            .fill(backgroundColor)
            .overlay {
                HStack {
                    Rectangle()
                        .fill(fillColor)
                        .frame(
                            width: min(fillAmount(index), partWidth), // upper bound
                            height: height
                        )
                    Spacer(minLength: .zero)
                }
            }
            .frame(width: partWidth, height: height)
            .clipShape(shape)
    }
    
    // Calculates fill amount for current shape based on its position in the row and drag amount
    private func fillAmount(_ index: Int) -> Double {
        max(.zero, dragAmount - Double(index) * (partWidth + spacing)) // lower bound
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
        spacing: 5,
        shape: RatingBarRoundedStar(cornerRadius: 5),
        fillColor: .yellow,
        backgroundColor: .primary.opacity(0.2),
        animation: .bouncy(duration: 0.5)
    )
}

