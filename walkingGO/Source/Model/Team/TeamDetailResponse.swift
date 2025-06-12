//
//  TeamDetailResponse.swift
//  walkingGO
//
//  Created by 박성민 on 6/12/25.
//

import Foundation

struct TeamDetailResponse: Codable , Hashable {
    let groupId : Int
    let groupName : String
    let description : String?
    let currentUserId : Int
    let participationCode : Int?
    let members: [TeamMember]
    let owner: Bool
}

struct TeamMember: Codable , Hashable{
    let userId: Int
    let username: String
    let totalDistanceKm: Double
    let owner: Bool
}
