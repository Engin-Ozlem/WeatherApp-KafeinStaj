//
//  CurrentWeather.swift
//  HavaDurumuDeneme
//
//  Created by macbookair on 17.08.2022.
//

import Foundation
import UIKit
 
struct CurrentWeather {
    
    let temperature : Double // Sıcaklık
    let precipProbability : Double // yağmur yağma olasılığı
    let summary : String // özet bilgi
    let humidity : Double // nem oranı
    let icon : String
    
}

extension CurrentWeather {
    
    var iconImage : UIImage {
        
        switch icon {
            
        case "clear-day" : UIImage(imageLiteralResourceName: "clear-day")
        case "clear-night" : UIImage(imageLiteralResourceName: "clear-night")
        case "rain" : UIImage(imageLiteralResourceName: "rain")
        case "snow" : UIImage(imageLiteralResourceName: "snow")
        case "sleet" : UIImage(imageLiteralResourceName: "sleet")
        case "wind" : UIImage(imageLiteralResourceName: "wind")
        case "fog" : UIImage(imageLiteralResourceName: "fog")
        case "cloudly" : UIImage(imageLiteralResourceName: "cloudly")
        case "partly-cloudly-day" : UIImage(imageLiteralResourceName: "partly-cloudly-day")
        case "partly-cloydly-night" : UIImage(imageLiteralResourceName: "partly-cloudly-night")
        default :  UIImage(imageLiteralResourceName: "default")
            
        }
        return iconImage
    }
    
}


