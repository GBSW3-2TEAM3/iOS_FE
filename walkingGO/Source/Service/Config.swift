//
//  Config.swift
//  walkingGO
//
//  Created by 박성민 on 4/17/25.
//

import Foundation

enum Config {
    static var url: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "URL") as? String else {
            fatalError("❌ API_URL is missing in Info.plist")
        }
        return url
    }
}
