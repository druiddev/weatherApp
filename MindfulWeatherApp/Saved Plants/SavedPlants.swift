//
//  SavedPlants.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/17/22.
//

import Foundation
import UIKit

class SavedPlants{
    
    
    var plantImage: UIImage
    var locationImage: UIImage
    var dateSaved: Date
    
  
    
    init(plantImage: UIImage, locationImage: UIImage, dateSaved: Date) {
        self.plantImage = plantImage
        self.locationImage = locationImage
        self.dateSaved = dateSaved
    }
    
  
    
    var dateString: String{
        
        //put date formatter here
        return "\(dateSaved)"
        
    }
    
  
    
    
    
    
}
