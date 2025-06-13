//
//  TeamRecommendViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 6/4/25.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class TeamRecommendViewModel: ObservableObject{
    @Published var team: [Team] = []
    
    private var pathModel: PathModel
    
    enum PathAction{
        case createTeam
        case secretTeam
        case joinTeam
    }
    
    init(pathModel: PathModel){
        self.pathModel = pathModel
        getTeam()
    }
    
    func getTeam() {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("token이 없습니다")
            return
        }
        
        let headers: HTTPHeaders = [
            "authorization": "Bearer \(token)"
        ]
        
        let url = Config.url
        
        AF.request("\(url)/api/groups/public",
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: [Team].self) { response in
            switch response.result{
            case .success(let value):
                self.team = value
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func detailTeamJoin(groupid: Int) {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("token이 없습니다")
            return
        }
        
        let headers: HTTPHeaders = [
            "authorization": "Bearer \(token)"
        ]
        
        let url = Config.url
        
        AF.request("\(url)/api/groups/\(groupid)/details",
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: TeamDetailResponse.self){ response in
            switch response.result{
            case .success(let value):
                self.pathModel.paths.append(.joinTeam(value))
                print("go join Team")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func send(action: PathAction) {
        switch action {
        case .createTeam:
            pathModel.paths.append(.createTeam)
        case .secretTeam:
            pathModel.paths.append(.secretTeam)
        case .joinTeam:
            print("없어용")
        }
    }
}
