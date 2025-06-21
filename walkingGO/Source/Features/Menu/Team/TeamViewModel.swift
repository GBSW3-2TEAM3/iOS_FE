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
    @Published var team: TeamCheckResponse?
    @Published var detailTeam: TeamDetailResponse?
    
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
                self.team = value.first
                self.teamMemberCheck()
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func teamMemberCheck() {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("token이 없습니다")
            return
        }
        
        guard let teamId = team?.id else {
            print("Team ID가 없습니다")
            return
        }
        
        let headers: HTTPHeaders = [
            "authorization": "Bearer \(token)"
        ]
        
        let url = Config.url
        
        AF.request("\(url)/api/groups/\(teamId)/details",
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: TeamDetailResponse.self){ response in
            switch response.result {
            case .success(let value):
                self.detailTeam = value
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
