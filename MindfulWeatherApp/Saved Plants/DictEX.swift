//
//  DictEX.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/18/22.
//

import Foundation

extension UserDefaults{
    
    //setting the dictionary
    func set(savedPlantsArray: [SavedPlants], forKey key: String) {
            let array = try? NSKeyedArchiver.archivedData(withRootObject: savedPlantsArray, requiringSecureCoding: true)
            self.set(array, forKey: key)
        }
        
    //getting the dictionary of saved values from user
        func get(forKey key: String) -> [SavedPlants]? {
            if let array = data(forKey: key){
                if let savedPlantsArray = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(array) as? [SavedPlants] {
                    return savedPlantsArray
                }
            }
            return []
        }
    
    
    
    
    
    
    
    
    
    
}
