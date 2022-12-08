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
    var humidity : Int
    var minTemp : Double
    var maxTemp : Double
    var weatherID : Int
    var mainDescription : String
    var description : String
    var iconID : String
    
    init(temp: Double, humidity: Int, minTemp: Double, maxTemp: Double, weatherID: Int, mainDescription: String, description: String, iconID: String) {
        self.temp = temp
        self.humidity = humidity
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.weatherID = weatherID
        self.mainDescription = mainDescription
        self.description = description
        self.iconID = iconID
    }
    
    
    var imageProperty: UIImage {
        var imageFromUrl: UIImage! = nil
        let urlString = "http://openweathermap.org/img/wn/\(iconID)@2x.png"
        
        if urlString.contains("http"),
           let url = URL(string: urlString),
           var urlComp = URLComponents(url: url, resolvingAgainstBaseURL: false)
        {
            urlComp.scheme = "https"
            
            if let secureURL = urlComp.url {
                do {
                    let imageData = try Data.init(contentsOf: secureURL)
                    imageFromUrl = UIImage(data: imageData)!
                } catch { print(error)}
            }
        }
        return imageFromUrl
        
    }
    
    
    
}
