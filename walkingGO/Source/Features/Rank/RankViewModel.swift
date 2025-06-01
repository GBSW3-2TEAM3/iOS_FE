//
//  RankViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 5/7/25.
//

import Foundation

struct Team : Identifiable {
    let id = UUID()
    let name: String
    let rank: Int
    let score: Int
}
class RankViewModel: ObservableObject{
    static let teams = [
        Team(name: "1등팀", rank: 1, score: 6789),
        Team(name: "2등팀", rank: 2, score: 5678),
        Team(name: "3등팀", rank: 3, score: 4567),
        Team(name: "4등팀", rank: 4, score: 3456),
        Team(name: "5등팀", rank: 5, score: 2345)
    ]
    
    let topThreeTeams = Array(teams.prefix(3))
    let remainingTeams = Array(teams.dropFirst(3))
}
