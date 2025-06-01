//
//  GoalView.swift
//  walkingGO
//
//  Created by 박성민 on 6/1/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct GoalView: View {
    @State private var value: Double = 3.0
    @EnvironmentObject var pathModel: PathModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .padding(.leading, 10)
                    .onTapGesture {
                        pathModel.paths.removeLast()
                    }
                Spacer()
            }
            Spacer()
            
            AnimatedImage(url:URL(string: "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Activities/Trophy.png"))
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            
            Text("하루 목표를 설정해주세요!")
                .font(.system(size: 18, weight: .semibold))
                .padding(.top, 10)
            Spacer()
                .frame(height: 10)
            HStack{
                Text("0")
                Spacer()
                Text("2.5")
                Spacer()
                Text("5")
            }
            .padding(.horizontal,20)
            .font(AppFont.PretendardSemiBold(size: 13))
            .foregroundStyle(.textFieldTitle)
            
            CustomSlider(value: $value, range: 0...5, step: 0.5)
                .frame(height: 10)
                .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 40)
            Text(String(format: "%.1f km", value))
                .font(AppFont.PretendardSemiBold(size: 23))
                .padding(.top, 10)
            Spacer()
                .frame(height: 40)
            
            CustomButton(
                title: "완료",
                action: {
                    //백엔드 유저 목표 수정 요청
                    pathModel.paths.removeLast()
                },
                width: 180
            )
            Spacer()
        }
    }
}
#Preview {
    GoalView()
        .environmentObject(PathModel())
}
