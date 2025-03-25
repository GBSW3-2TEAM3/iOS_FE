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
    var body: some View {
        Button(action:action){
            Text(title)
                .frame(width: 300,height: 50)
                .font(AppFont.PretendardBold(size: 15))
                .foregroundStyle(.white)
                .background(.customBlue)
                .clipShape(RoundedRectangle(cornerRadius: 13))
        }
    }
}

#Preview {
    CustomButton(
        title:"로그인",
        action: {}
    )
}
