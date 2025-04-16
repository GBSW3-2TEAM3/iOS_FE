//
//  LoginViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 3/24/25.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class LoginViewModel: ObservableObject {
    @Published var loginData = Login(id: "", password: "")
    @Published var successMessage: String? = nil
    @Published var errorMessage: String? = nil
    @Published var showAlert: Bool = false

    func login() {
        let param : [String:Any] = [
            "username": loginData.id,
            "password": loginData.password
        ]
        
        AF.request("http://localhost:8080/api/auth/login",method:.post,parameters: param,encoding: JSONEncoding.default)
            .responseDecodable(of: LoginResponse.self){ response in
                switch response.result {
                case .success(let loginResponse):
                    if let login = loginResponse.loggedIn, login == true {
                        self.successMessage = "로그인 성공!"
                        KeychainWrapper.standard.set(loginResponse.jwt!, forKey: "authorization")
                        print("로그인 성공!")
                    } else {
                        self.errorMessage = loginResponse.message
                        print("로그인 실패!")
                    }
                    self.showAlert.toggle()
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.showAlert.toggle()
                }
            }
    }
}
