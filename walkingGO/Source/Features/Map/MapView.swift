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
    @EnvironmentObject var pathModel: PathModel
    @State private var showModal = false
    var body: some View {
        ZStack{
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
            if showModal {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                
                modal
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
                        showModal = true
                        //                        pathModel.paths.popLast()
                    }
            }
            .padding(.bottom,20)
            .frame(maxWidth: .infinity)
            .background(.timerBackground)
        }
    }
    
    var modal: some View {
        VStack(spacing: 16) {
            Text("종료하시겠습니까?")
                .font(.headline)
            
            VStack(spacing: 6) {
                Text("걸음 : \(viewModel.stepCount)")
                Text("시간 : \(viewModel.timeString)")
                Text(String(format: "거리 : %.2f km", viewModel.distance / 1000))
                Text("소모된 칼로리 : \(Int(viewModel.caloriesBurned))")
            }
            .font(.body)
            
            Text("*기록은 하루에 1번만 가능합니다*")
                .font(.caption)
                .foregroundColor(.red)
            
            HStack(spacing: 12) {
                Button("저장 및 종료") {
                    viewModel.sendWalkData()
                    pathModel.paths.removeLast()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("저장안함") {
                    pathModel.paths.removeLast()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .padding(.horizontal, 24)
        .shadow(radius: 10)
    }
}

#Preview {
    MapView()
        .environmentObject(PathModel())
}
