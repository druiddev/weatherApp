//
//  CurrentWeatherJsonEX.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/10/22.
//

import Foundation

extension ViewController{
    //API Key: 5e27e4e054a04ba8b83220852221412
    //https://api.weatherapi.com/v1/forecast.json?key=5e27e4e054a04ba8b83220852221412&q=16648&days=10&aqi=no&alerts=no

    
    
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
        
        
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        if let validURL = URL(string: urlString) {
//            var request = URLRequest(url: validURL)
//            //taking API key given by propublica website
//            request.setValue("5e27e4e054a04ba8b83220852221412", forHTTPHeaderField: "X-API-Key")
//            request.httpMethod = "GET"
//            let task = session.dataTask(with: request, completionHandler: {(opt_data, opt_response, opt_error) in
//
//                if opt_error != nil { assertionFailure(); return }
//
//                //Check the response, statusCode, and data
//                guard let response = opt_response as? HTTPURLResponse,
//                      response.statusCode == 200,
//                      let data = opt_data
//                else { assertionFailure(); return
//                }
//
                
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                    guard let jsonObj = json else {print("Parse Failed"); return}

                        guard let loc = jsonObj["location"] as? [String: Any],
                              let city = loc["name"] as? String,
                              let state = loc["region"] as? String,
                              let country = loc["country"] as? String,
                              let lat = loc["lat"] as? Double,
                              let lon = loc["lon"] as? Double
                        else {return}
                        
                        guard let current =  jsonObj["current"] as? [String: Any],
                              let temp = current["temp_f"] as? Double,
                              let condition = current["condition"] as? [String: Any],
                              let desc = condition["text"] as? String,
                              let icon = condition["icon"] as? String,
                              let code = condition["code"] as? Int,
                              let inchesOfRain = current["precip_in"] as? Double,
                              let humidity = current["humidity"] as? Int
                        else {return}
                        guard let forecast = jsonObj["forecast"] as? [String: Any]
                        else {return}
                        if let day = forecast["forecastday"] as? [[String: Any]]{
                            for dayInfo in day{
                                guard let date = dayInfo["date"] as? String
                                else {continue}
                                guard let day = dayInfo["day"] as? [String: Any],
                                      let avgTemp = day["avgtemp_f"] as? Double,
                                      let totalPrecip = day["totalprecip_in"] as? Double,
                                      let totalSnow = day["totalsnow_cm"] as? Double,
                                      let avgHumidity = day["avghumidity"] as? Double
                                else {continue}
                                guard let dayCondition = day["condition"] as? [String: Any],
                                      let dayDesc = dayCondition["text"] as? String,
                                      let dayIcon = dayCondition["icon"] as? String,
                                      let dayCode = dayCondition["code"] as? Int
                                else {continue}
                                guard let astro = dayInfo["astro"] as? [String: Any],
                                      let sunrise = astro["sunrise"] as? String,
                                      let sunset = astro["sunset"] as? String,
                                      let moonrise = astro["moonrise"] as? String,
                                      let moonset = astro["moonset"] as? String,
                                      let moonPhase = astro["moon_phase"] as? String
                                else {continue}
                            
                                self.dailyWeather.append(DailyWeather(city: city, state: state, country: country, lat: lat, lon: lon, currentTemp: temp, currentDesc: desc, currentIcon: icon, currentWeatherCode: code, currentRainInInches: inchesOfRain, currentHumidity: humidity, date: date, dailyTemp: avgTemp, dailyRainTotal: totalPrecip, dailySnowTotal: totalSnow, dailyHumidity: avgHumidity, dailyDesc: dayDesc, dailyIcon: dayIcon, dailyWeatherCode: dayCode, sunrise: sunrise, sunset: sunset, moonrise: moonrise, moonset: moonset, moonPhase: moonPhase))
                                print(self.dailyWeather.count)
                            }
                        }
                    }
                catch {
                    print(error.localizedDescription)
                    assertionFailure();
                }
                
                DispatchQueue.main.async {
                    self.daysCollectionView.reloadData()
                    self.reloadDataInputs()
                }
            })
            task.resume()
        }
    }
}








            //                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
            //                    guard let jsonObj = json else {print("Parse Failed"); return}
            //                    //first level
            //                    if let list = jsonObj["list"] as? [[String: Any]]{
            //                        for info in list {
            //                            guard let main = info["main"] as? [String: Any]
            //                            else {continue}
            //                            guard let temp = main["temp"] as? Double,
            //                                  let humidity = main["humidity"] as? Int
            //                            else {continue}
            //
            //                            guard let weather = info["weather"] as? [[String: Any]]
            //                            else {continue}
            //                            for w in weather {
            //                                guard let id = w["id"] as? Int,
            //                                      let mainDesc = w["main"] as? String,
            //                                      let desc = w["description"] as? String,
            //                                      let icon = w["icon"] as? String
            //                                else {continue}
            //                                guard let date = info["dt_txt"] as? String
            //                                else {continue}
            //
            //                                guard let city = jsonObj["city"] as? [String: Any],
            //                                      let sunrise = city["sunrise"] as? Int,
            //                                      let sunset = city["sunset"] as? Int
            //                                else {continue}
            //
            //
            //                                dailyWeather.append(DailyWeather(temp: temp, humidity: humidity, weatherID: id, mainDescription: mainDesc, description: desc, iconID: icon, date: String(date.dropFirst(5).dropLast(9)), sunrise: sunrise, sunset: sunset))
            //
