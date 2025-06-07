//
//  TeamJoinView.swift
//  walkingGO
//
//  Created by 박성민 on 6/4/25.
//

import SwiftUI

struct TeamJoinView: View {
    @EnvironmentObject var pathModel : PathModel
    @State var text: String = ""
    var body: some View {
        VStack{
            teamjoinHeader
            Spacer()
            
            Text("팀에 입장하기 위해서 코드를 입력해주세요!")
                .font(AppFont.PretendardSemiBold(size: 16))
            
            Spacer()
                .frame(height: 30)
            
            CustomTextField(text: $text)
            
            Spacer()
                .frame(height: 30)
            
            CustomButton(
                title: "완료",
                action: {
                    print("asdasd")
                }
            )
            
            Spacer()
                .frame(height: 20)
            
            Button{
                
            }label: {
                Text("만약 정해진 팀이 없다면? 팀 찾으러 가기")
                    .foregroundStyle(.textFieldTitle)
                    .font(AppFont.PretendardBold(size: 10))
                    .underline()
            }
            
            Spacer()
        }
    }
    
    var teamjoinHeader: some View {
        ZStack{
            Rectangle()
                .foregroundStyle(.customBlue)
                .frame(height: 50)
                .background(.customBlue)
            HStack{
                Spacer()
                Image("plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .onTapGesture {
                        pathModel.paths.append(.createTeam)
                    }
                Spacer()
                    .frame(width: 20)
            }
        }
    }
}

#Preview {
    TeamJoinView()
        .environmentObject(PathModel())
}
