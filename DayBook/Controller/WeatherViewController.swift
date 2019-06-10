//
//  WeatherViewController.swift
//  DayBook
//
//  Created by Илья on 6/9/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet private weak var background: UIView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var weekdayLabel: UILabel!
    @IBOutlet private weak var ibActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var ibImageView: UIImageView!
    @IBOutlet private weak var weatherStateLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    private let gradientLayer = CAGradientLayer()
    private let locationManager = CLLocationManager()
    private var lat = 11.2
    let apiKey = "76a501c8e313f7a700c7fb95cef4a2e0"
    private var lon = 123.7
    private var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.layer.addSublayer(gradientLayer)
        ibActivityIndicator.startAnimating()
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
        WeatherManager.instance.getWeatherData(latitude: lat, longitude: lon)
        let weatherData = WeatherManager.instance.weatherData
        locationLabel.text = weatherData.locationName
        ibImageView.image = UIImage(named: weatherData.iconName)
        weatherStateLabel.text = weatherData.weatherState
        temperatureLabel.text = "\(weatherData.temperature)"
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        self.weekdayLabel.text = dateFormatter.string(from: date)
        let suffix = weatherData.iconName.suffix(1)
        if(suffix=="n"){
            self.setGreyGradientBackground()
        }
        else{
            self.setBlueGradientBackground()
        }
        ibActivityIndicator.stopAnimating()
    }
    
    func setBlueGradientBackground(){
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    func setGreyGradientBackground(){
        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
}
