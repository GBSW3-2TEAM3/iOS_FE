//
//  RankViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 5/7/25.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class RankViewModel: ObservableObject{
    @Published var teams: [RankResponse] = []
    
    var topThreeTeams: [RankResponse] {
        Array(teams.prefix(3))
    }
    
    var remainingTeams: [RankResponse]{
        Array(teams.dropFirst(3))
    }
    
    
    func getRanks() {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("토큰이 없습니다.")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        let url = Config.url
        
        AF.request("\(url)/api/groups/ranked-by-distance",
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers
        )
        .validate()
        .responseDecodable(of: [RankResponse].self){ response in
            switch response.result{
            case .success(let value):
                print(value)
                self.teams = value
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
