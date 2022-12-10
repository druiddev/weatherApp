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
        return "\(minTemp)/\(maxTemp)"
        
    }
    
    var dayOfDate: String {
        
        func getDayOfWeek(_ today:String) -> Int? {
            let formatter  = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            guard let todayDate = formatter.date(from: today) else { return nil }
            let myCalendar = Calendar(identifier: .gregorian)
            let weekDay = myCalendar.component(.weekday, from: todayDate)
            return weekDay
        }
        
        
        let weekday = getDayOfWeek(date)
        return "\(weekday)"
        
        
    }
}
