//
//  DetailRouteResponse.swift
//  walkingGO
//
//  Created by 박성민 on 6/21/25.
//

import Foundation

struct DetailRouteResponse: Codable {
    let id: Int
    let username: String
    let routeName: String
    let startTime: String
    let endTime: String
    let durationSeconds: Int
    let distanceMeters: Double
    let steps: Int
    let caloriesBurned: Double
    let routeCoordinatesJson: String
    let createdAt: String
}
