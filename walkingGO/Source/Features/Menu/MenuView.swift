//
//  MenuView.swift
//  walkingGO
//
//  Created by 박성민 on 4/1/25.
//

import SwiftUI

struct MenuView: View {
    @State var selectedItem: Int = 0
    var body: some View {
        TabView(selection: $selectedItem){
            MainView()
                .tabItem{
                    Image("home")
                    Text("홈")
                }
                .tag(0)
            TeamView()
                .tabItem {
                    Image("team")
                    Text("팀")
                }
                .tag(1)
            RankView()
                .tabItem{
                    Image("rank")
                    Text("순위")
                }
                .tag(2)
            MyPageView()
                .tabItem{
                    Image("profil")
                    Text("마이")
                }
                .tag(3)
        }
        .tint(.customBlue)
    }
}

#Preview {
    MenuView()
}
