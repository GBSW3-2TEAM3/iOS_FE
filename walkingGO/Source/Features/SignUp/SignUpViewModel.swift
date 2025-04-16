//
//  SignUpViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 3/26/25.
//

import Foundation
import Alamofire

class SignUpViewModel: ObservableObject{
    @Published var signUpData = SignUpModel(id: "", name: "", password: "", passwordCheck: "", email: "")
    @Published var errorMessage: String? = nil
    @Published var successMessage: String? = nil
    @Published var showAlert: Bool = false
    
    func signUp() {
        if !validateId() || !validatePassword() {
            return
        }
        signUpRequest()
    }
    
    func validateId() -> Bool {
        if signUpData.id.count < 4 || signUpData.id.count > 12 {
            showAlert.toggle()
            errorMessage = "id를 4글자 이상 12글자 이하로 바꿔주세요"
            return false
        }
        return true
    }
    
    func validatePassword() -> Bool {
        if signUpData.password.count < 4 || signUpData.password.count > 20 {
            showAlert.toggle()
            errorMessage = "password를 4글자 이상 20글자 이하로 바꿔주세요"
            return false
        }
        if signUpData.password != signUpData.passwordCheck{
            showAlert.toggle()
            errorMessage = "비밀번호와 비밀번호 확인이 일치하지 않습니다."
            return false
        }
        return true
    }
    
    func signUpRequest() {
        print("안에서도 실행 됨")
        let param: [String:Any] = [
            "username":signUpData.id,
            "password":signUpData.password,
            "passwordConfirm":signUpData.passwordCheck
        ]
        AF.request("http://localhost:8080/api/auth/signup",method: .post,parameters: param, encoding: JSONEncoding.default)
            .responseDecodable(of: SignUpResponse.self) { response in
                switch response.result {
                case .success(let signUpResponse):
                    if let signUp = signUpResponse.signUp, signUp == true {
                        self.successMessage = "회원가입 성공!"
                        print("회원가입 성공")
                    } else {
                        self.errorMessage = signUpResponse.message
                        print("회원가입 실패")
                    }
                    self.showAlert.toggle()
                    
                case .failure(let error):
                    print("이건 그냥 실패")
                    self.errorMessage = error.localizedDescription
                    self.showAlert.toggle()
                }
            }
    }
}
