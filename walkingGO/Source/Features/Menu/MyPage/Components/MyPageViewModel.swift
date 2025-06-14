//
//  MyPageViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 6/14/25.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class MyPageViewModel: ObservableObject {
    @Published var selectedDay: [WalkResponse?] = []
    
    func getWalkData(date: String ) {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("토큰이 없습니다")
            return
        }
        
        let url = Config.url
        
        let parameters : [String: Any] = [
            "date": date
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request("\(url)/api/walk-logs/date",
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: [WalkResponse].self){ response in
            switch response.result {
            case .success(let value):
                self.selectedDay = value
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
