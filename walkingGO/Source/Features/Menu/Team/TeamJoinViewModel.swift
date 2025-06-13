//
//  TeamJoinViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 6/13/25.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class TeamJoinViewModel: ObservableObject{
    let team: TeamDetailResponse
    
    private var pathModel: PathModel
    
    init(team: TeamDetailResponse, pathModel: PathModel) {
        self.team = team
        self.pathModel = pathModel
    }
    
    func back(){
        pathModel.paths.removeLast()
    }
    
    func joinTeam(){
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("token이 없습니다")
            return
        }
        
        let parameters: [String: Any] = [
            "groupId": team.groupId
        ]
        
        let headers: HTTPHeaders = [
            "authorization": "Bearer \(token)"
        ]
        
        let url = Config.url
        
        AF.request("\(url)/api/groups/\(team.groupId)/join-public",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate()
        .response { response in
            switch response.result{
            case .success:
                print("성공")
                self.back()
            case .failure:
                print("실패")
            }
        }
    }
    
}
