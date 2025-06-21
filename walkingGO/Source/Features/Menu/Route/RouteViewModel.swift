//
//  RouteViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 6/5/25.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class RouteViewModel: ObservableObject{
    @Published var route: [RouteResponse] = []
    
    func getRoute() {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("토큰이 없습니다")
            return
        }
        
        let url = Config.url

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
        ]
        
        AF.request("\(url)/api/walk-logs/recommended",
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: [RouteResponse].self){ response in
            switch response.result{
            case .success(let value):
                self.route = value
            case .failure(let error):
                print(error)
            }
        }
    }
}
