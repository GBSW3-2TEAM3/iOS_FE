//
//  Team.swift
//  walkingGO
//
//  Created by 박성민 on 6/4/25.
//

import Foundation

struct Team: Codable, Identifiable{
    var id = UUID()
    let name : String
    let memberCount: String
    let totalKM: Double
}
