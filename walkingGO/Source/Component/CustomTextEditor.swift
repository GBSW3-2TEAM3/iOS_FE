//
//  CustomTextEditor.swift
//  walkingGO
//
//  Created by 박성민 on 4/22/25.
//

import SwiftUI

struct CustomTextEditorStyle: ViewModifier {
    
    let placeholder: String
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 300, height: 116)
            .background(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .lineSpacing(10)
                        .padding(20)
                        .padding(.top, 2)
                        .font(AppFont.PretendardSemiBold(size: 15))
                        .foregroundColor(.textFieldTitle)
                }
            }
            .textInputAutocapitalization(.none)
            .autocorrectionDisabled()
            .background(.textFieldBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 13)
                    .stroke(Color.textFieldBorder, lineWidth: 1) 
            )
            .clipShape(RoundedRectangle(cornerRadius: 13))
            .scrollContentBackground(.hidden)
            .font(AppFont.PretendardSemiBold(size: 15))
            .overlay(alignment: .bottomTrailing) {
                Text("\(text.count) / 100")
                    .font(.system(size: 12))
                    .foregroundColor(Color(UIColor.systemGray2))
                    .padding(.trailing, 15)
                    .padding(.bottom, 15)
                    .onChange(of: text) { newValue in
                        if newValue.count > 100 {
                            text = String(newValue.prefix(100))
                        }
                    }
            }
    }
}

extension TextEditor {
    func customStyleEditor(placeholder: String, userInput: Binding<String>) -> some View {
        self.modifier(CustomTextEditorStyle(placeholder: placeholder, text: userInput))
    }
}

