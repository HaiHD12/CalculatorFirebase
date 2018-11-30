//
//  Weather.swift
//  HW3-Solution
//
//  Created by Hai Duong on 11/28/18.
//  Copyright © 2018 Jonathan Engelsma. All rights reserved.
//

import Foundation

struct Weather {
    var iconName : String
    var temperature : Double
    var summary : String
    
    init(iconName: String, temperature: Double, summary: String) {
        self.iconName = iconName
        self.temperature = temperature
        self.summary = summary
    }
}

protocol WeatherService {
    func getWeatherForDate(date: Date, forLocation location: (Double, Double),
                           completion: @escaping (Weather?) -> Void)
}
