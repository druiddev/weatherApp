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
    
    var weatherInfo = [WeatherInfo]()
    var locationInfo = [Location]()
    let locationManager = CLLocationManager()
    var lat: CLLocationDegrees = 0.0
    var lon: CLLocationDegrees = 0.0
    var API = "405db7bf13ea449a2506f66752e029b5"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //json weather data
        weatherInformation(atURL: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(API)&units=imperial")
        
        //location name based on lat and lon
        reverseGeocoding(atURL: "https://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(lon)&limit=5&appid=\(API)")
        
            daysCollectionView.reloadData()
        
        //location manager
        setupLocationManager()
        
        for loc in locationInfo{
            locationLabel.text = loc.name
        }
        
        for info in weatherInfo {
            temperatureLabel.text = info.temp.description
            weatherDescriptionLabel.text = info.mainDescription
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
                lon = (longitude*100).rounded()/100 //rounds it to two decimal places
                print(lon)
                let latitude = location.coordinate.latitude
                lat = (latitude*100).rounded()/100
                print(lat)
                print("longitude = \(longitude), latitude = \(latitude)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed, \(error)")
    }
    
    func backgroundColorBasedOnTime(){
        
//        switch  {
//        case :
//
//        default:
//
//        }
        
    }
    
    
}
 

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daysCell", for: indexPath) as? CollectionViewCell else {return collectionView.dequeueReusableCell(withReuseIdentifier: "daysCell", for: indexPath)}
        
//        cell.dayLabel.text = "DAY"
 //       cell.imageLabel.image = weatherInfo[indexPath.row].imageProperty
     //   cell.lowHighTempLabel.text = weatherInfo[indexPath.row].temp.description
        
        return cell
    }
    
    
    
    
    
}
