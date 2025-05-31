//
//  MapViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 5/14/25.
//

import Foundation
import CoreLocation
import MapKit
//import HealthKit
import _MapKit_SwiftUI
import CoreMotion

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
    
    func requestPermission() {
//        let stepType = HKObjectType.quantityType(forIdentifier: .stepCount)!
//        healthStore.requestAuthorization(toShare: [stepType], read: [stepType]) { _, _ in }
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
        guard CMPedometer.isStepCountingAvailable() else {
                print("걸음 수 측정 불가")
                return
            }

            stepStartDate = Date()
            
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
