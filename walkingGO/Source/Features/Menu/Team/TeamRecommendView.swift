//
//  TeamRecommendView.swift
//  walkingGO
//
//  Created by 박성민 on 6/4/25.
//

import SwiftUI

struct TeamRecommend: View {
    @StateObject var viewModel : TeamRecommendViewModel
    
    var body: some View {
        VStack(spacing: 0){
            recommendheader
            
            ZStack{
                Color.viewGray
                
                recommendbody
                
            }
            Spacer()
        }
    }
    
    var recommendheader: some View {
        ZStack{
            Color.customBlue
                .background(.customBlue)
                .frame(height: 50)
            
            HStack{
                Spacer()
                Image("plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .onTapGesture {
                        viewModel.send(action: .createTeam)
                    }
                Spacer()
                    .frame(width: 20)
                Image("secert")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .onTapGesture {
                        viewModel.send(action: .secretTeam)
                    }
                Spacer()
                    .frame(width: 20)
            }
        }
    }
    
    var recommendbody: some View {
        VStack{
            ScrollView{
                HStack{
                    Text("빠른 팀 가입")
                        .font(AppFont.PretendardSemiBold(size: 14))
                    Spacer()
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 350,height: 88)
                    .foregroundStyle(.navy)
                    .overlay {
                        VStack{
                            HStack{
                                Text("봉양레인저")
                                    .font(AppFont.PretendardBold(size: 16))
                                    .foregroundStyle(.white)
                                Text("가입")
                                    .frame(width: 35, height: 17)
                                    .font(AppFont.PretendardSemiBold(size: 11))
                                    .foregroundStyle(.navy)
                                    .background(.white)
                                    .cornerRadius(5)
                                Spacer()
                                Text("2/3")
                                    .foregroundStyle(.white)
                                    .font(AppFont.PretendardSemiBold(size: 13))
                                Text("2,360")
                                    .foregroundStyle(.white)
                                    .font(AppFont.PretendardSemiBold(size: 13))
                            }
                            .padding(.horizontal,20)
                            Spacer()
                                .frame(height: 10)
                            
                            HStack{
                                Text("경소고 친구들이 모여서 만든 러닝 크루!")
                                    .font(AppFont.PretendardMedium(size: 11))
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            .padding(.horizontal,20)
                        }
                    }
                
                Spacer()
                    .frame(height: 20)
                HStack{
                    Text("팀 추천")
                        .font(AppFont.PretendardSemiBold(size: 14))
                    Spacer()
                }
                
                ForEach(viewModel.team){ team in
                    Spacer()
                        .frame(height: 15)
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 350, height: 55)
                        .foregroundStyle(.white)
                        .overlay {
                            HStack{
                                Text(team.name)
                                    .font(AppFont.PretendardBold(size: 13))
                                Spacer()
                                Text("\(team.memberCount)/10")
                                    .font(AppFont.PretendardBold(size: 13))
                                
                                //MARK: - 백엔드한테 \(url)/api/groups/public 여기서 받아오는 데이터에 team.totalKM도추가해달라카기
//                                Text(String(format: "%.1f", team.totalKM))
//                                    .foregroundStyle(.customBlue)
//                                    .font(AppFont.PretendardBold(size: 13))
                            }
                            .padding(.horizontal,20)
                        }
                        .onTapGesture {
                            viewModel.detailTeamJoin(groupid: team.id)
                        }
                }
            }
            
            Spacer()
        }
        .padding(25)
    }
    
}

#Preview {
    TeamRecommend(viewModel: TeamRecommendViewModel(pathModel: PathModel()))
        .environmentObject(PathModel())
}
