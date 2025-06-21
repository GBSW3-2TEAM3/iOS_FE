//
//  RouteDetailView.swift
//  walkingGO
//
//  Created by 박성민 on 6/21/25.
//

import SwiftUI
import MapKit

struct RouteDetailView: View {
    @StateObject var viewModel: RouteDetailViewModel
    var body: some View {
        VStack{
            RouteDetailViewHeader()
            ScrollView{
                MyRecord(viewModel: viewModel)
                
                Spacer()
                    .frame(height: 30)
                
                MapRouteDetailView(viewModel: viewModel)
                
                Spacer()
            }
        }
    }
}

fileprivate struct RouteDetailViewHeader: View {
    var body: some View{
        VStack{
            Rectangle()
                .frame(height: 50)
                .foregroundStyle(.customBlue)
                .background(.customBlue)
        }
    }
}

fileprivate struct MyRecord: View {
    @ObservedObject var viewModel: RouteDetailViewModel
    
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
    
    private func formatDistance(_ meters: Double) -> String {
        let km = meters / 1000
        return String(format: "%.2f", km)
    }
    
    private func formatCalories(_ calories: Double) -> String {
        return String(format: "%.0f", calories)
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            HStack {
                Spacer()
                    .frame(width: 20)
                Text("내 활동 기록")
                    .font(AppFont.PretendardSemiBold(size: 14))
                Spacer()
            }
            Spacer()
                .frame(height: 20)
            if let walk = viewModel.walkData {
                HStack {
                    // 걸음
                    RecordBox(
                        image: imageURL.footprint,
                        title: "걸음",
                        data: "\(walk.steps)"
                    )
                    Spacer()
                        .frame(width: 10)
                    // 시간
                    RecordBox(
                        image: imageURL.clock,
                        title: "시간",
                        data: formatDuration(walk.durationSeconds)
                    )
                }
                HStack {
                    // 거리
                    RecordBox(
                        image: imageURL.fire,
                        title: "거리(km)",
                        data: formatDistance(walk.distanceMeters)
                    )
                    Spacer()
                        .frame(width: 10)
                    // 칼로리
                    RecordBox(
                        image: imageURL.fire,
                        title: "칼로리(kcal)",
                        data: formatCalories(walk.caloriesBurned)
                    )
                }
            } else {
                Text("데이터 로딩 중...")
                    .font(AppFont.PretendardMedium(size: 14))
            }
        }
    }
}

fileprivate struct MapRouteDetailView: View {
    @ObservedObject var viewModel: RouteDetailViewModel
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")!
        return formatter
    }()
    
    private var routeCoordinates: [CLLocationCoordinate2D] {
        guard let walk = viewModel.walkData else { return [] }
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
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
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
            }
        }
    }
}

#Preview {
    RouteDetailView(viewModel: RouteDetailViewModel(routeId: 3))
}
