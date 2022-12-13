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
    var date: String
    
    init(temp: Double, humidity: Int, minTemp: Double, maxTemp: Double, weatherID: Int, mainDescription: String, description: String, iconID: String, date: String) {
        self.temp = temp
        self.humidity = humidity
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.weatherID = weatherID
        self.mainDescription = mainDescription
        self.description = description
        self.iconID = iconID
        self.date = date
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
    
    var minMaxTemp: String {
        return "Low: \(minTemp) \nHigh: \(maxTemp)"
        
    }
    
    var weatherDescLabelText: String {
        return "\(mainDescription): \(description)"
    }
    
    
    
    var dayOfDate: String {
        //takes away the year and the minutes and seconds
        var newDateString = date.dropFirst(5)
        newDateString = date.dropLast(6)
  
        var noHourString = newDateString.dropLast(2).dropFirst(5)
        
        
        func hourLabelString(string: String)->String{
            let stringHour = String(string.suffix(2))
            switch stringHour {
            case "00":
                return " 12 AM"
            case "01":
                return "1 AM"
            case "02":
                return "2 AM"
            case "03":
                return "3 AM"
            case "04":
                return "4 AM"
            case "05":
                return "5 AM"
            case "06":
                return "6 AM"
            case "07":
                return "7 AM"
            case "08":
                return "8 AM"
            case "09":
                return "9 AM"
            case "10":
                return "10 AM"
            case "11":
                return "11 AM"
            case "12":
                return "12 PM"
            case "13":
                return "1 PM"
            case "14":
                return "2 PM"
            case "15":
                return "3 PM"
            case "16":
                return "4 PM"
            case "17":
                return "5 PM"
            case "18":
                return "6 PM"
            case "19":
                return "7 PM"
            case "20":
                return "8 PM"
            case "21":
                return "9 PM"
            case "22":
                return "10 PM"
            case "23":
                return "11 PM"
            default:
                return ""
            }
        }
        
        
        
        return "\(noHourString) \n\(hourLabelString(string: String(newDateString)))"
    }
    
 
}
