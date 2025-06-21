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
    @Published var latestWalkID: Int?
    
    @Published var routeName: String = ""
    @Published var routeDescription: String = ""
    @Published var isShowingModal: Bool = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")!
        return formatter
    }()
    
    var latestWalk: WalkResponse? {
        selectedDay
            .compactMap { $0 }
            .max(by: { (walk1, walk2) in
                guard let date1 = self.dateFormatter.date(from: walk1.createdAt),
                      let date2 = self.dateFormatter.date(from: walk2.createdAt) else {
                    return false
                }
                return date1 < date2
            })
    }
    
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
                self.latestWalkID = self.latestWalk?.id
                if let latestID = self.latestWalkID {
                    print("최신 id\(latestID)")
                } else {
                    print("날짜 데이터가 없습니다.")
                    self.latestWalkID = nil
                }
                print(value)
            case .failure(let error):
                print(error)
                self.latestWalkID = nil
            }
            
        }
    }
    
    func walkLogSave() {
        guard let token = KeychainWrapper.standard.string(forKey: "authorization") else {
            print("토큰이 없습니다")
            return
        }
        
        let url = Config.url
        
        guard let latestID = latestWalkID else {
            print("아이디가 없습니다.")
            return
        }
        
        let parameters : [String: Any] = [
            "routeName": routeName,
            "routeDescription": routeDescription
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "walkLogId": "\(latestID)"
        ]
        
        AF.request("\(url)/api/walk-logs/\(latestID)/publish",
                   method: .patch,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate()
        .response { response in
            switch response.result{
            case .success:
                self.isShowingModal = false
            case .failure:
                print("실패")
            }
        }
    }
}
