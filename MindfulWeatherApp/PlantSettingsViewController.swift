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
    var savedPlants = [SavedPlants]()
    var plantImage = UIImage(named: "OrangeTree0")
    var plantLocationImage = UIImage(named: "inside")
    
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
    
    
    @IBAction func saveandStoreButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Save Your Plant", message: "Would you like to Save and Store your plant?", preferredStyle: .alert)
        
        // delete, no saving
        alert.addAction(UIAlertAction(title: "Yes, Please!", style: .default, handler: {(action) in
            
            self.savedPlants.append(SavedPlants(plantImage: self.plantImage!, locationImage: self.plantLocationImage!, dateSaved: Date()))
            self.performSegue(withIdentifier: "gotoSaved", sender: self)
   
        }))
        
        //go back without doing anything
        alert.addAction(UIAlertAction(title: "Nevermind, Go back", style: .default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func respawnPlantButton(_ sender: Any) {
        
        
        //shows alert they won
        let alert = UIAlertController(title: "Are You Sure?", message: "Respawning your plant will delete your current plant and respawn a new one of the same type.", preferredStyle: .alert)
        
        // delete, no saving
        alert.addAction(UIAlertAction(title: "Yes, Delete My Current Plant", style: .default, handler: {(action) in
            //code goes here
   
        }))
        //delete and save
        alert.addAction(UIAlertAction(title: "Save and Respawn A New Plant", style: .default, handler: {(action: UIAlertAction) in
            //code for replay goes here
        }))
        
        //go back without doing anything
        alert.addAction(UIAlertAction(title: "Nevermind, Go back", style: .default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        present(alert, animated: true, completion: nil)
        
 
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoSaved" {
            guard let savedVC = segue.destination as? SavedPlantsViewController else {return}
            //guard let threeHourVC = segue.destination as? ThreeHourViewController else {return}
                        
          savedVC.savedPlants = savedPlants

            
        }
        
    }
    
}
