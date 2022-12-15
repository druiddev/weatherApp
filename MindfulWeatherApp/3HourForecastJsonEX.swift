//
//  WeatherInfoEX.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/2/22.
//

import Foundation


extension ThreeHourViewController{
    
    //405db7bf13ea449a2506f66752e029b5
    //api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}
    
    
    func weatherInformation(atURL urlString: String) { 
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        if let validURL = URL(string: urlString) {
            
            let task = session.dataTask(with: validURL, completionHandler: { [self] (opt_data, opt_response, opt_error) in
                
                //Bail Out on error
                if opt_error != nil { assertionFailure(); return }
                
                //Check the response, statusCode, and data
                guard let response = opt_response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let data = opt_data
                else { assertionFailure(); return
                }
        
        
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                    guard let jsonObj = json else {print("Parse Failed"); return}
                    //first level
                    if let list = jsonObj["list"] as? [[String: Any]]{
                        for info in list {
                            guard let main = info["main"] as? [String: Any]
                            else {continue}
                                guard let temp = main["temp"] as? Double,
                                      let minTemp = main["temp_min"] as? Double,
                                      let maxTemp = main["temp_max"] as? Double,
                                      let humidity = main["humidity"] as? Int
                                else {continue}
                                
                                guard let weather = info["weather"] as? [[String: Any]]
                                else {continue}
                                for w in weather {
                                    guard let id = w["id"] as? Int,
                                          let mainDesc = w["main"] as? String,
                                          let desc = w["description"] as? String,
                                          let icon = w["icon"] as? String
                                    else {continue}
                                guard let date = info["dt_txt"] as? String
                                else {continue}
                                    weatherInfo.append(WeatherInfo(temp: temp, humidity: humidity, minTemp: minTemp, maxTemp: maxTemp, weatherID: id, mainDescription: mainDesc, description: desc, iconID: icon, date: date))
                                    
                                    
                                }
                            }
                        }
                    }
                
                catch {
                    print(error.localizedDescription)
                    assertionFailure();
                }
                
                DispatchQueue.main.async {
                    self.threeHourCollectionView.reloadData()
                }
                
                
                
            })
            task.resume()
        }
    }
    
    func astrologyParsing(atURL urlString: String){
        
        
        //API Key: 5e27e4e054a04ba8b83220852221412
        //https://api.weatherapi.com/v1/forecast.json?key=5e27e4e054a04ba8b83220852221412&q=16648&days=10&aqi=no&alerts=no

            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            if let validURL = URL(string: urlString) {

                let task = session.dataTask(with: validURL, completionHandler: { [self] (opt_data, opt_response, opt_error) in

                    //Bail Out on error
                    if opt_error != nil { assertionFailure(); return }

                    //Check the response, statusCode, and data
                    guard let response = opt_response as? HTTPURLResponse,
                          response.statusCode == 200,
                          let data = opt_data
                    else { assertionFailure(); return
                        
                    }
            
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                        guard let jsonObj = json else {print("Parse Failed"); return}

                            guard let loc = jsonObj["location"] as? [String: Any],
                                  let lat = loc["lat"] as? Double,
                                  let lon = loc["lon"] as? Double
                            else {return}
                            guard let forecast = jsonObj["forecast"] as? [String: Any]
                            else {return}
                            if let day = forecast["forecastday"] as? [[String: Any]]{
                                for dayInfo in day{
                                    guard let date = dayInfo["date"] as? String
                                    else {continue}
                                    guard let day = dayInfo["day"] as? [String: Any]
                                    else {continue}
                                    guard let astro = dayInfo["astro"] as? [String: Any],
                                          let sunrise = astro["sunrise"] as? String,
                                          let sunset = astro["sunset"] as? String,
                                          let moonrise = astro["moonrise"] as? String,
                                          let moonset = astro["moonset"] as? String,
                                          let moonPhase = astro["moon_phase"] as? String
                                    else {continue}
                                
                                    self.astrology.append(Astrology(sunrise: sunrise, sunset: sunset, moonrise: moonrise, moonset: moonset, moonPhase: moonPhase, lat: lat, lon: lon))
                                   
                                }
                            }
                        }
                    catch {
                        print(error.localizedDescription)
                        assertionFailure();
                    }
                    
                    DispatchQueue.main.async {
                        self.astrologyCollectionView.reloadData()
                    }
                })
                task.resume()
            }
        }
    }





