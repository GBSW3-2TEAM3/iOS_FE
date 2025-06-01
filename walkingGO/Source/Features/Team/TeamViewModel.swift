//
//  TeamViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 5/8/25.
//

import Foundation
import SwiftUI

struct TeamMember : Hashable {
//    let profilImage : Image
    let name : String
    let score : Int
    let color: Color
}

class TeamViewModel: ObservableObject {
    var members: [TeamMember] = [
        TeamMember(name: "김세연", score: 2360, color: .pink),
        TeamMember(name: "박성민", score: 2240, color: .blue),
        TeamMember(name: "장희철", score: 2050, color: .black)
    ]
}
