//
//  Weather.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/2/22.
//

import Foundation
import UIKit

class WeatherInfo {
    
    var temp : Double
    var humidity : Double
    var minTemp : Double
    var maxTemp : Double
    var weatherID : Int
    var mainDescription : String
    var description : String
    var iconID : String
    
    init(temp: Double, humidity: Double, minTemp: Double, maxTemp: Double, weatherID: Int, mainDescription: String, description: String, iconID: String) {
        self.temp = temp
        self.humidity = humidity
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.weatherID = weatherID
        self.mainDescription = mainDescription
        self.description = description
        self.iconID = iconID
    }
    
    
}
