//
//  CustomButton.swift
//  walkingGO
//
//  Created by 박성민 on 3/24/25.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void
    var width: CGFloat = 300
    var textColor: Color = .white
    var backgroundColor: Color = .customBlue
    var strokeColor: Color = .white
    var body: some View {
        Button(action:action){
            Text(title)
                .frame(width: width,height: 50)
                .font(AppFont.PretendardBold(size: 15))
                .foregroundStyle(textColor)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 13))
                .overlay(
                    RoundedRectangle(cornerRadius: 13)
                        .stroke(strokeColor, lineWidth: 1)
                )
        }
    }
}

#Preview {
    CustomButton(
        title:"로그인",
        action: {},
        textColor: .blue,
        backgroundColor: .white,
        strokeColor: .black
    )
}
