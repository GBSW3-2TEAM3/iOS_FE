//
//  Team.swift
//  walkingGO
//
//  Created by 박성민 on 6/4/25.
//

import Foundation

struct Team: Codable, Identifiable, Hashable{
    let id : Int
    let name : String
    let description: String
    let memberCount: Int
    let `public` : Bool
}
