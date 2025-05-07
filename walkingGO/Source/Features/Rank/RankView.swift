//
//  RankView.swift
//  walkingGO
//
//  Created by 박성민 on 5/6/25.
//

import SwiftUI

struct RankView: View {
    @EnvironmentObject private var pathModel: PathModel
    @StateObject var viewModel = RankViewModel()
    var body: some View {
        VStack(spacing:0){
            RankMenuBar()
            ScrollView{
                VStack{
                    RecommendTeamView()
                    
                    teamRankingView
                    Spacer()
                }
                .frame(maxWidth:.infinity)
                .background(.viewGray)
            }
        }
    }
    
    var teamRankingView: some View {
        LazyVStack(spacing:15){
            HStack{
                Text("오늘의 Top 3")
                    .font(AppFont.PretendardSemiBold(size: 14))
                    .padding([.top,.leading],15)
                    .padding(.bottom,5)
                Spacer()
            }
            
            Rectangle()
                .frame(width: 350, height: 170)
                .cornerRadius(15)
                .foregroundStyle(.white)
                .overlay{
                        HStack(spacing:40){
                            ForEach(viewModel.topThreeTeams){ team in
                                VStack(spacing:8){
                                    let medalImage = {
                                        switch team.rank {
                                        case 1:
                                            return "goldRank"
                                        case 2:
                                            return "silverRank"
                                        case 3:
                                            return "bronzeRank"
                                        default:
                                            return "goldRank"
                                        }
                                    }()
                                    
                                    Image(medalImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70)
                                    
                                    VStack(spacing:2){
                                        Text(team.name)
                                            .font(AppFont.PretendardBold(size: 14))
                                            .multilineTextAlignment(.center)
                                        Text("\(team.score)")
                                            .font(AppFont.PretendardSemiBold(size: 12))
                                            .multilineTextAlignment(.center)
                                    }
                                    
                                }
                            }
                        }
                }
            
            ForEach(viewModel.remainingTeams) { team in
                Rectangle()
                    .frame(width: 350, height: 55)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                    .overlay{
                        HStack{
                            Spacer()
                                .frame(width: 23)
                            
                            Text("\(team.rank)")
                                .font(AppFont.PretendardSemiBold(size: 20))
                            
                            Spacer()
                                .frame(width: 12)
                            
                            Text(team.name)
                                .font(AppFont.PretendardSemiBold(size: 16))
                            
                            Spacer()
                            
                            Text("\(team.score)")
                                .font(AppFont.PretendardSemiBold(size: 13))
                                .foregroundStyle(.customBlue)
                            
                            Spacer()
                                .frame(width: 23)
                        }
                    }
            }
        }
    }
}

private struct RankMenuBar: View {
    @EnvironmentObject private var pathModel: PathModel
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                    .frame(height: 1)
                Rectangle()
                    .frame(height: 50)
                    .foregroundStyle(.customBlue)
            }
            HStack{
                Spacer()
                Image("search")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22)
                    .foregroundStyle(.white)
                
                Image("plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22)
                    .foregroundStyle(.white)
                    .onTapGesture{
                        print("클릭!")
                        pathModel.paths.append(.createTeam)
                    }
            }
            .padding(.trailing,10)
        }
    }
}

private struct RecommendTeamView: View {
    var body: some View {
        VStack{
            HStack{
                Text("추천팀")
                    .font(AppFont.PretendardSemiBold(size: 14))
                    .padding([.top,.leading],15)
                    .padding(.bottom,5)
                Spacer()
            }
            Rectangle()
                .frame(width: 330, height: 430)
                .cornerRadius(15)
                .foregroundStyle(.customBlue)
                .overlay{
                    VStack(spacing:15){
                        Rectangle()
                            .frame(width: 280, height: 180)
                            .cornerRadius(15)
                            .foregroundStyle(.white)
                            .overlay{
                                Text("여기 팀페이지 ")
                            }
                        
                        Text("할래'말레' (2/3)")
                            .font(AppFont.PretendardBold(size: 22))
                            .foregroundStyle(.white)
                        
                        Text("경소고 친구들이 모여서 만든 러닝 크루!")
                            .font(AppFont.PretendardMedium(size: 15))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(20)
                }
        }
    }
}

#Preview {
    RankView()
        .environmentObject(PathModel())
}
