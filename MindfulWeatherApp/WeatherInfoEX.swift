//
//  WeatherInfoEX.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/2/22.
//

import Foundation


extension ViewController {
    
    //API 4b67b62b50878541d1bdb47a7198f731
    //Base API http://api.weatherstack.com/
    
    
    func json(){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        if let validURL = URL(string: "https://api.weatherstack.com/current?access_key=4b67b62b50878541d1bdb47a7198f731&query=NewYork") {
            
            let task = session.dataTask(with: validURL, completionHandler: { (opt_data, opt_response, opt_error) in
                
                //Bail Out on error
                if opt_error != nil { assertionFailure(); return }
                
                //Check the response, statusCode, and data
                guard let response = opt_response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let data = opt_data
                else { assertionFailure(); return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]]
                    guard let jsonObj = json else {print("Parse Failed"); return}
                    for firstLevelItem in jsonObj{
                        guard let request = firstLevelItem["request"] as? [[String: Any]] else {continue};{
                            for result in request {
                                guard
                                    let type = result["type"] as? String,
                                    let query = result["query"] as? String,
                                    let language = result["language"] as? String,
                                    let unit = result["unit"] as? String
                                else {continue}
                                guard let location = firstLevelItem["location"] as? [[String: Any]] else {continue};{
                                    for loc in location {
                                        guard
                                            let name = loc["name"] as? String,
                                            let region = loc["region"] as? String,
                                            let lat = loc["lat"] as? String,
                                            let lon = loc["lon"] as? String,
                                            let timeZone = loc["timezone_id"] as? String
                                        else {continue}
                                        guard let current = firstLevelItem["current"] as? [[String: Any]] else {continue};{
                                            for cur in current {
                                                guard
                                                    let temperature = cur["temperature"] as? Int,
                                                    let weatherCode = cur["weather_code"] as? Int,
                                                    let icon = cur["weather_icons"] as? [String],
                                                    let description = cur["weather_descriptions"] as? [String]
                                                else {continue}
                                                
                                                
                                                
                                                //append the data to the objects
                                                self.weekInfo.append(WeatherInfo.init(unit: unit, city: name, state: region, lat: lat, lon: lon, timeZone: timeZone, temperature: temperature, weatherCode: weatherCode, iconString: icon, description: description))
                                                print(self.weekInfo)
                                            }}}}}}}
                                           } catch {
                                               print(error.localizedDescription)
                                               print("whoops")
                                           }
                                       })
                                       task.resume()
                                   }
                               }
                           }
    
    
    func getWeatherDescription (code : Int) -> String {
        switch code {
        case 113: return "Clear" // or Sunny
        case 116: return "Partly cloudy"
        case 119: return "Cloudy"
        case 122: return "Overcast"
        case 143: return "Mist"
        case 176: return "Patchy rain possible"
        case 179: return "Patchy snow possible"
        case 182: return "Patchy sleet possible"
        case 185: return "Patchy freezing drizzle possible"
        case 200: return "Thundery outbreaks possible"
        case 227: return "Blowing snow"
        case 230: return "Blizzard"
        case 248: return "Fog"
        case 260: return "Freezing fog"
        case 263: return "Patchy light drizzle"
        case 266: return "Light drizzle"
        case 281: return "Freezing drizzle"
        case 284: return "Heavy freezing drizzle"
        case 293: return "Patchy light rain"
        case 296: return "Light rain"
        case 299: return "Moderate rain at times"
        case 302: return "Moderate rain"
        case 305: return "Heavy rain at times"
        case 308: return "Heavy rain"
        case 311: return "Light freezing rain"
        default:
            return "Clear"
        }
    }

// MAKE STRUCT VARIABLES OPTIONAL TO PREVENT CRASHING WHEN VARIABLE IS EMPTY
struct Current : Decodable {
    let observation_time : String?
    let temperature : Int?
    let weather_code : Int?
    let weather_icons : [String?]
    let weather_descriptions : [String?]
    let wind_speed : Int?
    let wind_degree : Int?
    let wind_dir : String?
    let pressure : Int?
    let precip : Double?
    let humidity : Int?
    let cloudcover : Int?
    let feelslike : Int?
    let uv_index : Int?
    let visibility : Int?
}

struct Location : Decodable {
    let name : String?
    let country : String?
    let region : String?
    let lat : String?
    let lon : String?
    let timezone_id : String?
    let localtime : String?
    let localtime_epoch : Int?
    let utc_offset : String?
}

struct Weather : Decodable {
    let request : Request?
    let location : Location?
    let current : Current?
}

struct Request : Decodable {
    let type : String?
    let query : String?
    let language : String?
    let unit : String?
}


