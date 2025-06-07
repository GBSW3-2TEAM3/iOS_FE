//
//  RouteView.swift
//  walkingGO
//
//  Created by 박성민 on 6/4/25.
//

import SwiftUI

struct RouteView: View {
    @StateObject var viewModel = RouteViewModel()
    var body: some View {
        VStack(spacing:0){
            Rectangle()
                .frame(height: 50)
                .foregroundStyle(.customBlue)
                .background(.customBlue)
            
            ZStack{
                Color.viewGray
                ScrollView{
                    VStack{
                        HStack{
                            Text("경로 추천")
                                .font(AppFont.PretendardSemiBold(size: 14))
                            Spacer()
                            Text("필터")
                                .font(AppFont.PretendardMedium(size: 11))
                        }
                        .padding(25)
                        
                        ForEach(viewModel.route, id: \.id){ route in
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 350, height: 55)
                                .foregroundStyle(.white)
                                .overlay {
                                    HStack{
                                        Text(route.name)
                                            .font(AppFont.PretendardBold(size: 16))
                                        Spacer()
                                        Text(String(format: "%.1f", route.km))
                                            .font(AppFont.PretendardSemiBold(size: 13))
                                            .foregroundStyle(.customBlue)
                                        Text(route.time)
                                            .font(AppFont.PretendardSemiBold(size: 13))
                                    }
                                    .padding(.horizontal,20)
                                }
                            
                            Spacer()
                                .frame(height: 20)
                        }
                        
                        Spacer()
                    }
                    
                }
                Spacer()
            }
        }
    }
}

#Preview {
    RouteView()
}
