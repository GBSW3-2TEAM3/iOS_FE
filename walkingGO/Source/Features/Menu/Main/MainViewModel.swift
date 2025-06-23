//
//  MainViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 6/23/25.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class MainViewModel: ObservableObject {
    @Published var myTeamId: Int = 0
    @Published var teams: [RankResponse] = []
    @Published var topThreeTeams: [RankResponse] = []
    @Published var myRank: Int? = nil
    
    func fetchData() {
        myTeamRank { [weak self] in
            self?.getRanks()
        }
    }
    
    func myTeamRank(completion: @escaping () -> Void) {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("토큰이 없습니다.")
            completion()
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        let url = Config.url
        
        AF.request("\(url)/api/users/me/groups",
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: [Team].self) { response in
            switch response.result {
            case .success(let teams):
                if let firstTeam = teams.first {
                    self.myTeamId = firstTeam.id
                } else {
                    self.myTeamId = 0
                }
                completion()
            case .failure(let error):
                completion()
            }
        }
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
        .responseDecodable(of: [RankResponse].self) { response in
            switch response.result {
            case .success(let value):
                self.teams = value
                self.topThreeTeams = Array(value.prefix(3))
                self.updateMyRank()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateMyRank() {
        if let myTeam = teams.first(where: { $0.id == self.myTeamId }) {
            self.myRank = myTeam.rank
        } else {
            self.myRank = nil
        }
    }
}
