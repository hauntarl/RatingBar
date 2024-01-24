//
//  CustomShapes.swift
//  
//
//  Created by Sameer Mungole on 1/23/24.
//

import SwiftUI

// Source - https://sarunw.com/posts/how-to-draw-custom-paths-and-shapes-in-swiftui/
public struct RatingBarTriangle: Shape {
    public init() {}
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            let width: CGFloat = rect.width
            let height: CGFloat = rect.height
            path.move(
                to: CGPoint(
                    x: 0 * width,
                    y: 1 * height
                )
            )
            path.addLine(
                to: CGPoint(
                    x: 1 * width,
                    y: 1 * height
                )
            )
            path.addLine(
                to: CGPoint(
                    x: 0.5 * width,
                    y: 0 * height
                )
            )
            path.closeSubpath()
        }
    }
}

// Source - https://sarunw.com/posts/how-to-draw-custom-paths-and-shapes-in-swiftui/
public struct RatingBarHexagon: Shape {
    public init() {}
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            let width: CGFloat = rect.width
            let height: CGFloat = rect.height
            
            path.move(
                to: CGPoint(
                    x: 0.2 * width,
                    y: 0 * height
                )
            )

            path.addLine(
                to: CGPoint(
                    x: 0.8 * width,
                    y: 0 * height)
            )

            path.addLine(
                to: CGPoint(
                    x: 1 * width,
                    y: 0.5 * height)
            )
            
            path.addLine(
                to: CGPoint(
                    x: 0.8 * width,
                    y: 1 * height)
            )
            
            path.addLine(
                to: CGPoint(
                    x: 0.2 * width,
                    y: 1 * height)
            )
            
            path.addLine(
                to: CGPoint(
                    x: 0 * width,
                    y: 0.5 * height)
            )

            path.closeSubpath()
        }
    }
}


// Source - https://stackoverflow.com/a/63650217
public struct RatingBarRoundedStar: Shape {
    let cornerRadius: CGFloat
    
    public init(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let r = rect.width / 2
        let rc = cornerRadius
        let rn = r * 0.95 - rc
        
        // start angle at -18 degrees so that it points up
        var cangle = -18.0
        
        for i in 1 ... 5 {
            // compute center point of tip arc
            let cc = CGPoint(
                x: center.x + rn * CGFloat(cos(Angle(degrees: cangle).radians)),
                y: center.y + rn * CGFloat(sin(Angle(degrees: cangle).radians))
            )

            // compute tangent point along tip arc
            let p = CGPoint(
                x: cc.x + rc * CGFloat(cos(Angle(degrees: cangle - 72).radians)),
                y: cc.y + rc * CGFloat(sin(Angle(degrees: (cangle - 72)).radians))
            )

            if i == 1 {
                path.move(to: p)
            } else {
                path.addLine(to: p)
            }

            // add 144 degree arc to draw the corner
            path.addArc(
                center: cc,
                radius: rc,
                startAngle: Angle(degrees: cangle - 72),
                endAngle: Angle(degrees: cangle + 72),
                clockwise: false
            )

            // Move 144 degrees to the next point in the star
            cangle += 144
        }

        return path
    }
}
