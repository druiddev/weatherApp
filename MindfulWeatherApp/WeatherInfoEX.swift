//
//  WeatherInfoEX.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/2/22.
//

import Foundation


extension ViewController {
    
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
                            //second level
                            guard let temp = info["temp"] as? Double,
                                  let minTemp = info["temp_min"] as? Double,
                                  let maxTemp = info["temp_max"] as? Double,
                                  let humidity = info["humidity"] as? Double
                            else {continue}
                            guard let weather = info["weather"] as? [[String: Any]]
                            else {continue}
                            for w in weather {
                                guard let id = w["id"] as? Int,
                                      let mainDesc = w["main"] as? String,
                                      let desc = w["description"] as? String,
                                      let icon = w["icon"] as? String
                                else {continue}
                                
                                weatherInfo.append(WeatherInfo(temp: temp, humidity: humidity, minTemp: minTemp, maxTemp: maxTemp, weatherID: id, mainDescription: mainDesc, description: desc, iconID: icon))
                                print(weatherInfo)
                                
                            }
                        }
                    }
                }
                catch {
                    print(error.localizedDescription)
                    assertionFailure();
                }

                DispatchQueue.main.async {
                    self.daysCollectionView.reloadData()
                }
                
                
                
            })
            task.resume()
        }
    }
}
    
    
