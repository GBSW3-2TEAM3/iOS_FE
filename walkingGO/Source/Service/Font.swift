//
//  Font.swift
//  walkingGO
//
//  Created by 박성민 on 3/24/25.
//

import SwiftUI

struct AppFont {
    
    static func PretendardBold(size: CGFloat) -> Font {
        return .custom("Pretendard-Bold", size: size)
    }
    
    static func PretendardMedium(size: CGFloat) -> Font {
        return .custom("Pretendard-Medium", size: size)
    }
    
    static func PretendardSemiBold(size: CGFloat) -> Font {
        return .custom("Pretendard-SemiBold", size: size)
    }
}

