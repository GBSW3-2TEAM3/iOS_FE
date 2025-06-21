//
//  RankResponse.swift
//  walkingGO
//
//  Created by 박성민 on 6/4/25.
//

import Foundation

struct RankResponse: Identifiable, Codable{
    let id : Int
    let name : String
    let description : String?
    let memberCount : Int
    let totalDistanceKm : Double
    let rank : Int
    let `public` : Bool
}
