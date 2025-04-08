//
//  LoginView.swift
//  walkingGO
//
//  Created by 박성민 on 3/24/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @EnvironmentObject var pathModel: PathModel
    
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 152)
            
            Spacer()
                .frame(height: 38)
            
            LoginForm(
                id: $viewModel.id,
                password: $viewModel.password,
                action: {
                    pathModel.paths.append(.menu)
                }
            )
            
            Spacer()
                .frame(height: 32)
            
            AuthLinks(goSignUp: {
                pathModel.paths.append(.signUp)}
            )
            
            Spacer()
                .frame(height: 40)
            
            SocialLoginForm()
        }
    }
}

fileprivate struct LoginForm: View {
    @Binding var id : String
    @Binding var password : String
    var action: () -> Void
    var body: some View {
        VStack{
            CustomTextField(
                text: $id,
                title: "아이디"
            )
            
            Spacer()
                .frame(height: 19)
            
            CustomSecureField(
                text: $password,
                title: "비밀번호"
            )
            
            Spacer()
                .frame(height: 19)
            
            CustomButton(
                title: "로그인",
                action: action
            )
        }
    }
}

fileprivate struct AuthLinks : View {
    var goSignUp : () -> Void
    var body: some View {
        HStack{
            Button{
                
            }label:{
                Text("비밀번호 찾기")
                    .font(AppFont.PretendardMedium(size: 12))
                    .foregroundStyle(.textFieldTitle)
                    .underline(true,color: .textFieldTitle)
            }
            Spacer()
                .frame(width: 70)
            Button(action: goSignUp){
                Text("회원가입 하기")
                    .font(AppFont.PretendardMedium(size: 12))
                    .foregroundStyle(.textFieldTitle)
                    .underline(true,color: .textFieldTitle)
            }
        }
    }
}

fileprivate struct SocialLoginForm: View {
    var body: some View {
        VStack{
            HStack(spacing:12){
                Rectangle()
                    .frame(width:105, height: 1)
                
                Text("간편 로그인")
                    .font(AppFont.PretendardBold(size: 12))
                    .foregroundStyle(.socialLoginText)
                
                Rectangle()
                    .frame(width:105, height: 1)
            }
            
            Spacer()
                .frame(height: 31)
            
            HStack(spacing:28){
                Button{
                    
                }label: {
                    Image("kakaoLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                }
                Button{
                    
                }label: {
                    Image("googleLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                }
                Button{
                    
                }label: {
                    Image("naverLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                }
            }
        }
    }
}
#Preview {
    LoginView()
        .environmentObject(PathModel())
}
