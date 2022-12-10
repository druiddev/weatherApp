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
    var locationData: Location!
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    var lat: CLLocationDegrees = 0.0
    var lon: CLLocationDegrees = 0.0
    var API = "405db7bf13ea449a2506f66752e029b5"
    let hour = Calendar.current.component(.hour, from: Date())
    let day = Calendar.current.component(.day, from: Date())
    var currentDate = Date()
    let savedDate = UserDefaults.standard.value(forKey: "firstDate")
   // var plantGrowthCycleLength = 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        print(hour)
        
        if let firstOpen = UserDefaults.standard.object(forKey: "firstDate") as? Date {
            print("The app was first opened on \(firstOpen)")
        } else {
            // This is the first launch
            UserDefaults.standard.set(Date(), forKey: "firstDate")
        }
        
        //compares dates from when the last time you opened the app so you can see how much your plant grew in the time you were gone.
        //calculates how many days have elasped while the app was closed
        //let savedDate = UserDefaults.standard.value(forKey: "firstDate")
       // let currentDate = Date()
       // let diffInDays = Calendar.current.dateComponents([.day], from: savedDate as! Date, to: currentDate).day
        
        
        //location manager
        setupLocationManager()
        
        
        daysCollectionView.reloadData()
        backgroundColorBasedOnTime()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
     
        reloadDataInputs()
    }
    
    func reloadDataInputs(){
        
        for loc in locationInfo{
            locationLabel.text = "\(loc.city), \(loc.state)"
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
                longitude = location.coordinate.longitude
                latitude = location.coordinate.latitude
                lon = (longitude*100).rounded()/100 //rounds it to two decimal places
                lat = (latitude*100).rounded()/100
                
                //json weather data
               weatherInformation(atURL: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(API)&units=imperial")

                //location name based on lat and lon
                reverseGeocoding(atURL: "https://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(lon)&limit=5&appid=\(API)")
             reloadDataInputs()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed, \(error)")
    }
    
    func backgroundColorBasedOnTime(){
        switch hour{
        case 00...05:
            view.backgroundColor = .gray
            daysCollectionView.backgroundColor = .gray
        case 06...08:
            view.backgroundColor = .orange
            daysCollectionView.backgroundColor = .orange
        case 09...12:
            view.backgroundColor = .blue
            daysCollectionView.backgroundColor = .blue
        case 13...17:
            view.backgroundColor = .systemBlue
            daysCollectionView.backgroundColor = .systemBlue
        case 18...20:
            view.backgroundColor = .orange
            daysCollectionView.backgroundColor = .orange
        case 21...23:
            view.backgroundColor = .gray
            daysCollectionView.backgroundColor = .gray
        default:
            view.backgroundColor = .blue
            
        }
    }
    

    
    func plantgrowth(){
        
        let diffInDays = Calendar.current.dateComponents([.day], from: savedDate as! Date, to: currentDate).day
        
        //if settings is set to ten days, cant die, inside and no tending
        switch diffInDays {
        case 1:
            //one day has passed
            plantImageLabel.image = UIImage(named: "OrangeTree1")
        case 2:
            plantImageLabel.image = UIImage(named: "OrangeTree2")
        case 3:
            plantImageLabel.image = UIImage(named: "OrangeTree3")
        case 4:
            plantImageLabel.image = UIImage(named: "OrangeTree4")
        case 5:
            plantImageLabel.image = UIImage(named: "OrangeTree5")
        case 6:
            plantImageLabel.image = UIImage(named: "OrangeTree6")
        case 7:
            plantImageLabel.image = UIImage(named: "OrangeTree7")
        case 8:
            plantImageLabel.image = UIImage(named: "OrangeTree8")
        case 9:
            plantImageLabel.image = UIImage(named: "OrangeTree9")
        default:
            plantImageLabel.image = UIImage(named: "OrangeTree0")
        }
        
    }
    
    
    @IBAction func unwindToFirst(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.source is PlantSettingsViewController else {return}}
      
    
    
    
    }
 

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = daysCollectionView.dequeueReusableCell(withReuseIdentifier: "cell_ID_1", for: indexPath) as? CollectionViewCell else {return daysCollectionView.dequeueReusableCell(withReuseIdentifier: "cell_ID_1", for: indexPath)}

        if weatherInfo.isEmpty != true{
            cell.dayLabel.text = weatherInfo[indexPath.row].date
            cell.imageLabel.image = weatherInfo[indexPath.row].imageProperty
            cell.lowHighTempLabel.text = weatherInfo[indexPath.row].minMaxTemp
        }
        return cell
    }
    
    
    
    
    
}
