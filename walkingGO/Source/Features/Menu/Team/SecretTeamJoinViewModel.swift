//
//  SecretTeamJoinViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 6/13/25.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class SecretTeamJoinViewModel: ObservableObject{
    @Published var teamCode: String = ""
    
    private var pathModel: PathModel
    
    init(pathModel: PathModel) {
        self.pathModel = pathModel
    }
    
    func secretTeamJoin() {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("token이 없습니다")
            return
        }
        
        let parameters: [String: Any] = [
            "participationCode": teamCode
        ]
        
        let headers: HTTPHeaders = [
            "authorization": "Bearer \(token)"
        ]
        
        let url = Config.url
        
        AF.request("\(url)/api/groups/join",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate()
        .response{ response in
            switch response.result{
            case .success:
                print("참가 성공")
                self.back()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func back() {
        pathModel.paths.removeLast()
    }
}
