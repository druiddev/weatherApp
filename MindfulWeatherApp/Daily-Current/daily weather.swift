//
//  daily weather.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/12/22.
//

import Foundation
import UIKit

class DailyWeather {
    
   //current
    var city: String
    var state: String
    var country: String
    var lat: Double
    var lon: Double
    var currentTemp: Double
    var currentDesc: String
    var currentIcon: String
    var currentWeatherCode: Int
    var currentRainInInches: Double
    var currentHumidity: Int
    
    //daily
    var date: String
    var dailyTemp: Double
    var dailyRainTotal: Double
    var dailySnowTotal: Double
    var dailyHumidity: Double
    var dailyDesc: String
    var dailyIcon: String
    var dailyWeatherCode: Int
    
    //astrology in daily
    var sunrise: String
    var sunset: String
    var moonrise: String
    var moonset: String
    var moonPhase: String

    
    
    //initialzers
    init(city: String, state: String, country: String, lat: Double, lon: Double, currentTemp: Double, currentDesc: String, currentIcon: String, currentWeatherCode: Int, currentRainInInches: Double, currentHumidity: Int, date: String, dailyTemp: Double, dailyRainTotal: Double, dailySnowTotal: Double, dailyHumidity: Double, dailyDesc: String, dailyIcon: String, dailyWeatherCode: Int, sunrise: String, sunset: String, moonrise: String, moonset: String, moonPhase: String) {
        self.city = city
        self.state = state
        self.country = country
        self.lat = lat
        self.lon = lon
        self.currentTemp = currentTemp
        self.currentDesc = currentDesc
        self.currentIcon = currentIcon
        self.currentWeatherCode = currentWeatherCode
        self.currentRainInInches = currentRainInInches
        self.currentHumidity = currentHumidity
        self.date = date
        self.dailyTemp = dailyTemp
        self.dailyRainTotal = dailyRainTotal
        self.dailySnowTotal = dailySnowTotal
        self.dailyHumidity = dailyHumidity
        self.dailyDesc = dailyDesc
        self.dailyIcon = dailyIcon
        self.dailyWeatherCode = dailyWeatherCode
        self.sunrise = sunrise
        self.sunset = sunset
        self.moonrise = moonrise
        self.moonset = moonset
        self.moonPhase = moonPhase
    }
    
    
    var imageProperty: UIImage {
           var imageFromUrl: UIImage! = nil
           let urlString = "http:\(dailyIcon)"
   
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

        var dateString: String {
            return "\(date.dropFirst(5))"
        }
    
        var humidityString: String {
            return "Humidity: \(dailyHumidity)%"
        }
    
        var tempString: String{
            return "\(dailyTemp.description.dropLast(2))°"
        }
    
    
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    var temp : Double
//    var humidity : Int
//    var weatherID : Int
//    var mainDescription : String
//    var description : String
//    var iconID : String
//    var date: String
//    var sunrise: Int
//    var sunset: Int
//
//
//    init(temp: Double, humidity: Int, weatherID: Int, mainDescription: String, description: String, iconID: String, date: String, sunrise: Int, sunset: Int) {
//        self.temp = temp
//        self.humidity = humidity
//        self.weatherID = weatherID
//        self.mainDescription = mainDescription
//        self.description = description
//        self.iconID = iconID
//        self.date = date
//        self.sunrise = sunrise
//        self.sunset = sunset
//    }
//
//    var imageProperty: UIImage {
//        var imageFromUrl: UIImage! = nil
//        let urlString = "http://openweathermap.org/img/wn/\(iconID)@2x.png"
//
//        if urlString.contains("http"),
//           let url = URL(string: urlString),
//           var urlComp = URLComponents(url: url, resolvingAgainstBaseURL: false)
//        {
//            urlComp.scheme = "https"
//
//            if let secureURL = urlComp.url {
//                do {
//                    let imageData = try Data.init(contentsOf: secureURL)
//                    imageFromUrl = UIImage(data: imageData)!
//                } catch { print(error)}
//            }
//        }
//        return imageFromUrl
//
//    }
//
//
//    var weatherDescLabelText: String {
//        return "\(mainDescription): \(description)"
//    }
//
//
//    var dateString: String {
//        return "\(date)"
//    }
//
//    var humidityString: String {
//        return "Humidity: \(humidity)%"
//    }
//
//    var tempString: String{
//        return "\(temp.description.dropLast(3))°"
//    }
//
//}
