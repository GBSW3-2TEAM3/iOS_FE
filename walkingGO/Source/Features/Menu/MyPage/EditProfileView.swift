//
//  EditProfileView.swift
//  walkingGO
//
//  Created by 박성민 on 6/7/25.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var pathModel: PathModel
    @StateObject var viewModel = EditProfileViewModel()
    
    var body: some View {
        VStack{
            editHeader
            
            Spacer()
            
            editBody
            
            Spacer()
        }
        .alert(isPresented: $viewModel.showAlert){
            return Alert(
                title: Text("몸무게 변경 성공"),
                message: Text("몸무게 변경에 성공했습니다."),
                dismissButton: .default(Text("확인")){
                    pathModel.paths.removeLast()
                })
        }
    }
    
    var editHeader: some View {
        ZStack{
            Rectangle()
                .frame(height: 50)
                .foregroundStyle(.customBlue)
                .background(.customBlue)
            HStack{
                Spacer()
                    .frame(width:20)
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
                    .onTapGesture {
                        pathModel.paths.removeLast()
                    }
                Spacer()
            }
        }
    }
    
    var editBody: some View {
        VStack(spacing:20){
            ZStack{
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.yellow)
                Image("character")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
            }
            
            CustomTextField(
                text: $viewModel.userWeight,
                title: "몸무게"
            )
            
            CustomButton(
                title: "수정하기",
                action: {
                    viewModel.changeUser()
                }
            )
        }
    }
}

#Preview {
    EditProfileView()
}
