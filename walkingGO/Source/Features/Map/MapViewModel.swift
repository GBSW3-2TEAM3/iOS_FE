//
//  MapViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 5/14/25.
//

import Foundation
import CoreLocation
import MapKit
import Alamofire
import _MapKit_SwiftUI
import CoreMotion
import SwiftKeychainWrapper

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userPathCoordinates: [CLLocationCoordinate2D] = []
    @Published var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.3346, longitude: -122.0090)
    @Published var timeString: String = "00:00:00"
    @Published var distance: Double = 0.0
    @Published var stepCount: Int = 0
    @Published var caloriesBurned: Double = 0.0
    
    private let locationManager = CLLocationManager()
    private let pedometer = CMPedometer()
    //    private let healthStore = HKHealthStore()
    private var lastLocation: CLLocation?
    private var stepStartDate: Date?
    private var timer: Timer?
    private var second: Int = 0
    private var userWeight: Double = 65.0
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func sendWalkData() {
        guard let startDate = stepStartDate else {
            print("시작 시간이 없습니다.")
            return
        }
        
        let dateFormatter = ISO8601DateFormatter()
        let startTime = dateFormatter.string(from: startDate)
        let endTime = dateFormatter.string(from: Date())
        
        let coordinates = userPathCoordinates.map { ["lat": $0.latitude, "lng": $0.longitude] }
        
        do {
            let coordinatesData = try JSONSerialization.data(withJSONObject: coordinates, options: [.prettyPrinted])
            guard let coordinatesJson = String(data: coordinatesData, encoding: .utf8) else {
                print("오류: 좌표 데이터를 문자열로 변환하지 못했습니다.")
                return
            }
            
            let walkRequest = WalkRequest(
                startTime: startTime,
                endTime: endTime,
                durationSeconds: second,
                distanceMeters: distance,
                steps: stepCount,
                caloriesBurned: caloriesBurned,
                routeCoordinatesJson: coordinatesJson
            )
        
            guard let accessToken = KeychainWrapper.standard.string(forKey: "authorization") else {
                print("오류: 액세스 토큰이 없습니다.")
                return
            }
            
            let headers: HTTPHeaders = [
                "authorization": "Bearer \(accessToken)",
            ]
            let url = Config.url
            
            AF.request("\(url)/api/walk-logs",
                       method: .post,
                       parameters: walkRequest,
                       encoder: JSONParameterEncoder.default,
                       headers: headers)
            .validate()
            .responseDecodable(of: WalkResponse.self) { response in
                switch response.result {
                case .success(let walkResponse):
                    print("데이터 전송 성공: \(walkResponse)")
                    
                case .failure(let error):
                    print("데이터 전송 실패: \(error.localizedDescription)")
                    if let data = response.data {
                        do {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            print("서버 에러 응답: \(errorResponse)")
                        } catch {
                            print("에러 응답 파싱 실패: \(error.localizedDescription)")
                        }
                    }
                }
            }
        } catch {
            print("오류: 좌표 JSON 직렬화 실패 - \(error.localizedDescription)")
            return
        }
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startTracking() {
        userPathCoordinates.removeAll()
        startStepCount()
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() {
        locationManager.stopUpdatingLocation()
        stopStepCount()
        print(stepCount)
        print(userPathCoordinates)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        userPathCoordinates.append(newLocation.coordinate)
        userLocation = newLocation.coordinate
        
        if let last = lastLocation {
            let distanceDelta = newLocation.distance(from: last)
            distance += distanceDelta
            
            let distanceInKM = distance / 1000
            caloriesBurned = distanceInKM * userWeight * 1.036
        }
        lastLocation = newLocation
        
        print(distance)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}

//MARK: - Tiemr로직
extension MapViewModel{
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.second += 1
            self.updateTimeString()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateTimeString() {
        timeString = TimeFormatter.format(seconds: self.second)
    }
}

//MARK: - 걸음수 로직
extension MapViewModel{
    
    func startStepCount(){
        stepStartDate = Date()
        
        guard CMPedometer.isStepCountingAvailable() else {
            print("걸음 수 측정 불가")
            return
        }
        
        pedometer.startUpdates(from: stepStartDate!) { [weak self] data, error in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                print("걸음 수 측정 오류: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                self.stepCount = data.numberOfSteps.intValue
            }
        }
    }
    
    func stopStepCount(){
        pedometer.stopUpdates()
    }
}
