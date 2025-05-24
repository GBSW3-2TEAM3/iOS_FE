//
//  MapViewModel.swift
//  walkingGO
//
//  Created by 박성민 on 5/14/25.
//

import Foundation
import CoreLocation
import MapKit
import _MapKit_SwiftUI

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userPathCoordinates: [CLLocationCoordinate2D] = []
    @Published var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.3346, longitude: -122.0090)
    @Published var timeString: String = "00:00:00"
    
    private let locationManager = CLLocationManager()
    private var timer: Timer?
    private var second: Int = 0
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startTracking() {
        userPathCoordinates.removeAll()
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userPathCoordinates.append(location.coordinate)
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
