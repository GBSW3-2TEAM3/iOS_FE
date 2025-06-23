//
//  MainView.swift
//  walkingGO
//
//  Created by 박성민 on 4/1/25.
//
import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    @EnvironmentObject var pathModel: PathModel
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.customBlue
                    .edgesIgnoringSafeArea(.top)
                VStack {
                    MainViewHeader()
                    MainViewTitle()
                    GoalProgressBar(
                        totalValue: 5000,
                        currentValue: 2800,
                        width: geometry.size.width
                    )
                    Spacer()
                        .frame(height: 30)
                    HStack {
                        Spacer()
                        Button {
                            pathModel.paths.append(.goal)
                        } label: {
                            Text("목표 수정하기")
                                .font(AppFont.PretendardMedium(size: 10))
                                .foregroundStyle(.white)
                                .underline(true, color: .white)
                        }
                        Spacer()
                            .frame(width: 25)
                    }
                    Spacer()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.white)
                    VStack {
                        Spacer()
                            .frame(height: 10)
                        GroupRank()
                            .environmentObject(viewModel)
                        Spacer()
                            .frame(height: 10)
                        MyRecorde()
                            .environmentObject(viewModel)
                        Spacer()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.70)
                .padding(.top, geometry.size.height * 0.40)
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

fileprivate struct MainViewHeader: View {
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 20)
            Image("MainLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 27)
            Spacer()
            Image(systemName: "bell.fill")
                .foregroundStyle(.white)
                .scaledToFit()
                .frame(width: 30)
                .overlay(
                    Circle()
                        .fill(Color.red)
                        .frame(width: 6, height: 6)
                        .offset(x: -6, y: 2), alignment: .topTrailing
                )
            Spacer()
                .frame(width: 20)
        }
    }
}

fileprivate struct MainViewTitle: View {
    var name: String = "성민"
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 23)
            VStack(alignment: .leading) {
                Text("반가워요, \(name)님")
                Text("오늘의 목표를 달성해봐요!")
            }
            .font(AppFont.PretendardSemiBold(size: 20))
            .foregroundStyle(.white)
            Spacer()
            AnimatedImage(url: URL(string: "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/People/Man%20Running.png"))
                .resizable()
                .scaledToFit()
                .frame(width: 120)
            Spacer()
                .frame(width: 20)
        }
    }
}

fileprivate struct GoalProgressBar: View {
    var totalValue: Int
    var currentValue: Int
    var width: CGFloat
    
    var progress: Double {
        totalValue == 0 ? 0 : Double(currentValue) / Double(totalValue)
    }
    
    var progressPercentage: Double {
        return (Double(currentValue) / Double(totalValue)) * 100
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("오늘 목표")
                    .foregroundStyle(.white)
                    .font(AppFont.PretendardSemiBold(size: 14))
                Spacer()
            }
            .padding([.leading, .trailing], 15)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: width * 0.9, height: 20)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
                Rectangle()
                    .frame(width: (width * CGFloat(self.progress)) * 0.9, height: 20)
                    .cornerRadius(10)
                    .foregroundColor(.progressBlue)
                
                Triangle()
                    .fill(Color.white)
                    .frame(width: 26, height: 11)
                    .offset(y: 25)
                    .padding(.leading, (width * (CGFloat(self.progress) * 0.92)) * 0.9)
                
                VStack {
                    Rectangle()
                        .foregroundStyle(.white)
                        .frame(width: 55, height: 33)
                        .cornerRadius(5)
                        .offset(y: 55)
                        .padding(.leading, (width * (CGFloat(self.progress) * 0.85)) * 0.9)
                    Text("\(Int(progressPercentage))%")
                        .foregroundStyle(.progressBlue)
                        .font(AppFont.PretendardSemiBold(size: 16))
                        .offset(y: 25)
                        .padding(.leading, (width * (CGFloat(self.progress) * 0.85)) * 0.9)
                }
            }
        }
    }
}

fileprivate struct GroupRank: View {
    @EnvironmentObject private var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 10)
                Text("그룹 순위")
                    .font(AppFont.PretendardSemiBold(size: 14))
                Spacer()
                Text("더보기")
                    .foregroundStyle(.gray)
                    .font(AppFont.PretendardMedium(size: 11))
                Spacer()
                    .frame(width: 10)
            }
            ZStack {
                Rectangle()
                    .foregroundStyle(.textFieldBackground)
                    .frame(width: 350, height: 84)
                    .cornerRadius(10)
                if viewModel.myRank != nil {
                    HStack {
                        Spacer()
                            .frame(width: 20)
                        Image("Medal")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                        Text("봉양레인저팀은 현재")
                            .font(AppFont.PretendardBold(size: 14))
                        
                        Text(viewModel.myRank != nil ? "\(viewModel.myRank!)위" : "없음")
                            .font(AppFont.PretendardBold(size: 20))
                            .foregroundStyle(.red)
                        
                        Text("입니다")
                            .font(AppFont.PretendardBold(size: 14))
                        Spacer()
                            .frame(width: 20)
                    }
                    .padding()
                } else {
                    VStack{
                        Text("나의 팀이 존재하지 않아요\n팀을 만들거나 가입해보세요!")
                            .multilineTextAlignment(.center)
                            .font(AppFont.PretendardSemiBold(size: 15))
                    }
                }
            }
        }
        .padding()
    }
}

fileprivate struct MyRecorde: View {
    @EnvironmentObject var pathModel: PathModel
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.textFieldBackground)
                .frame(width: 402, height: 270)
            VStack {
                Spacer()
                    .frame(height: 20)
                ZStack {
                    Rectangle()
                        .frame(width: 350, height: 113)
                        .cornerRadius(10)
                        .foregroundStyle(.white)
                        .overlay {
                            HStack(spacing: 55) {
                                ForEach(viewModel.topThreeTeams) { team in
                                    VStack(spacing: 8) {
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
                                        
                                        VStack(spacing: 2) {
                                            Text(team.name)
                                                .font(AppFont.PretendardBold(size: 10))
                                                .multilineTextAlignment(.center)
                                            Text(String(format: "%.2f km", team.totalDistanceKm))
                                                .font(AppFont.PretendardSemiBold(size: 8))
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                }
                Spacer()
                    .frame(height: 20)
                Button {
                    pathModel.paths.append(.map)
                } label: {
                    HStack {
                        Text("운동 기록하기")
                            .font(AppFont.PretendardMedium(size: 14))
                            .foregroundStyle(.white)
                        Image("Record")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15)
                    }
                    .frame(width: 143, height: 40)
                    .background(.mainBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding([.leading, .trailing], 15)
        }
        .onAppear {
            viewModel.getRanks()
        }
    }
}

#Preview {
    MainView()
        .environmentObject(PathModel())
        .environmentObject(MainViewModel())
}
