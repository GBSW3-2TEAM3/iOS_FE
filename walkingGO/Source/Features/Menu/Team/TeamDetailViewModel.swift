//
//  TeamDetailViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 6/12/25.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class TeamDetailViewModel: ObservableObject{
    @Published var team: TeamDetailResponse
    
    private var pathModel: PathModel
    
    init(team: TeamDetailResponse, pathModel: PathModel) {
        self.team = team
        self.pathModel = pathModel
    }
    
    func deleteTeam() {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("token이 없습니다")
            return
        }
        
        let headers: HTTPHeaders = [
            "authorization": "Bearer \(token)"
        ]
        
        let url = Config.url
        
        AF.request("\(url)/api/groups/\(team.groupId)",
                   method: .delete,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate()
        .response{ response in
            switch response.result{
            case .success(let value):
                print(value)
                self.back()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func leaveTeam() {
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
        
        AF.request("\(url)/api/groups/\(team.groupId)/leave",
                   method: .delete,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate()
        .response { response in
            switch response.result {
            case .success:
                print("삭제 성공")
                self.back()
            case .failure:
                print("삭제 실패")
            }
        }
    }
    
    func back() {
        pathModel.paths.removeLast()
    }
}
