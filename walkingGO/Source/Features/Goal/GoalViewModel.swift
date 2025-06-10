//
//  GoalViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 6/10/25.
//

import Foundation
import SwiftKeychainWrapper
import Alamofire

class GoalViewModel: ObservableObject{
    @Published var value: Double = 3.0
    @Published var showAlert: Bool = false
    
    private var userWeight: Double?
    init() {
        self.userWeight = nil
        getUser()
    }
    
    func getUser() {
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
                self.userWeight = value.weightKg
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
        
        let url = Config.url
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        let weight = userWeight ?? 0.0
            
        let parameters: [String: Any] = [
            "weightKg": weight,
            "targetDistanceKm": value
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
