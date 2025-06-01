//
//  WalkResponse.swift
//  walkingGO
//
//  Created by 박성민 on 6/1/25.
//

import Foundation

struct WalkResponse: Codable {
    let id: Int
    let username: String
    let startTime: String
    let endTime: String
    let durationSeconds: Int
    let distanceMeters: Double
    let caloriesBurned: Double
    let routeCoordinatesJson: String
    let createdAt: String
}
