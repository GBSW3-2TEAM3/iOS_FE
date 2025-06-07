//
//  TeamViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 5/8/25.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftKeychainWrapper


class TeamViewModel: ObservableObject {
    var members: [TeamMember] = [
        TeamMember(name: "김세연", score: 2360, color: .pink),
        TeamMember(name: "박성민", score: 2240, color: .blue),
        TeamMember(name: "장희철", score: 2050, color: .black)
    ]
    
    func hasTeamCheck() {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("token이 없습니다")
            return
        }
        
        let headers: HTTPHeaders = [
            "authorization": "Bearer \(token)"
        ]
        
        let url = Config.url
        
        AF.request("\(url)/api/users/me/groups",
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: [TeamCheckResponse].self){ response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
