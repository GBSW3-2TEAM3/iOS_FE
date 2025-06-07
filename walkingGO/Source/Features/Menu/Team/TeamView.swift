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
    
    var body: some View {
        Group{
            //MARK: - 팀이 없을때
            TeamRecommend()
            //MARK: - 팀이 있을때
            //teamPresentView
        }
        .onAppear{
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
                        Text(teamName)
                            .font(AppFont.PretendardBold(size: 22))
                        Spacer()
                            .frame(height: 10)
                        Text(teamdescription)
                            .font(AppFont.PretendardMedium(size: 15))
                        Spacer()
                            .frame(height: 15)
                        VStack(spacing:22){
                            ForEach(viewModel.members, id: \.self) { member in
                                HStack{
                                    Spacer()
                                        .frame(width: 20)
                                    
                                    Circle()
                                        .frame(width: 35)
                                        .foregroundStyle(member.color)
                                    
                                    Spacer()
                                        .frame(width: 14)
                                    
                                    Text(member.name)
                                        .font(AppFont.PretendardSemiBold(size: 11))
                                        .foregroundStyle(member.color)
                                    
                                    Spacer()
                                    
                                    Text("\(member.score)")
                                        .font(AppFont.PretendardSemiBold(size: 13))
                                        .foregroundStyle(member.color)
                                    
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
    TeamView()
}
