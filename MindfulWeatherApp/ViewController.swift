//
//  ViewController.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/2/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{

    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var plantImageLabel: UIImageView!
    @IBOutlet var daysCollectionView: UICollectionView!
    @IBOutlet var viewBackground: UIView!
    @IBOutlet var weatherDescriptionLabel: UILabel!
    
    var weekInfo = [WeatherInfo]()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //json weather data
        json()
        
        //location manager
        setupLocationManager()
        
        
        for info in weekInfo {
            locationLabel.text = "\(info.city), \(info.state)"
            temperatureLabel.text = info.temperature.description
            for des in info.description{
                weatherDescriptionLabel.text = des
            }
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //ask for this when plant is being created.
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if location.horizontalAccuracy > 0 {
                //if negative, its invaild
                locationManager.stopUpdatingLocation()
                //this is so it doesnt drain battery once location data is correct
                
                let longitude = location.coordinate.longitude
                let latitude = location.coordinate.latitude
                
                print("longitude = \(longitude), latitude = \(latitude)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed, \(error)")
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
