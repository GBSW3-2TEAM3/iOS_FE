//
//  CustomSlider.swift
//  walkingGO
//
//  Created by 박성민 on 6/1/25.
//

import Foundation
import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 25)
                
                ForEach(Array(stride(from: range.lowerBound, through: range.upperBound, by: step)), id: \.self) { mark in
                    if mark != range.lowerBound && mark != range.upperBound {
                        let position = geometry.size.width * (mark / range.upperBound)
                        Rectangle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 1, height: 25)
                            .offset(x: position)
                    }
                }
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.blue)
                    .frame(width: geometry.size.width * (value / range.upperBound), height: 25)
                
                Slider(value: $value, in: range, step: step)
                    .accentColor(Color.gray.opacity(0.3))
                    .onAppear {
                        UISlider.appearance().setThumbImage(UIImage(), for: .normal)
                        UISlider.appearance().minimumTrackTintColor = .clear
                        UISlider.appearance().maximumTrackTintColor = .clear
                    }
            }

        }
        .frame(height: 10)
    }
}
