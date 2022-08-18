//
//  CurrentWeatherModel.swift
//  HavaDurumuDeneme
//
//  Created by macbookair on 17.08.2022.
//

import Foundation
import UIKit

struct CurrentWeatherModel {
    let temperature : String // Sıcaklık
    let precipitationProbability : String // yağmur yağma olasılığı
    let summary : String // özet bilgi
    let humidity : String // nem oranı
    let icon : UIImage
    
    init (data : CurrentWeather){
        self.summary = data.summary
        self.icon = data.iconImage
        self.precipitationProbability = "% \(data.precipProbability * 100)"
        self.temperature = "\(Int(data.temperature))"
        self.humidity = "%\(Int(data.humidity*100))"
 
    }
}

