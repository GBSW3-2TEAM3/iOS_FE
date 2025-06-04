//
//  TeamView.swift
//  walkingGO
//
//  Created by 박성민 on 4/22/25.

import SwiftUI
import SDWebImageSwiftUI

struct TeamCreateView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = TeamCreateViewModel()
    var body: some View {
        VStack{
            teamImage
            Spacer()
                .frame(height: 50)
            TeamForm(
                title: $viewModel.title,
                isPublic: $viewModel.isPublic,
                description: $viewModel.description,
                password: $viewModel.password,
                action: viewModel.teamCreate
            )
            Spacer()
        }
    }
    
    var teamImage: some View{
        VStack{
            teamViewHeader
            
            HStack{
                Spacer()
                    .frame(width: 10)
                Text("팀 생성")
                    .font(AppFont.PretendardSemiBold(size: 14))
                    .padding()
                Spacer()
            }
            AnimatedImage(url:URL(string:"https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Objects/Clipboard.png"))
                .resizable()
                .scaledToFit()
                .frame(width: 195)
        }
    }
    
    var teamViewHeader: some View{
        ZStack{
            Rectangle()
                .frame(height: 50)
                .foregroundStyle(.customBlue)
            HStack{
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10)
                    .foregroundStyle(.white)
                    .padding(.leading,10)
                    .onTapGesture{
                        dismiss()
                    }
                Spacer()
            }
        }
    }
}

fileprivate struct TeamForm: View {
    @Binding var title : String
    @Binding var isPublic : Bool?
    @Binding var description: String
    @Binding var password : String
    let action: () -> Void
    var body: some View{
        VStack{
            CustomTextField(
                text: $title,
                title: "팀명"
            )
            Spacer()
                .frame(height: 15)
            HStack{
                CustomButton(
                    title: "public",
                    action: { isPublic = true },
                    width: 144,
                    textColor: isPublic == true ? .publicGreen : .textFieldTitle,
                    backgroundColor: .textFieldBackground,
                    strokeColor: isPublic == true ? .publicGreen : .textFieldBorder
                )
                Spacer()
                    .frame(width: 10)
                CustomButton(
                    title: "private",
                    action: { isPublic = false },
                    width: 144,
                    textColor: isPublic == false ? .privateRed : .textFieldTitle,
                    backgroundColor: .textFieldBackground,
                    strokeColor: isPublic == false ? .privateRed : .textFieldBorder
                )
            }
            Spacer()
                .frame(height: 15)
            if isPublic == true {
                TextEditor(text: $description)
                        .customStyleEditor(placeholder: "팀 소개 (100자 이내)", userInput: $description)
            }
            if isPublic == false {
                CustomSecureField(
                    text: $password,
                    title: "비밀번호"
                )   
            }
            Spacer()
                .frame(height: 15)
            if isPublic != nil {
                CustomButton(
                    title: "생성",
                    action: { action() }
                )
            }
        }
    }
}
#Preview {
    TeamCreateView()
}
