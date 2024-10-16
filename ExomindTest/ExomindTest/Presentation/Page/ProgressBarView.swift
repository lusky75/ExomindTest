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
    
    private var percentText: String {
        String(value * 100) + " %"
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                        .foregroundColor(backgroundColor.opacity(0.3))
                        .cornerRadius(height / 2)
                    
                    Spacer()
                    
                    // Display the percent of the progress in text
                    Text(percentText)
                        .foregroundColor(foregroundColor)
                        .font(Font.custom(.helveticaNeue65, size: 16))
                        .padding(.progressBarTextPadding)
                }
                
                Rectangle()
                    .frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(foregroundColor.opacity(0.5))
                    .animation(.easeInOut(duration: 1.0), value: self.value) // Animation ease in out duration of 1 second
                    .clipShape(
                        RoundedCornersShape(
                            corners: CGFloat(self.value) * geometry.size.width >= .screenWidthLessPadding ? .allCorners : [.topLeft, .bottomLeft],
                            radius: height / 2
                        )
                    )
                    
            }
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

struct RoundedCornersShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    ProgressBarView(value: 0.5, backgroundColor: .gray, foregroundColor: .purple, width: 300,
                    height: 30)
}
