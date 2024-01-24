# Rating Bar - SwiftUI Component

> Developed by: [Sameer Mungole](https://www.linkedin.com/in/hauntarl97/)
> Available on: **iOS 17+** & **macOS 14+**

An interactive rating bar that utilizes drag gestures and animations to let users leave a rating for a product.

This view enables two-way interactions:

1. Control the rating using drag gestures
2. Control the rating by externally managing the `rating` property

The following example shows how to use the RatingBar:

```swift
RatingBar(
   rating: $rating,
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

The view makes sure that the rating ranges in `[0, parts]`, it basically won't let the user feed erroneous values to the `rating` property externally.

> Note: Sometimes the shapes might get clipped when interacting, it can be easily fixed by providing more height to the view.

This package also contains custom shapes like `RatingBarTriangle`, and `RatingBarRoundedStar` under the `CustomShapes.swift` file. They are publicly accessible for you to use, I will keep adding more custom shapes with time.

I appreciate your time and interest in my package, as this is my first package in `SwiftUI`, I probably didn't adhere to the industry standards. I would really appreciate your feedback regarding any changes I need to make or bugs I need to fix!

You can reach out to me via LinkedIn: [https://www.linkedin.com/in/hauntarl97/](https://www.linkedin.com/in/hauntarl97/)

Thank you!