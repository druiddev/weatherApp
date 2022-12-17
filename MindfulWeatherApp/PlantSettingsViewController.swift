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
    
    var settingsRef: PlantSettings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //userdefaults and save when you go away and come back
        UserDefaults.standard.bool(forKey: "tend")
        UserDefaults.standard.bool(forKey: "wither")
        UserDefaults.standard.bool(forKey: "plantLocation")
        UserDefaults.standard.bool(forKey: "growthLength")
        
        
        //shows your choice on opening the controller
        growthSwitch.selectedSegmentIndex = settingsRef!.growthChoice
        tendPlantSwitch.selectedSegmentIndex = settingsRef!.tendChoice
        plantDeathSwitch.selectedSegmentIndex = settingsRef!.witherChoice
        plantLocationSwitch.selectedSegmentIndex = settingsRef!.locationChoice

        
    }
    
    
    @IBAction func tendPlantSwitchedChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(tendPlantSwitch.selectedSegmentIndex, forKey: "tend")
        settingsRef?.tend = Bool(truncating: tendPlantSwitch.selectedSegmentIndex as NSNumber)
    }
    
    
    @IBAction func plantDeathSwitchChanged(_ sender: UISegmentedControl) {
        
        UserDefaults.standard.set(plantDeathSwitch.selectedSegmentIndex, forKey: "wither")
        settingsRef?.wither = Bool(truncating: plantDeathSwitch.selectedSegmentIndex as NSNumber)
    }
    
    
    @IBAction func plantLocationSwitchChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(plantLocationSwitch.selectedSegmentIndex, forKey: "plantLocation")
        settingsRef?.plantLocation = Bool(truncating: plantLocationSwitch.selectedSegmentIndex as NSNumber)
        
    }

    
    @IBAction func growthSwitchChanged(_ sender: UISegmentedControl) {
        
        UserDefaults.standard.set(growthSwitch.selectedSegmentIndex, forKey: "growthLength")
        settingsRef?.growthLength = Bool(truncating: growthSwitch.selectedSegmentIndex as NSNumber)
         
    }
    
    
    
    
    
    
    
    
    
}
