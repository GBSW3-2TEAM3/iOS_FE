//
//  MapView.swift
//  walkingGO
//
//  Created by 박성민 on 5/14/25.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @StateObject var viewModel = MapViewModel()
    
    var body: some View {
        VStack(spacing:0){
            header
            
            Map(position: $cameraPosition) {
                UserAnnotation()
                MapPolyline(coordinates: viewModel.userPathCoordinates)
                    .stroke(.blue, lineWidth: 4)
            }
            .mapControls {
                MapUserLocationButton()
            }
            .onAppear {
                viewModel.requestPermission()
                viewModel.startTracking()
                viewModel.startTimer()
            }
        }
    }
    
    var header: some View {
        VStack{
            HStack{
                AnimatedImage(url:URL(string:"https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/People/Man%20Running.png"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                Text(viewModel.timeString)
                    .font(AppFont.PretendardSemiBold(size: 32))
                    .foregroundStyle(.white)
                Image("stopButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width:40)
                    .onTapGesture {
                        viewModel.stopTracking()
                        viewModel.stopTimer()
                    }
            }
            .padding(.bottom,20)
            .frame(maxWidth: .infinity)
            .background(.timerBackground)
        }
    }
}

#Preview {
    MapView()
}
