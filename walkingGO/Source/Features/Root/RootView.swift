//
//  RootView.swift
//  walkingGO
//
//  Created by 박성민 on 3/24/25.
//

import SwiftUI

struct RootView: View {
    @StateObject var pathModel = PathModel()
    var body: some View {
        NavigationStack(path: $pathModel.paths){
            VStack{
                ProgressView()
            }
            .onAppear {
                //MARK: - keyChain확인해서 토큰이 있으면 메인 페이지 아니면 로그인
                pathModel.paths.append(.login)
            }
            .navigationDestination(for: PathType.self) { route in
                switch route{
                case .login:
                    LoginView()
                        .navigationBarBackButtonHidden()
                    
                case .signUp:
                    SignUpView()
                        .navigationBarBackButtonHidden()
                    
                case .menu:
                    MenuView()
                        .navigationBarBackButtonHidden()
                    
                case .createTeam:
                    TeamCreateView()
                        .navigationBarBackButtonHidden()
                }
            }
        }
        .environmentObject(pathModel)
    }
}

#Preview {
    RootView()
}
