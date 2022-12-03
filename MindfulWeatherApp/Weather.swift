//
//  Weather.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/2/22.
//

import Foundation
import UIKit

class WeatherInfo {
    
    var unit : String
    var city : String
    var state : String
    var lat : String
    var lon : String
    var timeZone : String
    var temperature : Int
    var weatherCode : Int
    var iconString : [String]
    var description : [String]
    
    
    init(unit: String, city: String, state: String, lat: String, lon: String, timeZone: String, temperature: Int, weatherCode: Int, iconString: [String], description: [String]) {
        self.unit = unit
        self.city = city
        self.state = state
        self.lat = lat
        self.lon = lon
        self.timeZone = timeZone
        self.temperature = temperature
        self.weatherCode = weatherCode
        self.iconString = iconString
        self.description = description
    }
    
    
    
    
    var imageProperty: UIImage {
        var imageFromUrl: UIImage! = nil
        
        for string in iconString{
            
            let urlString = string
            
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
        }
        return imageFromUrl
        
    }
    
    
}
