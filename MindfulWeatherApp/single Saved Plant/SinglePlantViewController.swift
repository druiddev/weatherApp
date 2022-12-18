//
//  SinglePlantViewController.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/18/22.
//

import UIKit

class SinglePlantViewController: UIViewController {

    
    @IBOutlet var plantLocationImage: UIImageView!
    @IBOutlet var plantImage: UIImageView!
    @IBOutlet var dateSavedLabel: UILabel!
    var savedPlant: SavedPlants?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
      
    }
    

    @IBAction func takePlantOutOfStorage(_ sender: Any) {
        
        let alert = UIAlertController(title: "Take Plant Out Of Storage?", message: "Would you like to bring your plant back out? This will delete your current plant if its not saved.", preferredStyle: .alert)
        
        // delete, no saving
        alert.addAction(UIAlertAction(title: "Yes, Please!", style: .default, handler: {(action) in
            
            self.performSegue(withIdentifier: "gotoFirst", sender: self)
   
        }))
        
        //go back without doing anything
        alert.addAction(UIAlertAction(title: "Nevermind, Go back", style: .default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    

}
