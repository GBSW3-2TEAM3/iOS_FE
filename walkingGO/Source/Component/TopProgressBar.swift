//
//  TopProgressBar.swift
//  walkingGO
//
//  Created by 박성민 on 3/27/25.
//

import SwiftUI

struct TopProgressBar: View {
    var body: some View {
        HStack{
            ZStack{
                Circle()
                    .frame(width: 40)
                    .foregroundStyle(.textFieldBackground)
                Text("1")
                    .font(AppFont.PretendardSemiBold(size: 15))
                    .foregroundStyle(.customBlue)
            }
            Rectangle()
                .frame(width: 80,height: 5)
                .foregroundStyle(.topBarGray)
                .padding(.horizontal,-10)
            ZStack{
                Circle()
                    .frame(width: 40)
                    .foregroundStyle(.textFieldBackground)
                Text("2")
                    .font(AppFont.PretendardSemiBold(size: 15))
                    .foregroundStyle(.customBlue)
            }
            Rectangle()
                .frame(width: 80, height: 5)
                .foregroundStyle(.topBarGray)
                .padding(.horizontal,-10)
            ZStack{
                Circle()
                    .frame(width: 40)
                    .foregroundStyle(.textFieldBackground)
                Text("3")
                    .font(AppFont.PretendardSemiBold(size: 15))
                    .foregroundStyle(.customBlue)
            }
        }
    }
}

#Preview {
    TopProgressBar()
}
