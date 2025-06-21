//
//  TeamJoinView.swift
//  walkingGO
//
//  Created by 박성민 on 6/12/25.
//

import SwiftUI

struct TeamJoinView: View {
    @StateObject var viewModel : TeamJoinViewModel
    
    var body: some View {
        Group{
            teamPresentView
        }
    }
    
    var teamPresentView: some View {
        ZStack{
            Color.customBlue
                .edgesIgnoringSafeArea(.top)
            VStack{
                HStack{
                    Spacer()
                        .frame(width:20)
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12)
                        .foregroundStyle(.white)
                        .onTapGesture {
                            viewModel.back()
                        }
                    Spacer()
                    Button{
                        viewModel.joinTeam()
                    }label:{
                        Text("팀 가입하기")
                            .font(AppFont.PretendardSemiBold(size: 11))
                            .frame(width: 80,height: 30)
                            .foregroundStyle(.customBlue)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                .padding()
                .foregroundStyle(.white)
                Spacer()
            }
            teamMemberView
        }
    }
    
    var teamMemberView: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.textFieldBackground)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height * 0.6)
                    .position(x: geometry.size.width / 2,
                              y: geometry.size.height * 0.8)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Spacer()
                            .frame(height: 80)
                        Text(viewModel.team.groupName)
                            .font(AppFont.PretendardBold(size: 22))
                        Spacer()
                            .frame(height: 10)
                        Text(viewModel.team.description!)
                            .font(AppFont.PretendardMedium(size: 15))
                        Spacer()
                            .frame(height: 15)
                        VStack(spacing:22){
                            ForEach(viewModel.team.members, id: \.userId) { member in
                                HStack{
                                    Spacer()
                                        .frame(width: 20)
                                    
                                    Circle()
                                        .frame(width: 35)
                                    
                                    Spacer()
                                        .frame(width: 14)
                                    
                                    Text(member.username)
                                        .font(AppFont.PretendardSemiBold(size: 11))
                                    
                                    Spacer()
                                    
                                    Text("\(member.totalDistanceKm)")
                                        .font(AppFont.PretendardSemiBold(size: 13))
                                    
                                    Spacer()
                                        .frame(width: 20)
                                }
                                .frame(width:350, height: 55)
                                .background(.white)
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height * 0.6)
                .position(x: geometry.size.width / 2,
                          y: geometry.size.height * 0.8)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .clipped()
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.white)
                    .frame(width: geometry.size.width * 0.9,
                           height: geometry.size.height * 0.45)
                    .position(x:geometry.size.width * 0.5,
                              y: geometry.size.height * 0.35)
                    .overlay {
                        Text("팀 이미지 입니다.")
                    }
            }
        }
        
    }
}

#Preview {
    TeamJoinView(viewModel: TeamJoinViewModel(team: TeamDetailResponse(
        groupId: 5,
        groupName: "팀입니다.",
        description: "공개된 팀",
        currentUserId: 42,
        participationCode: nil,
        members: [
            TeamMember(
                userId: 4,
                username: "박성민",
                totalDistanceKm: 9.9,
                owner: false
            )
        ],
        owner: false
    ), pathModel: PathModel()))

}
