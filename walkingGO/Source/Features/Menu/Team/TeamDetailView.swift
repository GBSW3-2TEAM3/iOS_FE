//
//  TeamDetailView.swift
//  walkingGO
//
//  Created by 박성민 on 6/10/25.
//

import SwiftUI

struct TeamDetailView: View {
    let team: TeamDetailResponse
    @EnvironmentObject var pathModel: PathModel
    
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
                        pathModel.paths.removeLast()
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
                    
                    Text("팀 명 : \(team.groupName)")
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.textFieldTitle)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    if team.participationCode == nil {
                        Text("팀 소개 : \n\(team.description ?? "팀 소개")")
                            .multilineTextAlignment(.center)
                    }else {
                        Text("팀 비번을 여기 작성")
                    }
                    
                    Spacer()
                        .frame(height: 30)
                    
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.textFieldTitle)
                    
                    
                    ForEach(team.members, id: \.userId){ member in
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
                    
                    if team.owner {
                        CustomButton(
                            title: "방 삭제하기",
                            action: {
                                print("방 삭제")
                            },
                            backgroundColor: .deleteRed
                        )
                    } else {
                        CustomButton(
                            title: "탈퇴하기",
                            action: {
                                print("탈퇴")
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
    TeamDetailView(team: TeamDetailResponse(
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
    ))
}
