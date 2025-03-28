//
//  SignUpViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 3/26/25.
//

import Foundation

class SignUpViewModel: ObservableObject{
    @Published var id: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var passwordCheck: String = ""
    @Published var email: String = ""
    @Published var errorMessage: String? = nil
    @Published var showAlert: Bool = false
    
    func signUp() {
        validateId()
        validatePassword()
        
    }
    
    func validateId() {
        if id.count < 4 || id.count > 12 {
            showAlert.toggle()
            errorMessage = "id를 4글자 이상 12글자 이하로 바꿔주세요"
            return
        }
        //MARK: - 이메일 중복체크 백엔드 한번 보내기
        
    }
    
    func validatePassword() {
        if password.count < 4 || password.count > 20 {
            showAlert.toggle()
            errorMessage = "password를 4글자 이상 20글자 이하로 바꿔주세요"
            return
        }
        if password != passwordCheck{
            showAlert.toggle()
            errorMessage = "비밀번호와 비밀번호 확인이 일치하지 않습니다."
            return
        }
    }
}
