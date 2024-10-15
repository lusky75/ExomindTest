//
//  ProgressBarView.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import SwiftUI

struct ProgressBarView: View {
    let value: Double
    let backgroundColor: Color
    let foregroundColor: Color
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .foregroundColor(backgroundColor.opacity(0.3))
                
                Rectangle()
                    .frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(foregroundColor.opacity(0.3))
            }
            .cornerRadius(height / 2)
        }
        .frame(width: width, height: height)
    }
    
    private func progress(value: Double,
                          maxValue: Double,
                          width: CGFloat) -> CGFloat {
        let percentage = value / maxValue
        return width *  CGFloat(percentage)
    }
}

#Preview {
    ProgressBarView(value: 0.5, backgroundColor: .gray, foregroundColor: .purple, width: 300,
                    height: 30)
}
