//
//  UserData.swift
//  walkingGO
//
//  Created by 박성민 on 6/8/25.
//

import Foundation

struct UserData: Codable {
    let id: Int
    let username: String
    let weightKg: Double?
    let targetDistanceKm: Double?
}
