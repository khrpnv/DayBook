//
//  WeatherManager.swift
//  DayBook
//
//  Created by Илья on 6/10/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherManager{
    public static let instance = WeatherManager()
    private let apiKey = "04aa61fa0261f0f2cf8730f46c9ebe7f"
    private var iconName = ""
    private var locationName = ""
    private var condition = ""
    private var temperature = 0
    public var weatherData = WeatherData()
    private init(){}
    
    public func getWeatherData(latitude lat: Double, longitude lon: Double) {
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric").responseJSON { (response) in
            if let responseStr = response.result.value{
                let jsonResponse = JSON(responseStr)
                let jsonWeather = jsonResponse["weather"].array![0]
                let jsonTemp = jsonResponse["main"]
                self.iconName = jsonWeather["icon"].stringValue
                self.locationName = jsonResponse["name"].stringValue
                self.condition = jsonWeather["main"].stringValue
                self.temperature = Int(round(jsonTemp["temp"].doubleValue))
            }
        }
        weatherData = WeatherData(condition, iconName, locationName, temperature)
    }
}
