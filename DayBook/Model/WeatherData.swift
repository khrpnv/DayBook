//
//  WeatherData.swift
//  DayBook
//
//  Created by Илья on 6/10/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

struct WeatherData{
    let weatherState: String
    let iconName: String
    let locationName: String
    let temperature: Int
    
    init(_ weatherState: String, _ iconName: String, _ locationName: String, _ temperature: Int) {
        self.iconName = iconName
        self.locationName = locationName
        self.temperature = temperature
        self.weatherState = weatherState
    }
    
    init() {
        weatherState = "Sunny"
        locationName = "Kharkiv"
        temperature = 23
        iconName = "01d"
    }
}
