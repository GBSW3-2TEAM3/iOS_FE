//
//  RouteDetailViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 6/21/25.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class RouteDetailViewModel : ObservableObject {
    @Published var walkData: DetailRouteResponse?
    
    private var routeId: Int
    
    init(routeId: Int) {
        self.routeId = routeId
        getData()
    }
    
    func getData() {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("토큰이 없습니다")
            return
        }
        
        let url = Config.url

        let parameters : [String: Any] = [
            "walkLogId": routeId,
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
        ]
        
        AF.request("\(url)/api/walk-logs/\(routeId)/details",
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: DetailRouteResponse.self){ response in
            switch response.result{
            case .success(let value):
                self.walkData = value
            case .failure(let error):
                print(error)
            }
        }
    }
}
