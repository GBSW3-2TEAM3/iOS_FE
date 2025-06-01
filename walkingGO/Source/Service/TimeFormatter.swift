//
//  TimeFormatter.swift
//  walkingGO
//
//  Created by 박성민 on 5/24/25.
//

import Foundation

struct TimeFormatter {
    static func format(seconds: Int) -> String{
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
