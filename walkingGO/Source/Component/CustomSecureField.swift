//
//  CustomSecureTextField.swift
//  walkingGO
//
//  Created by 박성민 on 3/24/25.
//

import SwiftUI

struct CustomSecureField: View {
    @Binding var text: String
    var title = ""
    var body: some View {
        SecureField(
            "",
            text: $text,
            prompt: Text(title)
                .font(AppFont.PretendardBold(size: 15))
                .foregroundStyle(.textFieldTitle))
            .padding()
            .font(AppFont.PretendardBold(size: 15))
            .foregroundStyle(.textFieldTitle)
            .background(.textFieldBackground)
            .clipShape(RoundedRectangle(cornerRadius: 13))
            .frame(width: 300,height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 13)
                    .stroke(.textFieldBorder, lineWidth: 1)
            )
    }
}

#Preview {
    @Previewable @State var text = ""
    var title = "아이디"
    CustomSecureField(text: $text, title: title)
}
