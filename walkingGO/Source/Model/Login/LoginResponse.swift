//
//  LoginResponse.swift
//  walkingGO
//
//  Created by 박성민 on 4/16/25.
//

import Foundation

struct LoginResponse: Codable {
    let jwt: String?
    let username: String?
    let message: String
    let loggedIn: Bool?
}
