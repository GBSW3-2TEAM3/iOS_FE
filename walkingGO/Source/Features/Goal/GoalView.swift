//
//  GoalView.swift
//  walkingGO
//
//  Created by 박성민 on 6/1/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct GoalView: View {
    @StateObject var viewModel = GoalViewModel()
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
            
            CustomSlider(value: $viewModel.value, range: 0...5, step: 0.5)
                .frame(height: 10)
                .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 40)
            
            Text(String(format: "%.1f km", viewModel.value))
                .font(AppFont.PretendardSemiBold(size: 23))
                .padding(.top, 10)
            
            Spacer()
                .frame(height: 40)
            
            CustomButton(
                title: "완료",
                action: {
                    //백엔드 유저 목표 수정 요청
                    viewModel.changeUser()
                },
                width: 180
            )
            Spacer()
        }
        .alert(isPresented: $viewModel.showAlert){
            return Alert(
                title: Text("목표 수정 성공"),
                message: Text("목표 수정에 성공하였습니다."),
                dismissButton: .default(Text("확인")){
                    pathModel.paths.removeLast()
                }
            )
        }
    }
}
#Preview {
    GoalView()
        .environmentObject(PathModel())
}
