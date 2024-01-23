//
//  RatingBarExamples.swift
//  
//
//  Created by Sameer Mungole on 1/23/24.
//

import SwiftUI

struct RatingBarExamples: View {
    @State var rating1 = Double.zero
    @State var rating2 = Double.zero
    @State var rating3 = Double.zero
    @State var rating4 = Double.zero
    @State var rating5 = Double.zero
    @State var rating6 = Double.zero
    
    var body: some View {
        VStack {
            RatingBar(
                rating: $rating1,
                width: 300,
                height: 70,
                parts: 5,
                spacing: 5,
                shape: RatingBarRoundedStar(cornerRadius: 5),
                fillColor: .yellow,
                backgroundColor: .primary.opacity(0.2)
            )
            TextField("Rating", text: Binding(get: {
                String(format: "%.2f", rating1)
            }, set: { newValue in
                rating1 = Double(newValue) ?? .zero
            }))
            .keyboardType(.decimalPad)
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 100)
            
            RatingBar(
                rating: $rating2,
                width: 300,
                height: 50,
                parts: 5,
                spacing: 10,
                shape: RatingBarTriangle(),
                fillColor: .green,
                backgroundColor: .primary.opacity(0.2),
                animation: .snappy
            )
            Text("\(rating2, specifier: "%.2f")")
            
            RatingBar(
                rating: $rating3,
                width: 300,
                height: 100,
                parts: 3,
                spacing: 10,
                shape: Circle(),
                fillColor: .red,
                backgroundColor: .primary.opacity(0.2),
                animation: .smooth
            )
            Text("\(rating3, specifier: "%.2f")")
            
            RatingBar(
                rating: $rating4,
                width: 300,
                height: 50,
                parts: 10,
                spacing: 5,
                shape: Capsule(),
                fillColor: .blue,
                backgroundColor: .primary.opacity(0.2),
                animation: .easeOut(duration: 0.3)
            )
            Text("\(rating4, specifier: "%.2f")")
            
            RatingBar(
                rating: $rating5,
                width: 300,
                height: 75,
                parts: 1,
                spacing: .zero,
                shape: Ellipse(),
                fillColor: .indigo,
                backgroundColor: .primary.opacity(0.2),
                animation: .linear
            )
            Text("\(rating5, specifier: "%.2f")")
            
            RatingBar(
                rating: $rating6,
                width: 300,
                height: 20,
                parts: 7,
                spacing: 5,
                shape: UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 5,
                    bottomLeading: 20,
                    bottomTrailing: 5,
                    topTrailing: 20
                )),
                fillColor: .cyan,
                backgroundColor: .primary.opacity(0.2)
            )
            Text("\(rating6, specifier: "%.2f")")
        }
    }

}

#Preview {
    RatingBarExamples()
}
