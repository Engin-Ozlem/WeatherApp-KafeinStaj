//
//  DetailViewController.swift
//  HavaDurumuDeneme
//
//  Created by macbookair on 8.08.2022.
//

import UIKit



class DetailViewController: UIViewController {

    var sehir = String()
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var havaDurumu: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityName.text = sehir
        gunSonuc(cityName: sehir)
    }
    
    override func viewWillAppear(_ animated: Bool) { // navigation controller açıyoruz
        self.navigationController?.navigationBar.isHidden = false
        
    }

    func gunSonuc(cityName : String) {
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=9f36590ead3fc947b0d7abee65e9d830"){
            
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) {(data , response , error) in
                
                if error == nil {
                    
                    if let incomingData = data {
                        
                        do{
                            let json = try JSONSerialization.jsonObject(with: incomingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            
                            
                            if let main = json["main"] as? NSDictionary {
                                
                                if let temp = main["temp"] as? Double {
                                    let state = Int(temp - 273.15) //  hava durumunu santigirad dereceden alma
                                    
                                    DispatchQueue.main.sync {
                                        self.havaDurumu.text = String(state)
                                    }
                                }
                                
                            }
                            
                        }catch{
                            print("Bir Hata Oluştu")
                        }
                        
                        
                    }
                    
                }
                
            }
            task.resume()
        }
    }
    
}
