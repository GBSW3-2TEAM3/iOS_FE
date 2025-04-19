//
//  SignUpResponse.swift
//  walkingGO
//
//  Created by 박성민 on 4/16/25.
//

import Foundation

struct SignUpResponse: Codable {
    let username: String?
    let signUp: Bool?
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case username, signUp, message
    }
}
