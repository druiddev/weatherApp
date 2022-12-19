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
    var hour = Calendar.current.component(.hour, from: Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundColorBasedOnTime()
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoFirst" {
            guard let firstVC = segue.destination as? ViewController else {return}
            //guard let threeHourVC = segue.destination as? ThreeHourViewController else {return}
            
            firstVC.plantImage = plantImage.image
            firstVC.plantLocationImage = plantLocationImage.image
            
            
        }
    }
    
    
    

    @IBAction func takePlantOutOfStorage(_ sender: Any) {
        
        let alert = UIAlertController(title: "Take Plant Out Of Storage?", message: "Would you like to bring your plant back out? This will delete your current plant if its not saved.", preferredStyle: .alert)
        
        // delete, no saving
        alert.addAction(UIAlertAction(title: "Yes, Please!", style: .default, handler: {(action) in
            
            self.navigationController?.popToRootViewController(animated: true)
   
        }))
        
        //go back without doing anything
        alert.addAction(UIAlertAction(title: "Nevermind, Go back", style: .default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        present(alert, animated: true, completion: nil)
 
    }
    

    
    func backgroundColorBasedOnTime(){
        switch hour{
        case 00...05:
            setNightColors()
        case 06...08:
            setSunriseColors()
        case 09...12:
            setMorningColors()
        case 13...17:
            setMiddayColors()
        case 18...20:
            setSunsetColors()
        case 21...23:
            setNightColors()
        default:
            view.backgroundColor = .blue
            
        }
    }
    
    
    func setSunriseColors() {
        let colorTop =  UIColor(red: 217.0/255.0, green: 100.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 10.0/255.0, green: 94.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
          
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    
    
    func setMorningColors() {
        let colorTop =  UIColor(red: 245.0/255.0, green: 220.0/255.0, blue: 88.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 10.0/255.0, green: 94.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
          
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    
    func setMiddayColors() {
        let colorTop =  UIColor(red: 255.0/255.0, green: 230.0/255.0, blue: 153.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 10.0/255.0, green: 94.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
          
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    
    func setSunsetColors() {
        let colorTop =  UIColor(red: 217.0/255.0, green: 100.0/255.0, blue: 117.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 10.0/255.0, green: 94.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
          
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func setNightColors() {
        let colorTop =  UIColor(red: 160.0/255.0, green: 160.0/255.0, blue: 160.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 90.0/255.0, green: 90.0/255.0, blue: 90.0/255.0, alpha: 1.0).cgColor
          
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    
    
}
