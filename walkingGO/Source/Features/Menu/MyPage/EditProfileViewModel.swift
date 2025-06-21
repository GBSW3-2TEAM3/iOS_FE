//
//  EditProfileViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 6/7/25.
//

import Foundation
import SwiftKeychainWrapper
import Alamofire

class EditProfileViewModel: ObservableObject{
    @Published var userWeight: String = ""
    @Published var showAlert: Bool = false
    
    private var targetDistanceKm: Double?
    
    
    init() {
        self.targetDistanceKm = nil
        getuser()
    }
    
    func getuser() {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("토큰이 없습니다")
            return
        }
        
        let url = Config.url
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request("\(url)/api/users/me",
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: UserData.self){ response in
            switch response.result {
            case .success(let value):
                self.targetDistanceKm = value.targetDistanceKm
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func changeUser() {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("토큰이 없습니다.")
            return
        }
        
        guard let weight = Double(userWeight), weight > 0 else {
            print("weight가 실수가 아닙니다.")
            return
        }
        
        let url = Config.url
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        let targetDistance = targetDistanceKm ?? 0.0
            
        let parameters: [String: Any] = [
            "weightKg": userWeight,
            "targetDistanceKm": targetDistance
        ]
        
        AF.request("\(url)/api/users/me/profile",
                   method: .put,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: UserData.self){ response in
            switch response.result{
            case .success(let value):
                print(value)
                self.showAlert = true
            case .failure(let error):
                print(error)
            }
        }
    }
}
