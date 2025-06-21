//
//  TeamView.swift
//  walkingGO
//
//  Created by 박성민 on 5/7/25.
//

import SwiftUI

struct TeamView: View {
    var teamName: String = "할래'말레'"
    var teamdescription: String = "경소고 친구들이 모여서 만든 러닝 크루!"
    @StateObject var viewModel = TeamViewModel()
    @EnvironmentObject var pathModel: PathModel
    
    var body: some View {
        Group{
            if viewModel.team == nil {
                //MARK: - 팀이 없을때
                TeamRecommend(viewModel: .init(pathModel: pathModel))
            }else{
                //MARK: - 팀이 있을때
                teamPresentView
            }
        }
        .onAppear {
            viewModel.hasTeamCheck()
        }
    }
    
    var teamPresentView: some View {
        ZStack{
            Color.customBlue
                .edgesIgnoringSafeArea(.top)
            VStack{
                HStack{
                    Spacer()
                    Image(systemName: "gearshape.fill")
                        .onTapGesture {
                            pathModel.paths.append(.detailTeam(viewModel.detailTeam!))
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
                        Text(viewModel.team?.name ?? teamName)
                            .font(AppFont.PretendardBold(size: 22))
                        Spacer()
                            .frame(height: 10)
                        Text(viewModel.team?.description ?? "")
                            .font(AppFont.PretendardMedium(size: 15))
                        Spacer()
                            .frame(height: 15)
                        VStack(spacing:22){
                            if let member = viewModel.detailTeam?.members {
                                ForEach(member, id: \.userId) { member in
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
                                        
                                        Text(String(format: "%.2f",member.totalDistanceKm))
                                            .font(AppFont.PretendardSemiBold(size: 13))
                                        
                                        Spacer()
                                            .frame(width: 20)
                                    }
                                    .frame(width:350, height: 55)
                                    .background(.white)
                                    .cornerRadius(10)
                                }
                            } else {
                                Text("멤버 정보가 없습니다.")
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
    TeamView()
        .environmentObject(PathModel())
}
