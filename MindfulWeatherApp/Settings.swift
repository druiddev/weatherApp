//
//  Settings.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/17/22.
//

import Foundation

class PlantSettings{
    
    var growthLength: Bool
    var tend: Bool
    var wither: Bool
    var plantLocation: Bool
    
    
    
    
    //default init
    init(){
        
        growthLength = Bool(truncating: 0)
        tend = Bool(truncating: 0)
        wither = Bool(truncating: 0)
        plantLocation = Bool(truncating: 0)
        
    }
    
  
    
    var growthChoice: Int{
        var choice = 0
        if growthLength == Bool(truncating: 0){
            choice = 0
        } else if growthLength == Bool(truncating: 1){
            choice = 1
        } else if growthLength == Bool(truncating: 2){
            choice = 2
        } else if growthLength == Bool(truncating: 3){
            choice = 3
        } else if growthLength == Bool(truncating: 4){
            choice = 4
        }
        
        return choice
    }
    
    
    
    var tendChoice: Int{
        var choice = 0
        if tend == Bool(truncating: 0){
            choice = 0
        } else if tend == Bool(truncating: 1){
            choice = 1
        }
        
        return choice
    }
    
    
    var witherChoice: Int{
        var choice = 0
        if wither == Bool(truncating: 0){
            choice = 0
        } else if wither == Bool(truncating: 1){
            choice = 1
        }
        
        return choice
    }
    
    
    var locationChoice: Int{
        var choice = 0
        if plantLocation == Bool(truncating: 0){
            choice = 0
        } else if plantLocation == Bool(truncating: 1){
            choice = 1
        }
        
        return choice
    }
    
    
    
    
    
}
