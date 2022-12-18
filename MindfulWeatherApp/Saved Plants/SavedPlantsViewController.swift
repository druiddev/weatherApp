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
    
    @IBOutlet var savedPlantCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    //to send info from one controller to the other
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let singlePlantVC = segue.destination as? SinglePlantViewController {
            for info in savedPlants{
                singlePlantVC.savedPlant = info
            }
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
 
    
    
}
