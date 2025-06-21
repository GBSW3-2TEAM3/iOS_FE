//
//  MyPageView.swift
//  walkingGO
//
//  Created by 박성민 on 4/8/25.

import SwiftUI
import MapKit

struct MyPageView: View {
    @StateObject var viewModel = MyPageViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack {
                Spacer()
                    .frame(height: 50)
                Color.textFieldBackground
            }
            
            VStack {
                MyPageViewHeader()
                ScrollView{
                    MyRecord(viewModel: viewModel)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    MyPageRouteView(viewModel: viewModel)
                    
                    CalendarView(viewModel: viewModel)
                        .padding()
                    
                    Spacer()
                }
            }
            
            if viewModel.isShowingModal {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    Spacer()
                    Text("경로 공유하기")
                        .font(.headline)
                    
                    TextField("경로 이름", text: $viewModel.routeName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    TextField("경로 설명", text: $viewModel.routeDescription)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    HStack {
                        Button("취소") {
                            viewModel.isShowingModal = false
                        }
                        .foregroundColor(.red)
                        
                        Spacer()
                        
                        Button("저장") {
                            viewModel.walkLogSave()
                        }
                        .foregroundColor(.blue)
                    }
                }
                .padding()
                .frame(width: 300)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
            }

        }
    }
}

fileprivate struct MyPageViewHeader: View {
    var body: some View{
        VStack{
            HStack{
                Spacer()
                Image(systemName: "bell.fill")
                    .foregroundStyle(.white)
                    .scaledToFit()
                    .frame(width: 30)
                    .overlay(
                        Circle()
                            .fill(Color.red)
                            .frame(width: 6, height: 6)
                            .offset(x: -6, y: 2), alignment: .topTrailing
                    )
                Spacer()
                    .frame(width: 20)
            }
            .frame(height: 50)
            .background(.customBlue)
        }
    }
}

fileprivate struct MyRecord: View {
    @ObservedObject var viewModel: MyPageViewModel
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")!
        return formatter
    }()
    
    private func formatDuration(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, secs)
    }
    
    //MARK: - 현재 걸음수가 불러와지지 않아서
    private func estimateSteps(_ distanceMeters: Double) -> String {
        let steps = Int(distanceMeters / 0.7)
        return "\(steps)"
    }
    
    private func formatDistance(_ meters: Double) -> String {
        let km = meters / 1000
        return String(format: "%.2f", km)
    }
    
    private func formatCalories(_ calories: Double) -> String {
        return String(format: "%.0f", calories)
    }
    
    private var latestWalk: WalkResponse? {
        viewModel.selectedDay
            .compactMap { $0 }
            .max(by: { (walk1, walk2) in
                guard let date1 = dateFormatter.date(from: walk1.createdAt),
                      let date2 = dateFormatter.date(from: walk2.createdAt) else {
                    return false
                }
                return date1 < date2
            })
    }
    
    var body: some View{
        VStack{
            Spacer()
                .frame(height: 20)
            HStack{
                Spacer()
                    .frame(width:20)
                Text("내 활동 기록")
                    .font(AppFont.PretendardSemiBold(size: 14))
                Spacer()
            }
            Spacer()
                .frame(height: 20)
            HStack{
                //MARK: - 걸음
                RecordBox(
                    image: imageURL.footprint,
                    title: "걸음",
                    data: latestWalk != nil ? estimateSteps(latestWalk!.distanceMeters) : "0"
                )
                Spacer()
                    .frame(width: 10)
                //MARK: - 시간
                RecordBox(
                    image: imageURL.clock,
                    title: "시간",
                    data: latestWalk != nil ? formatDuration(latestWalk!.durationSeconds) : "00:00:00"
                )
            }
            HStack{
                //MARK: - 거리
                RecordBox(
                    image: imageURL.fire,
                    title: "거리(km)",
                    data: latestWalk != nil ? formatDistance(latestWalk!.distanceMeters) : "0.00"
                )
                Spacer()
                    .frame(width: 10)
                //MARK: - 칼로리
                RecordBox(
                    image: imageURL.fire,
                    title: "칼로리(kcal)",
                    data: latestWalk != nil ? formatCalories(latestWalk!.caloriesBurned) : "0"
                )
            }
        }
    }
}

fileprivate struct MyPageRouteView : View {
    @ObservedObject var viewModel: MyPageViewModel
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")!
        return formatter
    }()
    
    private var latestWalk: WalkResponse? {
        viewModel.selectedDay
            .compactMap { $0 }
            .max(by: { (walk1, walk2) in
                guard let date1 = dateFormatter.date(from: walk1.createdAt),
                      let date2 = dateFormatter.date(from: walk2.createdAt) else {
                    return false
                }
                return date1 < date2
            })
    }
    
    private var routeCoordinates: [CLLocationCoordinate2D] {
        guard let walk = latestWalk else { return [] }
        do {
            let data = walk.routeCoordinatesJson.data(using: .utf8)!
            let coordinates = try JSONDecoder().decode([Coordinate].self, from: data)
            return coordinates.map { CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lng) }
        } catch {
            print("Failed to parse routeCoordinatesJson: \(error)")
            return []
        }
    }
    
    private var cameraPosition: MapCameraPosition {
        if let firstCoordinate = routeCoordinates.first {
            return .camera(MapCamera(
                centerCoordinate: firstCoordinate,
                distance: 500,
                heading: 0,
                pitch: 0
            ))
        }
        return .automatic
    }
    var body: some View{
        ZStack{
            VStack(spacing:0){
                //MARK: - 지도 뷰
                if routeCoordinates.isEmpty {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 350, height: 300)
                        .cornerRadius(5)
                    Text("경로가 저장되지 않았습니다")
                        .foregroundStyle(.white)
                        .font(AppFont.PretendardMedium(size: 16))
                } else {
                    Map(position: .constant(cameraPosition)) {
                        MapPolyline(coordinates: routeCoordinates)
                            .stroke(.blue, lineWidth: 5)
                    }
                    .frame(width: 350, height: 300)
                    .cornerRadius(5)
                    .mapStyle(.standard)
                    .padding(.all)
                    .clipped()
                }
                if viewModel.latestWalkID != nil{
                    HStack{
                        Spacer()
                            .frame(width: 270)
                        Button{
                            viewModel.isShowingModal.toggle()
                        }label: {
                            Text("경로 공유하기")
                                .frame(width: 80,height: 28)
                                .foregroundStyle(.white)
                                .background(.customBlue)
                                .font(AppFont.PretendardSemiBold(size: 10))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MyPageView()
}
