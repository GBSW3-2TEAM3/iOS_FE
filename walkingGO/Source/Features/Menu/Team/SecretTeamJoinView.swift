//
//  SecretTeamJoinView.swift
//  walkingGO
//
//  Created by 박성민 on 6/5/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct SecretTeamJoinView: View {
    @StateObject var viewModel: SecretTeamJoinViewModel
    var body: some View {
        VStack{
            secretTeamJoinHeader
            Spacer()
            
            AnimatedImage(url: URL(string: "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Shushing%20Face.png"))
                .resizable()
                .scaledToFit()
                .frame(width: 180)
            
            Spacer()
                .frame(height: 35)
            
            Text("비공개 방에 가입하려면\n팀장이 설정한 비밀번호를 입력해주세요!")
                .font(AppFont.PretendardSemiBold(size: 15))
                .multilineTextAlignment(.center)
            
            Spacer()
                .frame(height: 35)
            
            CustomTextField(text: $viewModel.teamCode,title: "비밀번호")
            
            Spacer()
                .frame(height: 35)
            
            CustomButton(
                title: "완료",
                action: {
                    viewModel.secretTeamJoin()
                }
            )
            Spacer()
        }
    }
    
    var secretTeamJoinHeader: some View{
        ZStack{
            
            Rectangle()
                .frame(height: 50)
                .background(.customBlue)
                .foregroundStyle(.customBlue)
            HStack{
                Spacer()
                    .frame(width: 20)
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12)
                    .foregroundStyle(.white)
                    .onTapGesture {
                        viewModel.back()
                    }
                Spacer()
            }
            
        }
    }
}

#Preview {
    SecretTeamJoinView(viewModel: SecretTeamJoinViewModel(pathModel: PathModel()))
}
