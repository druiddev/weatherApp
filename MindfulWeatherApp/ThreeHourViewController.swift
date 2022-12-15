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
    let hour = Calendar.current.component(.hour, from: Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()

      setupLocationManager()
        threeHourCollectionView.backgroundColor = .clear
        astrologyCollectionView.backgroundColor = .clear
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
