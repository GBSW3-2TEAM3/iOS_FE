//
//  PathType.swift
//  walkingGO
//
//  Created by 박성민 on 3/24/25.
//

import Foundation

enum PathType: Hashable {
    case login
    case signUp
    case menu
    case createTeam
    case map
    case goal
    case secretTeam
    case editProfil
    case detailTeam(TeamDetailResponse)
    case joinTeam(TeamDetailResponse)
    case detailRoute(Int)
}
