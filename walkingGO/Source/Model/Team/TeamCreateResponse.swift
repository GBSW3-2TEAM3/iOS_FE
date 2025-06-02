//
//  TeamCreateResponse.swift
//  walkingGO
//
//  Created by 박성민 on 5/13/25.
//

import Foundation

struct TeamCreateResponse: Decodable {
    let id : Int
    let name : String
    let description: String?
    let ownerUsername: String
    let isPublic: Bool
    let participationCode:String?
    let memberCount: Int
    let createdAt: String
}
