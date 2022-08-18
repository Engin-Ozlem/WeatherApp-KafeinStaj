//
//  DetailViewController.swift
//  HavaDurumuDeneme
//
//  Created by macbookair on 8.08.2022.
//

import UIKit



class DetailViewController: UIViewController {

    var sehir = String() //Boş bir string başlatıyoruz
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var havaDurumu: UILabel!
    @IBOutlet weak var nemOrani: UILabel!
    @IBOutlet weak var ruzgarHizi: UILabel!
    @IBOutlet weak var sunOrCloud: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        cityName.text = sehir //Gelen bir önce ki sehir verisini buraya aktarıyoruz
        gunSonuc(cityName: sehir)
    }
    
    override func viewWillAppear(_ animated: Bool) { // navigation controller açıyoruz
        self.navigationController?.navigationBar.isHidden = false
        
    }

    func gunSonuc(cityName : String) {  //Api islemleri
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=9f36590ead3fc947b0d7abee65e9d830"){
            
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { [self](data , response , error) in
                
                if error == nil {
                    
                    if let incomingData = data {
                        
                        do{
                            let json = try JSONSerialization.jsonObject(with: incomingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            
                            
                            if let main = json["main"] as? NSDictionary {
                                
                                if let temp = main["temp"] as? Double {
                                    let state = Int(temp - 273.15) //  hava durumunu santigirad dereceden alma
                                    
                                    DispatchQueue.main.sync {
                                        self.havaDurumu.text = String("\(state)°C")
                                        if state > 17 {
                                            self.sunOrCloud.image = UIImage(named: "Sun")
                                        }else {
                                            self.sunOrCloud.image = UIImage(named: "SunCloud")
                                        }
                                    }
                                }
                                
                            }
                            
                            
                            if let main = json["main"] as? NSDictionary { //Nem Oranını alma
                                
                                if let temp = main["humidity"] as? Double {
                                    let nem = Int(temp)
                                    
                                    DispatchQueue.main.sync {
                                        self.nemOrani.text = String("% \(nem)")
                                    }
                                }
                                
                            }
                            
                            if let main = json["wind"] as? NSDictionary { //Rüzgar Hızını Alma
                                
                                if let temp = main["speed"] as? Double {
                                    let speed = Double(temp)
                                    
                                    DispatchQueue.main.sync {
                                        self.ruzgarHizi.text = String("\(speed) Km/s")
                                        
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
