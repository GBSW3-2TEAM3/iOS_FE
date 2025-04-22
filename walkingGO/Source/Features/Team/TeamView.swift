//
//  TeamView.swift
//  walkingGO
//
//  Created by 박성민 on 4/22/25.

import SwiftUI
import SDWebImageSwiftUI

struct TeamView: View {
    @State var title: String = ""
    @State var isPublic: Bool? = nil
    @State var description: String = ""
    @State var password : String = ""
    var body: some View {
        VStack{
            TeamImage()
            Spacer()
                .frame(height: 50)
            TeamForm(
                title: $title,
                isPublic: $isPublic,
                description: $description,
                password: $password
            )
            Spacer()
        }
    }
}

fileprivate struct TeamViewHeader: View {
    var body: some View{
        VStack{
            Spacer()
                .frame(height: 1)
            Rectangle()
                .frame(height: 50)
                .foregroundStyle(.customBlue)
        }
    }
}

fileprivate struct TeamImage: View {
    var body: some View{
        VStack{
            TeamViewHeader()
            
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
}

fileprivate struct TeamForm: View {
    @Binding var title : String
    @Binding var isPublic : Bool?
    @Binding var description: String
    @Binding var password : String
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
                    action: { isPublic = true},
                    width: 144,
                    textColor: isPublic == true ? .publicGreen : .textFieldTitle,
                    backgroundColor: .textFieldBackground,
                    strokeColor: isPublic == true ? .publicGreen : .textFieldBorder
                )
                Spacer()
                    .frame(width: 10)
                CustomButton(
                    title: "private",
                    action: { isPublic = false},
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
                    action: { print("생성") }
                )
            }
        }
    }
}
#Preview {
    TeamView()
}
