//
//  searchEX.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/13/22.
//

import Foundation

extension TableViewController{
    
    //http://api.openweathermap.org/geo/1.0/zip?zip={zip code},{country code}&appid={API key}
    
    
    func ZipGeocoding(atURL urlString: String) {
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
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                    if let jsonObj = json{
                        for firstLevelItem in jsonObj {
                            guard let object = firstLevelItem as? [String: Any],
                                    let zip = object["zip"] as? String,
                                    let name = object["name"] as? String,
                                    let lat = object["lat"] as? Double,
                                    let lon = object["lon"] as? Double,
                                    let country = object["country"] as? String
                            else {return}
                            
                            
                            self.zipsArray.append(Zip(zip: zip, name: name, lat: lat, lon: lon, country: country))
                                
                        }
                    }
                }
                catch {
                    print(error.localizedDescription)
                    assertionFailure();
                }

                
            })
            task.resume()
        }
    }
}
    
