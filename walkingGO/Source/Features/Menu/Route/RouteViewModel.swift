//
//  RouteViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 6/5/25.
//

import Foundation

struct shareRoute : Codable, Identifiable {
    var id = UUID()
    let name: String
    let km: Double
    let time: String
}

class RouteViewModel: ObservableObject{
    let route: [shareRoute] = [
        shareRoute(name: "박성민", km: 2.3, time: "1.00.45"),
        shareRoute(name: "할래말래", km: 4.2, time: "1.00.23"),
        shareRoute(name: "ㅁㄴㅇㅁㄴㅇ", km: 6.3, time: "2.12.45"),
        shareRoute(name: "1시간코스", km: 2.6, time: "0.50.23"),
        shareRoute(name: "아 힘들다", km: 3.8, time: "0.23.41")
    ]
}
