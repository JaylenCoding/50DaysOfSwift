//
//  ViewController.swift
//  ShowMyLocation
//
//  Created by Minecode on 2017/6/29.
//  Copyright © 2017年 org.minecode. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // Widget
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    // Data
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func showAction(_ sender: Any) {
        // 初始化地图框架
        locationManager = CLLocationManager()
        locationManager.delegate = self
        // 设置精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

// 遵守CLLocationManager协议
extension ViewController {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        self.locationLabel.text = "Error while updating location: " + error.localizedDescription
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 将经纬度转化成地址
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {
        (placemarks, error) -> Void in
            
            if error != nil {
                self.locationLabel.text = "Reverse geocoder failed with error: " + error!.localizedDescription
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                self.displayLocationInfo(pm)
            }
            else {
                self.locationLabel.text = "Error existed in the data received from geocoder"
            }
            
        })
    }
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        guard let containsPlacemark = placemark else {return}
        
        locationManager.stopUpdatingLocation()
        
        let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
        let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
        let adminstrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
        let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
        
        self.locationLabel.text = postalCode! + " " + locality!
        self.locationLabel.text?.append("\n")
        self.locationLabel.text?.append(adminstrativeArea! + ", " + country!)
        
    }
    
}

