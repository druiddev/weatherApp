//
//  ThreeHourViewController.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/10/22.
//

import UIKit
import CoreLocation

class ThreeHourViewController: UIViewController, CLLocationManagerDelegate{
    
    
    
    @IBOutlet var threeHourCollectionView: UICollectionView!
    @IBOutlet var backgroundView: UIImageView!
    
    
    var weatherInfo = [WeatherInfo]()
    var locationInfo = [Location]()
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    var lat: CLLocationDegrees = 0.0
    var lon: CLLocationDegrees = 0.0
    var API = "405db7bf13ea449a2506f66752e029b5"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      setupLocationManager()
    
        threeHourCollectionView.reloadData()
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
                longitude = location.coordinate.longitude
                latitude = location.coordinate.latitude
                lon = (longitude*100).rounded()/100 //rounds it to two decimal places
                lat = (latitude*100).rounded()/100
                
                //json weather data
               weatherInformation(atURL: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(API)&units=imperial")
             
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed, \(error)")
    }
    


}

extension ThreeHourViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = threeHourCollectionView.dequeueReusableCell(withReuseIdentifier: "cell_ID_2", for: indexPath) as? threeHourCollectionViewCell else {return threeHourCollectionView.dequeueReusableCell(withReuseIdentifier: "cell_ID_2", for: indexPath)}

        if weatherInfo.isEmpty != true{
            cell.dateLabel.text = weatherInfo[indexPath.row].dayOfDate
            cell.weatherImageLabel.image = weatherInfo[indexPath.row].imageProperty
            cell.lowHighLabel.text = weatherInfo[indexPath.row].minMaxTemp
        }
        return cell
    }
    
    
    
    
    
}
