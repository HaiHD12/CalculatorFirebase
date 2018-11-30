//
//  DarkSkyWeatherService.swift
//  HW3-Solution
//
//  Created by Hai Duong on 11/28/18.
//  Copyright © 2018 Jonathan Engelsma. All rights reserved.
//

import Foundation

let sharedDarkSkyInstance = DarkSkyWeatherService()

class DarkSkyWeatherService: WeatherService {
    
    let API_BASE = "https://api.darksky.net/forecast/"
    var urlSession = URLSession.shared
    
    class func getInstance() -> DarkSkyWeatherService {
        return sharedDarkSkyInstance
    }
    
    func getWeatherForDate(date: Date, forLocation location: (Double, Double),
                           completion: @escaping (Weather?) -> Void)
    {
        let DARK_SKY_WEATHER_API_KEY = "ADD KEY TOKEN HERE FROM URL HERE"
        let x = "ENTER X LATITUDE COORDINATE HERE"
        let y = "ENTER Y LONGITUDE CORDINATE HERE"
        let urlStr = API_BASE +  DARK_SKY_WEATHER_API_KEY + x + "," + y
        let url = URL(string: urlStr)
        
        let task = self.urlSession.dataTask(with: url!) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let _ = response {
                let parsedObj : Dictionary<String,AnyObject>!
                do {
                    parsedObj = try JSONSerialization.jsonObject(with: data!, options:
                        .allowFragments) as? Dictionary<String,AnyObject>
                    
                    guard let currently = parsedObj["currently"],
                            let summary = currently["summary"] as? String,
                            let iconName = currently["icon"] as? String,
                            let temperature = currently["temperature"] as? Double
                    // TODO: extract the attributes you need for a Weather instance HERE
                    
                    else {
                        completion(nil)
                        return
                    }
                    
                    let weather = Weather(iconName: iconName, temperature: temperature,
                                          summary: summary)
                    completion(weather)
                    
                }  catch {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
}
