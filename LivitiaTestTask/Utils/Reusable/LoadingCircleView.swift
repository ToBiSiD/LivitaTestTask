//
//  LoadingCircleView.swift
//  LivitiaTestTask
//
//  Created by Tobias on 07.08.2024.
//

import SwiftUI

struct LoadingCircleView: View {
    @State private var isAnimating: Bool = false
    var componentsNumber: Int = 7
    var duration: Double = 1.5
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<componentsNumber) { index in
                Group {
                    componentView(for: index, with: geometry)
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height)
                .rotationEffect(rotationEffect)
                .animation(spinningAnimation(for: index))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            withAnimation(.easeInOut) {
                self.isAnimating = true
            }
        }
    }
}

private extension LoadingCircleView {
    var rotationEffect: Angle {
        !self.isAnimating ? .degrees(0) : .degrees(360)
    }
    
    func spinningAnimation(for index: Int) -> Animation {
        .timingCurve(0.5, 0.15 + Double(index) / Double(componentsNumber), 0.25, 1, duration: duration)
        .repeatForever(autoreverses: false)
    }
    
    func componentView(for index: Int, with geometry: GeometryProxy) -> some View {
        
        let width = geometry.size.width / components()
        let height = geometry.size.height / components()
        let scale = calcScale(for: index)
        let yOffset = calcYOffset(geometry)
        
        return Circle()
            .frame(width: width, height: height)
            .scaleEffect(scale)
            .offset(y: yOffset)
    }
    
    func components() -> CGFloat {
        CGFloat(componentsNumber)
    }
    
    func calcScale(for index: Int) -> CGFloat {
        return (!isAnimating ? 1 - CGFloat(Float(index)) / components() : 0.2 + CGFloat(index) / components())
    }
    
    func calcYOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / (components() * 2) - geometry.size.height / 2
    }
}

#Preview {
    LoadingCircleView()
}
