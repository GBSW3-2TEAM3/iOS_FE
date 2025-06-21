//
//  TeamCheckResponse.swift
//  walkingGO
//
//  Created by 박성민 on 6/4/25.
//

import Foundation

struct TeamCheckResponse: Codable, Hashable {
    let id : Int
    let name : String
    let description: String?
    let memberCount: Int
    let `public`: Bool
}
