//
//  MenuView.swift
//  walkingGO
//
//  Created by 박성민 on 4/1/25.
//

import SwiftUI

struct MenuView: View {
    @State var selectedItem: Int = 2
    var body: some View {
        TabView(selection: $selectedItem){
            RankView()
                .tabItem{
                    Image("rank")
                    Text("순위")
                }
                .tag(0)
            
            TeamCreateView()
//            TeamView()
                .tabItem {
                    Image("team")
                    Text("팀")
                }
                .tag(1)
            
            MainView()
                .tabItem{
                    Image("home")
                    Text("홈")
                }
                .tag(2)
            
            RouteView()
                .tabItem{
                    Image("route")
                    Text("루트")
                }
                .tag(3)
            
            MyPageView()
                .tabItem{
                    Image("profil") 
                    Text("마이")
                }
                .tag(4)
        }
        .tint(.customBlue)
    }
}

#Preview {
    MenuView()
}
