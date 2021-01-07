//
//  LocationViewModel.swift
//  LocationPermission
//
//  Created by Simec Sys Ltd. on 7/1/21.
//
import Foundation
import SwiftUI
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locationManager = CLLocationManager()
    @Published var userLocation: CLLocation!
    @Published var userAddress: String = ""
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Authorized")
            manager.requestLocation()
        case .denied:
            print("Denied")
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        translateLocationIntoAddress()
    }
    func translateLocationIntoAddress() {
        CLGeocoder().reverseGeocodeLocation(userLocation) { (resp, error) in
            guard let data = resp else { return }
            var address = ""
            address += data.first?.locality ?? ""
            address += ", "
            address += data.first?.country ?? ""
            
            self.userAddress = address
        }
    }
}


