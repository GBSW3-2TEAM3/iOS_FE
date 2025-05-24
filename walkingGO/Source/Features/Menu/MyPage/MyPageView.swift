//
//  MyPageView.swift
//  walkingGO
//
//  Created by 박성민 on 4/8/25.

import SwiftUI

struct MyPageView: View {
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Spacer()
                    .frame(height: 50)
                Color.textFieldBackground
            }
            VStack {
                MyPageViewHeader()
                ScrollView{
                    MyRecord()
                    
                    Spacer()
                        .frame(height: 30)
                    
                    RouteView()
                    
                    CalendarView()
                        .padding()
                    
                    Spacer()
                }
            }
        }
    }
}

fileprivate struct MyPageViewHeader: View {
    var body: some View{
        VStack{
            HStack{
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
            .frame(height: 50)
            .background(.customBlue)
        }
    }
}

fileprivate struct MyRecord: View {
    var body: some View{
        VStack{
            Spacer()
                .frame(height: 20)
            HStack{
                Spacer()
                    .frame(width:20)
                Text("내 활동 기록")
                    .font(AppFont.PretendardSemiBold(size: 14))
                Spacer()
            }
            Spacer()
                .frame(height: 20)
            HStack{
                //MARK: - 걸음
                RecordBox(
                    image: imageURL.footprint,
                    title: "걸음",
                    data: "1234"
                )
                Spacer()
                    .frame(width: 10)
                //MARK: - 시간
                RecordBox(
                    image: imageURL.clock,
                    title: "시간",
                    data: "02:54:41"
                )
            }
            HStack{
                //MARK: - 거리
                RecordBox(
                    image: imageURL.fire,
                    title: "거리(km)",
                    data: "2.5km"
                )
                Spacer()
                    .frame(width: 10)
                //MARK: - 칼로리
                RecordBox(
                    image: imageURL.fire,
                    title: "칼로리(kcal)",
                    data: "1523"
                )
            }
        }
    }
}

fileprivate struct RouteView : View {
    var body: some View{
        ZStack{
            //MARK: - 지도 뷰
            Rectangle()
                .frame(width: 350,height: 300)
                .cornerRadius(5)
            Text("지도 뷰를 여기다 띄워줄예정입니다")
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    MyPageView()
}
