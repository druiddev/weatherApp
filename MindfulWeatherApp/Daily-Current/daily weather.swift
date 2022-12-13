//
//  daily weather.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/12/22.
//

import Foundation
import UIKit

class DailyWeather {
    
    var temp : Double
    var humidity : Int
    var weatherID : Int
    var mainDescription : String
    var description : String
    var iconID : String
    var date: String
    var sunrise: Int
    var sunset: Int
    
    
    init(temp: Double, humidity: Int, weatherID: Int, mainDescription: String, description: String, iconID: String, date: String, sunrise: Int, sunset: Int) {
        self.temp = temp
        self.humidity = humidity
        self.weatherID = weatherID
        self.mainDescription = mainDescription
        self.description = description
        self.iconID = iconID
        self.date = date
        self.sunrise = sunrise
        self.sunset = sunset
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
    
    
    var weatherDescLabelText: String {
        return "\(mainDescription): \(description)"
    }
    
    
    var dateString: String {
        return "\(date)"
    }
    
    var humidityString: String {
        return "Humidity: \(humidity)%"
    }
    
    var tempString: String{
        return "\(temp.description.dropLast(3))°"
    }
    
}
