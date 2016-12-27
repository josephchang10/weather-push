//
//  ViewController.swift
//  WeatherPush
//
//  Created by 张嘉夫 on 16/12/23.
//  Copyright © 2016年 张嘉夫. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else {
            return
        }
        
        AVInstallation.current().setObject(latestLocation.coordinate.latitude, forKey: "latitude")
        AVInstallation.current().setObject(latestLocation.coordinate.longitude, forKey: "longitude")
        AVInstallation.current().saveInBackground { (succeeded, error) in
            if succeeded {
                print("位置更新成功")
            }else {
                print("位置更新失败")
            }
        }
    }
}
