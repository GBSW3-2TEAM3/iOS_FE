//
//  SignUpView.swift
//  walkingGO
//
//  Created by 박성민 on 3/24/25.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    @EnvironmentObject var pathModel : PathModel
    var body: some View {
        VStack{
            TopProgressBar()
            
            SignUpForm(
                id: $viewModel.signUpData.id,
                name: $viewModel.signUpData.name,
                password: $viewModel.signUpData.password,
                passwordCheck: $viewModel.signUpData.passwordCheck,
                email: $viewModel.signUpData.email,
                buttonAction: viewModel.signUp
            )
            
        }
        .alert(isPresented: $viewModel.showAlert){
            if viewModel.successMessage != nil {
                return Alert(
                    title: Text("회원가입 성공"),
                    message: Text(viewModel.successMessage ?? "성공"),
                    dismissButton: .default(Text("확인")){
                        pathModel.paths.removeLast()
                    }
                )
            } else {
                return Alert(
                    title: Text("회원가입 실패"),
                    message: Text(viewModel.errorMessage ?? ""),
                    dismissButton: .default(Text("확인"))
                )
            }
        }
    }
}

fileprivate struct SignUpForm: View {
    @Binding var id: String
    @Binding var name: String
    @Binding var password: String
    @Binding var passwordCheck: String
    @Binding var email: String
    var buttonAction: () -> Void
    
    @State private var selectedDomain = "naver.com"
    let emailOptions = ["proton.me", "hanmail.net", "kakao.com", "daum.com", "gmail.com", "naver.com"]
    
    var body : some View {
        VStack{
            Spacer()
                .frame(height: 30)
            
            ZStack{
                Circle()
                    .frame(width: 200)
                    .foregroundStyle(.profile)
                
                Image("character")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170)
            }
            
            Spacer()
                .frame(height: 40)
            
            VStack(spacing: 15){
                CustomTextField(text: $id, title: "아이디")
                CustomTextField(text: $name, title: "이름")
                CustomSecureField(text: $password, title: "비밀번호")
                CustomSecureField(text: $passwordCheck, title: "비밀번호 확인")
                HStack{
                    CustomTextField(text: $email, title: "이메일", width: 135)
                    Text("@")
                        .foregroundStyle(.textFieldTitle)
                    Menu {
                        ForEach(emailOptions, id: \.self) { domain in
                            Button(domain) {
                                selectedDomain = domain
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedDomain)
                                .font(AppFont.PretendardBold(size: 15))
                                .foregroundStyle(.textFieldTitle)
                                .frame(height: 50)
                                .padding(.leading, 15)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .foregroundStyle(.textFieldTitle)
                                .font(.system(size: 15))
                                .padding(.trailing, 10)
                        }
                        .frame(width: 135)
                        .background(.textFieldBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 13))
                        .overlay(
                            RoundedRectangle(cornerRadius: 13)
                                .stroke(.textFieldBorder, lineWidth: 1)
                        )
                    }
                }
            }
            
            Spacer()
                .frame(height:50)
            
            CustomButton(
                title: "다음",
                action: buttonAction
            )
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(PathModel())
}
