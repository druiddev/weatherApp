//
//  Zip.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/13/22.
//

import Foundation

class Zip{
    

    var zip: String
    var name: String
    var lat: Double
    var lon: Double
    var country: String
    
    
    init(zip: String, name: String, lat: Double, lon: Double, country: String) {
        self.zip = zip
        self.name = name
        self.lat = lat
        self.lon = lon
        self.country = country
    }
    
    
    
}
