//
//  PlantSettingsViewController.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/6/22.
//

import UIKit

class PlantSettingsViewController: UIViewController {
    
    
    @IBOutlet var tendPlantSwitch: UISegmentedControl!
    @IBOutlet var plantDeathSwitch: UISegmentedControl!
    @IBOutlet var respawnPlantButton: UIButton!
    @IBOutlet var saveStoreButton: UIButton!
    @IBOutlet var plantLocationSwitch: UISegmentedControl!
    @IBOutlet var growthSwitch: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //userdefaults and save when you go away and come back
        UserDefaults.standard.bool(forKey: "tend")
        UserDefaults.standard.bool(forKey: "plantDeath")
        UserDefaults.standard.bool(forKey: "plantLocation")
        UserDefaults.standard.bool(forKey: "growthLength")
        
        
//        if let growthTimePlantSetting = UserDefaults.standard.object(forKey: "growthLength") {
//            plantGrowthLength = growthTimePlantSetting as! Int
//        }
//        
//        if let tendPlantSetting = UserDefaults.standard.object(forKey: "tend") {
//            tend = tendPlantSetting as! Bool
//        }
//        
//        if let witherPlantSetting = UserDefaults.standard.object(forKey: "wither") {
//            wither = witherPlantSetting as! Bool
//        }
//        
//        if let locationPlantSetting = UserDefaults.standard.object(forKey: "plantLocation") {
//            housePlant = locationPlantSetting as! Bool
//        }
//        
//        
        
        
        
    }
    
    
    @IBAction func tendPlantSwitchedChanged(_ sender: Any) {
        if tendPlantSwitch.isEnabledForSegment(at: 0) == true{
            //set to true
            UserDefaults.standard.set(true, forKey: "tend")
        }
        else{
            //set to false
            UserDefaults.standard.set(false, forKey: "tend")
        }
    }
    
    
    @IBAction func plantDeathSwitchChanged(_ sender: Any) {
        if plantDeathSwitch.isEnabledForSegment(at: 0) == true{
            //set to true
            UserDefaults.standard.set(true, forKey: "wither")
        }
        else{
            //set to false
            UserDefaults.standard.set(false, forKey: "wither")
        }
    }
    
    
    @IBAction func plantLocationSwitchChanged(_ sender: Any) {
        if plantLocationSwitch.isEnabledForSegment(at: 0) == true{
            //set to true
            UserDefaults.standard.set(true, forKey: "plantLocation")
        }
        else{
            //set to false
            UserDefaults.standard.set(false, forKey: "plantLocation")
        }
        
    }

    
    @IBAction func growthSwitchChanged(_ sender: Any) {
        var day = 0
        
        if growthSwitch.isEnabledForSegment(at: 0) == true{
            day = 10
            UserDefaults.standard.set(day, forKey: "growthLength")
        } else if growthSwitch.isEnabledForSegment(at: 1) == true{
            day = 20
            UserDefaults.standard.set(day, forKey: "growthLength")
        } else if growthSwitch.isEnabledForSegment(at: 2) == true{
            day = 40
            UserDefaults.standard.set(day, forKey: "growthLength")
        } else if growthSwitch.isEnabledForSegment(at: 3) == true{
            day = 80
            UserDefaults.standard.set(day, forKey: "growthLength")
        } else if growthSwitch.isEnabledForSegment(at: 4) == true{
            day = 160
            UserDefaults.standard.set(day, forKey: "growthLength")
        }
   
        
    }
    
    
    
    
}
