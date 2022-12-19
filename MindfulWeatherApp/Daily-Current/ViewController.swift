//
//  ViewController.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/2/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate{
    
    
    var searchController = UISearchController(searchResultsController: nil)

    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var plantImageLabel: UIImageView!
    @IBOutlet var insideImageLabel: UIImageView!
    @IBOutlet var outsideImageLabel: UIImageView!
    @IBOutlet var daysCollectionView: UICollectionView!
    @IBOutlet var viewBackground: UIView!
    @IBOutlet var weatherDescriptionLabel: UILabel!
    @IBOutlet var searchButton: UIBarButtonItem!
    @IBOutlet var searchBar: UITextField!
    @IBOutlet var wateringCanWatering: UIImageView!
    @IBOutlet var wateringCan: UIButton!
    
    
    
    
    //location vars
    var dailyWeather = [DailyWeather]()
    var locationInfo = [Location]()
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    var lat: CLLocationDegrees = 0.0
    var lon: CLLocationDegrees = 0.0
    
    //api vars
    var searchInput = "16648"
    var API = "405db7bf13ea449a2506f66752e029b5"
    
    //date vars
    let hour = Calendar.current.component(.hour, from: Date())
    let day = Calendar.current.component(.day, from: Date())
    var currentDate = Date()
    let savedDate = UserDefaults.standard.value(forKey: "firstDate")
    
    //settings vars
    var plantGrowthLength = 0 //the five choices
    var tend = 0 //true is 0
    var wither = 0 // it will wither by default, true is 0
    var housePlant = 0 //true is 0
    var settingsRef = PlantSettings()
    
    //plant
    var plantImage = UIImage(named: "OrangeTree0")
    var plantLocationImage = UIImage(named: "inside")
    var savedPlants = [SavedPlants]()
    
    
    //tending
    var didWater = false
    var withering = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        
        wateringCanWatering.isHidden = true
        //user defaults function for plant settings
        userDefaultsSavedInfo()
        

        //user defaults
        if let firstOpen = UserDefaults.standard.object(forKey: "firstDate") as? Date {
            print("The app was first opened on \(firstOpen)")
        } else {
            // This is the first launch
            UserDefaults.standard.set(Date(), forKey: "firstDate")
        }
        
     
        //location manager
        setupLocationManager()
        
        daysCollectionView.backgroundColor = .clear
        daysCollectionView.reloadData()
        backgroundColorBasedOnTime()
        plantgrowth()
        
        
        //settings the image values to the current
        plantImage = plantImageLabel.image
        
        if insideImageLabel.isHidden == true{
            plantLocationImage = outsideImageLabel.image
        } else if insideImageLabel.isHidden == false{
            plantLocationImage = insideImageLabel.image
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        daysCollectionView.reloadData()
        reloadDataInputs()
        userDefaultsSavedInfo()
        
    }
    
    func userDefaultsSavedInfo(){
        
        
        if let value = UserDefaults.standard.value(forKey: "growthLength"){
            let selectedIndex = value as! Int
            plantGrowthLength = selectedIndex
        }
        
        if let value = UserDefaults.standard.value(forKey: "tend"){
            let selectedIndex = value as! Int
            tend = selectedIndex
        }
        
        if let value = UserDefaults.standard.value(forKey: "wither"){
            let selectedIndex = value as! Int
            wither = selectedIndex
        }
        
        if let value = UserDefaults.standard.value(forKey: "plantLocation"){
            let selectedIndex = value as! Int
            housePlant = selectedIndex
        }
        //gets the users last saved plants dict from the last time they were using the app and uses it as the starting point in the table
        if savedPlants.isEmpty == false{
            if let userSavedDict = UserDefaults.standard.get(forKey: "filter"){
                savedPlants = userSavedDict
            }
            
        }
    }
    func waterPlant(){
        didWater = true
    }
    
    @IBAction func wateringCanButton(_ sender: Any) {
        
        //changes bool to true so your plant doesnt die
        waterPlant()
        //hides button so you can see pouring image
        wateringCan.isHidden = true
        wateringCanWatering.isHidden = false
        
        //waits four seconds to finish pouring, then hides the image and replaces the can
        let seconds = 4.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.wateringCan.isHidden = false
            self.wateringCanWatering.isHidden = true        }
        
    }
    
    
    func reloadDataInputs(){
        

        plantImageLabel.image = plantImage
        
        if insideImageLabel.isHidden == true{
            outsideImageLabel.image = plantLocationImage
        } else if insideImageLabel.isHidden == false{
            insideImageLabel.image = plantLocationImage

        }
        
        
        for info in dailyWeather {
            let t = String(info.currentTemp.description).dropLast(2)
            temperatureLabel.text = "\(t)°"
            weatherDescriptionLabel.text = info.dailyDesc
            locationLabel.text = "\(info.city), \(info.state)"
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
                var searchInput = "\(lat),\(lon)"
                parseJson()
            }
        }
    }
    
    func parseJson(){
        weatherInformation(atURL: "https://api.weatherapi.com/v1/forecast.json?key=5e27e4e054a04ba8b83220852221412&q=\(searchInput)&days=10&aqi=no&alerts=no")
        
        //location name based on lat and lon
        reverseGeocoding(atURL: "https://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(lon)&limit=5&appid=\(API)")
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed, \(error)")
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
    

    
    @IBAction func searchButton(_ sender: Any) {
        
        //makes what the user types, the new info for parsing, then re does the views. removes the spaces if they type any also
            searchInput = String(searchBar.text!.filter { !" \n\t\r".contains($0) })
        
        if searchInput.isEmpty != true {
            parseJson()
            reloadDataInputs()
            daysCollectionView.reloadData()
        }
       

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        //textField code

        searchBar.resignFirstResponder()  //if desired
        
        //makes what the user types, the new info for parsing, then re does the views. removes the spaces if they type any also
            searchInput = String(searchBar.text!.filter { !" \n\t\r".contains($0) })
        
        if searchInput.isEmpty != true {
            parseJson()
            reloadDataInputs()
            daysCollectionView.reloadData()
        }
        
        return true
    }
    
    
    
    
    @IBAction func weatherSettings(_ sender: Any) {
        
        performSegue(withIdentifier: "goTo3Hour", sender: self)
        
        
    }
    
    func uniqueElementsFrom(array: [String]) -> [String] {
        //Create an empty Set to track unique items
        var set = Set<String>()
        let result = array.filter {
            guard !set.contains($0) else {
                //If the set already contains this object, return false
                //so we skip it
                return false
            }
            //Add this item to the set since it will now be in the array
            set.insert($0)
            //Return true so that filtered array will contain this item.
            return true
        }
        return result
    }
    
    func plantgrowth(){
        
        if savedDate != nil {
            let diffInDays = Calendar.current.dateComponents([.day], from: savedDate as! Date, to: currentDate).day
            
            
            
            //if settings is set to ten days, cant die, inside and no tending OR ten days, tending, cant die, inside
            if plantGrowthLength == 0 && tend == 1 && wither == 1 && housePlant == 0 || plantGrowthLength == 0 && tend == 0 && wither == 1 && housePlant == 0{
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
            
            //if settings is set to 20 days, cant die, inside and no tending OR 20 days, tending, cant die, inside
            if plantGrowthLength == 1 && tend == 1 && wither == 1 && housePlant == 0 || plantGrowthLength == 1 && tend == 0 && wither == 1 && housePlant == 0{
                switch diffInDays {
                case 4:
                    
                    plantImageLabel.image = UIImage(named: "OrangeTree1")
                case 6:
                    plantImageLabel.image = UIImage(named: "OrangeTree2")
                case 8:
                    plantImageLabel.image = UIImage(named: "OrangeTree3")
                case 10:
                    plantImageLabel.image = UIImage(named: "OrangeTree4")
                case 12:
                    plantImageLabel.image = UIImage(named: "OrangeTree5")
                case 14:
                    plantImageLabel.image = UIImage(named: "OrangeTree6")
                case 16:
                    plantImageLabel.image = UIImage(named: "OrangeTree7")
                case 18:
                    plantImageLabel.image = UIImage(named: "OrangeTree8")
                case 20:
                    plantImageLabel.image = UIImage(named: "OrangeTree9")
                default:
                    plantImageLabel.image = UIImage(named: "OrangeTree0")
                }
                
            }
            
            
            //if settings is set to 40 days, cant die, inside and no tending OR 40 days, tending, cant die, inside
            if plantGrowthLength == 0 && tend == 1 && wither == 1 && housePlant == 0 || plantGrowthLength == 0 && tend == 0 && wither == 1 && housePlant == 0{
                switch diffInDays {
                case 8:
                    //one day has passed
                    plantImageLabel.image = UIImage(named: "OrangeTree1")
                case 12:
                    plantImageLabel.image = UIImage(named: "OrangeTree2")
                case 16:
                    plantImageLabel.image = UIImage(named: "OrangeTree3")
                case 20:
                    plantImageLabel.image = UIImage(named: "OrangeTree4")
                case 24:
                    plantImageLabel.image = UIImage(named: "OrangeTree5")
                case 28:
                    plantImageLabel.image = UIImage(named: "OrangeTree6")
                case 32:
                    plantImageLabel.image = UIImage(named: "OrangeTree7")
                case 36:
                    plantImageLabel.image = UIImage(named: "OrangeTree8")
                case 40:
                    plantImageLabel.image = UIImage(named: "OrangeTree9")
                default:
                    plantImageLabel.image = UIImage(named: "OrangeTree0")
                }
                
            }
            
            
            //if settings is set to 80 days, cant die, inside and no tending OR 80 days, tending, cant die, inside
            if plantGrowthLength == 0 && tend == 1 && wither == 1 && housePlant == 0 || plantGrowthLength == 0 && tend == 0 && wither == 1 && housePlant == 0{
                switch diffInDays {
                case 16:
                    //one day has passed
                    plantImageLabel.image = UIImage(named: "OrangeTree1")
                case 24:
                    plantImageLabel.image = UIImage(named: "OrangeTree2")
                case 32:
                    plantImageLabel.image = UIImage(named: "OrangeTree3")
                case 40:
                    plantImageLabel.image = UIImage(named: "OrangeTree4")
                case 48:
                    plantImageLabel.image = UIImage(named: "OrangeTree5")
                case 56:
                    plantImageLabel.image = UIImage(named: "OrangeTree6")
                case 64:
                    plantImageLabel.image = UIImage(named: "OrangeTree7")
                case 72:
                    plantImageLabel.image = UIImage(named: "OrangeTree8")
                case 80:
                    plantImageLabel.image = UIImage(named: "OrangeTree9")
                default:
                    plantImageLabel.image = UIImage(named: "OrangeTree0")
                }
                
            }
            
            
            //if settings is set to 160 days, cant die, inside and no tending OR 160 days, tending, cant die, inside
            if plantGrowthLength == 0 && tend == 1 && wither == 1 && housePlant == 0 || plantGrowthLength == 0 && tend == 0 && wither == 1 && housePlant == 0{
                switch diffInDays {
                case 32:
                    //one day has passed
                    plantImageLabel.image = UIImage(named: "OrangeTree1")
                case 48:
                    plantImageLabel.image = UIImage(named: "OrangeTree2")
                case 64:
                    plantImageLabel.image = UIImage(named: "OrangeTree3")
                case 80:
                    plantImageLabel.image = UIImage(named: "OrangeTree4")
                case 96:
                    plantImageLabel.image = UIImage(named: "OrangeTree5")
                case 112:
                    plantImageLabel.image = UIImage(named: "OrangeTree6")
                case 128:
                    plantImageLabel.image = UIImage(named: "OrangeTree7")
                case 144:
                    plantImageLabel.image = UIImage(named: "OrangeTree8")
                case 160:
                    plantImageLabel.image = UIImage(named: "OrangeTree9")
                default:
                    plantImageLabel.image = UIImage(named: "OrangeTree0")
                }
                
            }
            
            
            //if settings is set to ten days, tending is on, can die, and inside
            if plantGrowthLength == 0 && tend == 0 && wither == 0 && housePlant == 0{
                switch diffInDays {
                case 1:
                    //one day has passed
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree1")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 2:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree2")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 3:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree3")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 4:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree4")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 5:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree5")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 6:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree6")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 7:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree7")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 8:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree8")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 9:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree9")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                default:
                    plantImageLabel.image = UIImage(named: "OrangeTree0")
                }
                
            }
            
            //if settings is set to 20 days, tending is on, can die, and inside
            if plantGrowthLength == 1 && tend == 0 && wither == 0 && housePlant == 0{
                switch diffInDays {
                case 4:
                    //one day has passed
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree1")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 6:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree2")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 8:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree3")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 10:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree4")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 12:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree5")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 14:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree6")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 16:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree7")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 18:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree8")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 20:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree9")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                default:
                    plantImageLabel.image = UIImage(named: "OrangeTree0")
                }
                
            }
            
            //if settings is set to 40 days, tending is on, can die, and inside
            if plantGrowthLength == 2 && tend == 0 && wither == 0 && housePlant == 0{
                switch diffInDays {
                case 8:
                    //one day has passed
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree1")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 12:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree2")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 16:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree3")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 20:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree4")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 24:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree5")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 28:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree6")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 32:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree7")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 36:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree8")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 40:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree9")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                default:
                    plantImageLabel.image = UIImage(named: "OrangeTree0")
                }
                
            }
            
            
            //if settings is set to 80 days, tending is on, can die, and inside
            if plantGrowthLength == 3 && tend == 0 && wither == 0 && housePlant == 0{
                switch diffInDays {
                case 16:
                    //one day has passed
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree1")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 24:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree2")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 32:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree3")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 40:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree4")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 48:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree5")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 56:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree6")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 64:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree7")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 72:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree8")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 80:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree9")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                default:
                    plantImageLabel.image = UIImage(named: "OrangeTree0")
                }
                
            }
            
            //if settings is set to 160 days, tending is on, can die, and inside
            if plantGrowthLength == 4 && tend == 0 && wither == 0 && housePlant == 0{
                switch diffInDays {
                case 32:
                    //one day has passed
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree1")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 48:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree2")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 64:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree3")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 80:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree4")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 96:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree5")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 112:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree6")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 128:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree7")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 144:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree8")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                case 160:
                    if didWater == true{
                        plantImageLabel.image = UIImage(named: "OrangeTree9")
                    } else if didWater == false {
                        withering += 1
                        //ADD WITHERING TREE IMAGES
                       //DONT FORGET
                    }
                default:
                    plantImageLabel.image = UIImage(named: "OrangeTree0")
                }
                
            }
            
            
            //IF IT
            if withering == 8 {
                //REPLACE WITH DEAD STICK LEAVES ON GROUND
                plantImageLabel.image = UIImage(named: "OrangeTree0")

            }
            
            
            
            
            
            
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
    
    
    
    
    
    @IBAction func locationButton(_ sender: Any) {
        //using the cclocation button causes a bug crash :(
        if locationInfo.isEmpty == false{
            for i in locationInfo{
                searchInput = i.locationString
                parseJson()
                reloadDataInputs()
                daysCollectionView.reloadData()
            }
        } else if locationInfo.isEmpty == true{
            let alert = UIAlertController(title: "You Did Not Allow Location", message: "Please Enter Valid City or Postal Code In Search Bar \nOr Go Into Settings And Allow Mindful Weather To Access Location.", preferredStyle: .alert)
            
            //go back without doing anything
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindToFirst(_ unwindSegue: UIStoryboardSegue) {
        guard let plantVC = unwindSegue.source as? PlantSettingsViewController else {return}
       // guard let threeHourVC = unwindSegue.source as? ThreeHourViewController else {return}
        
        plantVC.growthSwitch.selectedSegmentIndex = plantGrowthLength
        plantVC.tendPlantSwitch.selectedSegmentIndex = tend
        plantVC.plantDeathSwitch.selectedSegmentIndex = wither
        plantVC.plantLocationSwitch.selectedSegmentIndex = housePlant
        
        
        guard let savedVC = unwindSegue.source as? SavedPlantsViewController else {return}
        
        savedVC.plantImage = plantImage
        savedVC.plantLocationImage = plantLocationImage
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoPlant" {
            guard let plantVC = segue.destination as? PlantSettingsViewController else {return}
            //guard let threeHourVC = segue.destination as? ThreeHourViewController else {return}
            
            userDefaultsSavedInfo()
            plantVC.settingsRef = settingsRef
            plantVC.plantImage = plantImage
            plantVC.plantLocationImage = plantLocationImage
            
            
        }
        
    }
    
}


   

  extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return dailyWeather.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          guard let cell = daysCollectionView.dequeueReusableCell(withReuseIdentifier: "cell_ID_1", for: indexPath) as? CollectionViewCell else {return daysCollectionView.dequeueReusableCell(withReuseIdentifier: "cell_ID_1", for: indexPath)}
          
          if dailyWeather.isEmpty != true{
              cell.dayLabel.text = dailyWeather[indexPath.row].dateString
              cell.imageLabel.image = dailyWeather[indexPath.row].imageProperty
              cell.avgTemp.text = dailyWeather[indexPath.row].tempString
              cell.humidityLabel.text = dailyWeather[indexPath.row].humidityString
              cell.descLabel.text = dailyWeather[indexPath.row].dailyDesc
          }
        return cell
    }
    
    
    
    
    
}
