//
//  ViewController.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/2/22.
//

import UIKit

class ViewController: UIViewController{

    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var plantImageLabel: UIImageView!
    @IBOutlet var daysCollectionView: UICollectionView!
    @IBOutlet var viewBackground: UIView!
    @IBOutlet var weatherDescriptionLabel: UILabel!
    
    var weekInfo = [WeatherInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        json()
        
        for info in weekInfo {
            locationLabel.text = "\(info.city), \(info.state)"
            temperatureLabel.text = info.temperature.description
            for des in info.description{
                weatherDescriptionLabel.text = des
            }
        }
    }
}
 

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daysCell", for: indexPath) as? CollectionViewCell else {return collectionView.dequeueReusableCell(withReuseIdentifier: "daysCell", for: indexPath)}
        
//        cell.dayLabel.text = "DAY"
//        cell.imageLabel.image = weekInfo[indexPath.row].imageProperty
//        cell.lowHighTempLabel.text = weekInfo[indexPath.row].temperature.description
        
        return cell
    }
    
    
    
    
    
}
