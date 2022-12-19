//
//  SavedPlantsViewController.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/17/22.
//

import UIKit

class SavedPlantsViewController: UIViewController {

    var savedPlants = [SavedPlants]()
    var plantImage = UIImage(named: "OrangeTree0")
    var plantLocationImage = UIImage(named: "inside")
    var hour = Calendar.current.component(.hour, from: Date())
    
    @IBOutlet var savedPlantCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundColorBasedOnTime()
        savedPlantCollectionView.backgroundColor = .clear
        
        
    }


    //to send info from one controller to the other
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let cell = sender as? UICollectionViewCell,
                let indexPath = self.savedPlantCollectionView.indexPath(for: cell) {

                 let singlePlantVC = segue.destination as! SinglePlantViewController
                 
                    singlePlantVC.savedPlant = savedPlants[indexPath.row]
             }
    }
    }

extension SavedPlantsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedPlants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = savedPlantCollectionView.dequeueReusableCell(withReuseIdentifier: "cell_ID_2", for: indexPath) as? SavedPlantCollectionViewCell else {return savedPlantCollectionView.dequeueReusableCell(withReuseIdentifier: "cell_ID_2", for: indexPath)}
        
        if savedPlants.isEmpty != true{
            cell.savedDateLabel.text = savedPlants[indexPath.row].dateString
            cell.plantImage.image = savedPlants[indexPath.row].plantImage
            cell.plantLocationImage.image = savedPlants[indexPath.row].locationImage
           
        }
      return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoSinglePlant", sender: self)
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
