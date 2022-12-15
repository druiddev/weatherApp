//
//  ThreeHourViewController.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/10/22.
//

import UIKit
import CoreLocation

class ThreeHourViewController: UIViewController, CLLocationManagerDelegate{
    
  
    @IBOutlet var astrologyCollectionView: UICollectionView!
    @IBOutlet var threeHourCollectionView: UICollectionView!
    @IBOutlet var backgroundView: UIImageView!
    @IBOutlet var threeHourView: UIView!
    
    var weatherInfo = [WeatherInfo]()
    var locationInfo = [Location]()
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    var lat: CLLocationDegrees = 0.0
    var lon: CLLocationDegrees = 0.0
    var API = "405db7bf13ea449a2506f66752e029b5"
    var astrology = [Astrology]()
    var searchInput = "16648"
    
    override func viewDidLoad() {
        super.viewDidLoad()

      setupLocationManager()
        threeHourView.backgroundColor = .systemBlue
        threeHourCollectionView.backgroundColor = .systemBlue
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
                var searchInput = "\(lat),\(lon)"
                //json weather data
               parseJson()
             
                
            }
        }
    }
    
    func parseJson(){
        
        if lat == 0.0 && lon == 0.0{
            for info in astrology{
                weatherInformation(atURL: "https://api.openweathermap.org/data/2.5/forecast?lat=\(info.lat)&lon=\(info.lon)&appid=\(API)&units=imperial")
                astrologyParsing(atURL: "https://api.weatherapi.com/v1/forecast.json?key=5e27e4e054a04ba8b83220852221412&q=\(info.lat),\(info.lon)&days=10&aqi=no&alerts=no")
            }
        } else {
            weatherInformation(atURL: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(API)&units=imperial")
            astrologyParsing(atURL: "https://api.weatherapi.com/v1/forecast.json?key=5e27e4e054a04ba8b83220852221412&q=\(searchInput)&days=10&aqi=no&alerts=no")
        }
       
    }
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed, \(error)")
    }
    


}

extension ThreeHourViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == astrologyCollectionView {
            return astrology.count
        }
        //defaults to the 3hour
        return weatherInfo.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == astrologyCollectionView {
            
            guard let cell = astrologyCollectionView.dequeueReusableCell(withReuseIdentifier: "cell_ID_4", for: indexPath) as? astrologyCollectionViewCell else {return astrologyCollectionView.dequeueReusableCell(withReuseIdentifier: "cell_ID_4", for: indexPath)}
            
            if astrology.isEmpty != true{
                cell.sunriseLabel.text = astrology[indexPath.row].sunriseString
                cell.sunsetLabel.text = astrology[indexPath.row].sunsetString
                cell.moonriseLabel.text = astrology[indexPath.row].moonriseString
                cell.moonset.text = astrology[indexPath.row].moonsetString
                cell.moonImage.image = astrology[indexPath.row].imageBasedOnMoonphase
            }
            return cell

            
        }
        
        
        
        
        //defaults to 3hour
        guard let cell = threeHourCollectionView.dequeueReusableCell(withReuseIdentifier: "cell_ID_2", for: indexPath) as? threeHourCollectionViewCell else {return threeHourCollectionView.dequeueReusableCell(withReuseIdentifier: "cell_ID_2", for: indexPath)}
        
        if weatherInfo.isEmpty != true{
            cell.dateLabel.text = weatherInfo[indexPath.row].dayOfDate
            cell.weatherImageLabel.image = weatherInfo[indexPath.row].imageProperty
            cell.lowHighLabel.text = weatherInfo[indexPath.row].minMaxTemp
        }
        return cell
        
        
        
        
        
        
        
    }
    
}
