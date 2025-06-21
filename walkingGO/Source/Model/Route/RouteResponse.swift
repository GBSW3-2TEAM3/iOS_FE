//
//  RouteResponse.swift
//  walkingGO
//
//  Created by 박성민 on 6/21/25.
//

import Foundation

struct RouteResponse : Codable, Identifiable {
    let id: Int
    let routeName: String
    let routeDescription: String
    let distanceKm: Double
    let durationSeconds: Int
    let ownerUsername: String
}
