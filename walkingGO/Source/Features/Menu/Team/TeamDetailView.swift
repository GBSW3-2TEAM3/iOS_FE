//
//  TeamDetailView.swift
//  walkingGO
//
//  Created by 박성민 on 6/10/25.
//

import SwiftUI

struct TeamDetailView: View {
    @StateObject var viewModel: TeamDetailViewModel
    
    var body: some View {
        VStack(spacing: 0){
            teamDetailViewHeader
            
            
            teamDetailViewBody
            Spacer()
        }
    }
    
    var teamDetailViewHeader: some View {
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
                    .frame(width: 10,height: 20)
                    .foregroundStyle(.white)
                    .onTapGesture {
                        viewModel.back()
                    }
                Spacer()
            }
        }
    }
    
    var teamDetailViewBody: some View {
        ZStack{
            Color.viewGray
            VStack{
                ScrollView{
                    Spacer()
                        .frame(height: 30)
                    
                    Text("팀 명 : \(viewModel.team.groupName)")
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.textFieldTitle)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    if viewModel.team.participationCode == nil {
                        Text("팀 소개 : \n\(viewModel.team.description ?? "팀 소개")")
                            .multilineTextAlignment(.center)
                    }else {
                        Text("팀 비밀번호 : \(viewModel.team.participationCode ?? "팀 비밀번호")")
                    }
                    
                    Spacer()
                        .frame(height: 30)
                    
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.textFieldTitle)
                    
                    
                    ForEach(viewModel.team.members, id: \.userId){ member in
                        Spacer()
                            .frame(height:20)
                        HStack{
                            Spacer()
                                .frame(width:20)
                            Circle()
                                .frame(width: 35)
                            Spacer()
                                .frame(width:20)
                            
                            Text(member.username)
                            
                            if member.owner {
                                Text("팀장")
                                    .font(AppFont.PretendardSemiBold(size: 10))
                                    .frame(width: 40, height: 20)
                                    .foregroundStyle(.white)
                                    .background(.customBlue)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            Spacer()
                        }
                        
                        Spacer()
                            .frame(height:20)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.textFieldTitle)
                    }
                    
                    Spacer()
                        .frame(height: 100)
                    
                    if viewModel.team.owner {
                        CustomButton(
                            title: "팀 삭제하기",
                            action: {
                                viewModel.deleteTeam()
                            },
                            backgroundColor: .deleteRed
                        )
                    } else {
                        CustomButton(
                            title: "탈퇴하기",
                            action: {
                                viewModel.leaveTeam()
                            },
                            backgroundColor: .deleteRed
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    TeamDetailView(viewModel: TeamDetailViewModel(team: TeamDetailResponse(
        groupId: 1,
        groupName: "박성민 님의 팀",
        description: "박성민팀 !!",
        currentUserId: 123,
        participationCode: nil,
        members: [
            TeamMember(
                userId: 123,
                username: "박성민",
                totalDistanceKm: 2.3,
                owner: true
            ),
            TeamMember(
                userId: 23,
                username: "장희철",
                totalDistanceKm: 2.3,
                owner: false
            ),
            TeamMember(
                userId: 1,
                username: "김세연",
                totalDistanceKm: 2.3,
                owner: false
            )
        ],
        owner: true
    ), pathModel: PathModel()))
}
