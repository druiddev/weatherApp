//
//  GeocodingEX.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/6/22.
//

import Foundation

extension ViewController {

    //http://api.openweathermap.org/geo/1.0/reverse?lat={lat}&lon={lon}&limit={limit}&appid={API key}
    
    func reverseGeocoding(atURL urlString: String) {
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
                                  let city = object["name"] as? String,
                                    let state = object["state"] as? String
                            else {return}
                            
                            self.locationInfo.append(Location(city: city, state: state))
                                
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

