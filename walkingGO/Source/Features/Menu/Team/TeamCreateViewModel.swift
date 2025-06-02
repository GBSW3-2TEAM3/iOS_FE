//
//  TeamCreateViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 5/13/25.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class TeamCreateViewModel: ObservableObject{
    @Published var title: String = ""
    @Published var isPublic: Bool! = nil
    @Published var description: String = ""
    @Published var password: String = ""
    
    func teamCreate() {
        let url = Config.url
        guard let accessToken = KeychainWrapper.standard.string(forKey: "authorization") else{
            print("액세스 토큰이 없음")
            return
        }
        
        var parameter : [String:Any] = [
            "name": title,
            "isPublic": isPublic!
        ]
        
        if isPublic {
            parameter["description"] = description
        } else {
            parameter["participationCode"] = password
        }
        
        let headers: HTTPHeaders = [
            "authorization" : "Bearer \(accessToken)"
        ]
        
        AF.request("\(url)/api/groups",
                   method: .post,
                   parameters: parameter,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .responseDecodable(of: TeamCreateResponse.self) { response in
            switch response.result {
            case .success(let teamResponse):
                print(teamResponse)
            case .failure(let error):
                print(error.localizedDescription)
                print("에러가 발생했슴니다.")
            }
        }
    }
}
