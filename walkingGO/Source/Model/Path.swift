//
//  Path.swift
//  walkingGO
//
//  Created by 박성민 on 3/24/25.
//

import Foundation

class PathModel: ObservableObject {
    @Published var paths: [PathType]
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
