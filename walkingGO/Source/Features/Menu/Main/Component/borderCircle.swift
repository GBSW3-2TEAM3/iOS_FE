//
//  borderCircle.swift
//  walkingGO
//
//  Created by 박성민 on 4/3/25.
//

import SwiftUI

struct borderCircle: View {
    var body: some View {
        Circle()
            .foregroundStyle(.white)
            .frame(width:30)
            .overlay(
                Circle()
                    .stroke(.topBarGray, lineWidth: 13)
                    .cornerRadius(15)
            )
    }
}

#Preview {
    borderCircle()
}
