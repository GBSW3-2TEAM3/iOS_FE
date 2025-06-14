//
//  RecordBox.swift
//  walkingGO
//
//  Created by 박성민 on 4/10/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecordBox: View {
    var image = imageURL.runManIcon
    var title = "걸음"
    var data = "2056"
    var body: some View {
        HStack{
            Spacer()
                .frame(width:10)
            AnimatedImage(url:URL(string:image))
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            VStack(alignment:.leading){
                Text(title)
                    .font(AppFont.PretendardSemiBold(size: 14))
                    .foregroundStyle(.socialLoginText)
                Text(data)
                    .font(AppFont.PretendardSemiBold(size: 16))
            }
            Spacer()
                .frame(width: 40)
        }
        .frame(width: 170,height: 80)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    RecordBox()
}
