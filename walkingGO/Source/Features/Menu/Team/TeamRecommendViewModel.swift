//
//  TeamRecommendViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 6/4/25.
//

import Foundation

class TeamRecommendViewModel: ObservableObject{
    let team: [Team] = [
        Team(name: "Greenday", memberCount: "2/3", totalKM: 3.5),
        Team(name: "할래말래", memberCount: "2/3", totalKM: 4.2),
        Team(name: "경소고", memberCount: "2/3", totalKM: 2.9),
        Team(name: "이거", memberCount: "2/3", totalKM: 2.1)
    ]
    
    
}
