//
//  PlantSettingsViewController.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/6/22.
//

import UIKit

class PlantSettingsViewController: UIViewController {
    
    
    @IBOutlet var growthScaleSlider: UISlider!
    @IBOutlet var tendPlantSwitch: UISegmentedControl!
    @IBOutlet var plantDeathSwitch: UISegmentedControl!
    @IBOutlet var respawnPlantButton: UIButton!
    @IBOutlet var saveStoreButton: UIButton!
    @IBOutlet var plantLocationSwitch: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //userdefaults and save when you go away and come back
        let tendStatus = UserDefaults.standard.bool(forKey: "tend")
        let deathStatus = UserDefaults.standard.bool(forKey: "plantDeath")
        let locationStatus = UserDefaults.standard.bool(forKey: "plantLocation")
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
            UserDefaults.standard.set(true, forKey: "plantDeath")
        }
        else{
            //set to false
            UserDefaults.standard.set(false, forKey: "plantDeath")
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
    
    
    
    
    
    
    
}
