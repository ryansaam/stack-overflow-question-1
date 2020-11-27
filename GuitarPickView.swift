//
//  GuitarPickView.swift
//  lava
//
//  Created by Ryan Sam on 11/27/20.
//

import SwiftUI

struct TrianglePath: View {
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                // let width = min(geometry.size.width, geometry.size.height)
                // let height = width * 0.75
                
                Path { path in
                    path.addLines([
                        CGPoint(x: 0.0, y: 0.0),
                        CGPoint(x: 15.0, y: 30.0),
                        CGPoint(x: 30.0, y: 0.0)
                    ])
                }
                .fill(Color(UIColor(cgColor: self.color)))
            }
            GeometryReader { geometry in
                // let width = min(geometry.size.width, geometry.size.height)
                // let height = width * 0.75
                
                Path { path in
                    path.addLines([
                        CGPoint(x: 0.0, y: 0.0),
                        CGPoint(x: 15.0, y: 30.0),
                        CGPoint(x: 30.0, y: 0.0)
                    ])
                }
                .stroke(Color.white, lineWidth: 5)
            }
        }
    }
    
    @Binding var color: CGColor
}

struct GuitarPickView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(UIColor(cgColor: self.color)))
                .offset(x: 0.0, y: -20.0)
                .scaleEffect(1.07)
            Circle()
                .stroke(Color.white, lineWidth: 5)
                .scaleEffect(1.07)
                .offset(x: 0.0, y: -20.0)
            TrianglePath(color: $color)
        }
        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    
    @Binding var color: CGColor
}
