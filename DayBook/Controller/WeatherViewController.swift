//
//  WeatherViewController.swift
//  DayBook
//
//  Created by Илья on 6/9/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet private weak var background: UIView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var weekdayLabel: UILabel!
    @IBOutlet private weak var ibImageView: UIImageView!
    @IBOutlet private weak var weatherStateLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private let locationManager = CLLocationManager()
    private var lat = 11.2
    let apiKey = "76a501c8e313f7a700c7fb95cef4a2e0"
    private var lon = 123.7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(String(describing: self.lat))&lon=\(String(describing: self.lon))&appid=\(String(describing: self.apiKey))&units=metric").responseJSON { [weak self] (response) in
            self?.activityIndicator.stopAnimating()
            if let responseStr = response.result.value{
                let jsonResponse = JSON(responseStr)
                let jsonWeather = jsonResponse["weather"].array![0]
                let jsonTemp = jsonResponse["main"]
                let iconName = jsonWeather["icon"].stringValue
                let locationName = jsonResponse["name"].stringValue
                let weatherState = jsonWeather["main"].stringValue
                let temperature = Int(round(jsonTemp["temp"].doubleValue))
                self?.locationLabel.text = locationName
                self?.ibImageView.image = UIImage(named: iconName)
                self?.weatherStateLabel.text = weatherState
                self?.temperatureLabel.text = "\(String(describing: temperature))"
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE"
                self?.weekdayLabel.text = dateFormatter.string(from: date)
                let suffix = iconName.suffix(1)
                if(suffix=="n"){
                    self?.background.backgroundColor = UIColor(red: 86.0/255.0, green: 61.0/255.0, blue: 111.0/255.0, alpha: 1.0)
                }
                else{
                    self?.background.backgroundColor = UIColor(red: 49.0/255.0, green: 146.0/255.0, blue: 165.0/255.0, alpha: 1.0)
                }
            }
        }
    }
}
