//
//  Astrology.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/15/22.
//

import Foundation
import UIKit

class Astrology{
    
    var sunrise: String
    var sunset : String
    var moonrise : String
    var moonset : String
    var moonPhase : String
    var lat: Double
    var lon: Double
    
    init(sunrise: String, sunset: String, moonrise: String, moonset: String, moonPhase: String, lat: Double, lon: Double) {
        self.sunrise = sunrise
        self.sunset = sunset
        self.moonrise = moonrise
        self.moonset = moonset
        self.moonPhase = moonPhase
        self.lat = lat
        self.lon = lon
    }
    
    
    var imageBasedOnMoonphase: UIImage {
        var moonImage = UIImage(named: "full")
        
        switch moonPhase{
            case "New Moon":
            moonImage = UIImage(named: "newMoon")
            case "Waxing Crescent":
            moonImage = UIImage(named: "waxcres")
            case "First Quarter":
            moonImage = UIImage(named: "firstquarter")
            case "Waxing Gibbous":
            moonImage = UIImage(named: "waxgib")
            case "Full Moon":
            moonImage = UIImage(named: "full")
            case "Waning Gibbous":
            moonImage = UIImage(named: "wangib")
            case "Last Quarter":
            moonImage = UIImage(named: "lastquarter")
            case "Waning Crescent":
            moonImage = UIImage(named: "wancres")
        default:
            moonImage = UIImage(named: "full")
        }
        return moonImage!
    }
    
    
    
    var sunriseString: String{
        return "Sunrise: \(sunrise)"
    }
    
    var sunsetString: String{
        return "Sunset: \(sunset)"
    }
    
    var moonriseString: String{
        return "Moonrise: \(moonrise)"
    }
    
    var moonsetString: String{
        return "Moonset: \(moonset)"
    }
    
    
    
}
