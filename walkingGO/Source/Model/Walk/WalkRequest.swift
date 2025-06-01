//
//  WalkRequest.swift
//  walkingGO
//
//  Created by 박성민 on 6/1/25.
//

import Foundation

struct Coordinate: Codable {
    let lat: Double
    let lng: Double
}

struct WalkRequest: Codable {
    let startTime : String
    let endTime : String
    let durationSeconds : Int
    let distanceMeters : Double
    let caloriesBurned : Double
    let routeCoordinatesJson : String
}
