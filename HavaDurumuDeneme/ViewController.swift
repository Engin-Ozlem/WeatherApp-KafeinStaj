//
//  ViewController.swift
//  HavaDurumuDeneme
//
//  Created by Engin Özlem on 8.08.2022.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    
    @IBOutlet weak var gelenSehirText: UITextField! //Baglama islemleri
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var gecmis: UIButton!
    

    
    var gelenSehirVerileri = [String]() //gelen sehir verilerini bir dizide tutuyoruz
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn.layer.cornerRadius = 6 // button köşeleri ayarlandı
        table.isHidden = true
        gecmis.isHidden = true
        //verileri listeleme
        table.dataSource = self
        table.delegate = self
        loadData()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gelenSehirVerileri.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = UITableViewCell()
        cell.textLabel?.text = gelenSehirVerileri[indexPath.row] //verileri indeksine göre alt alta sıralıyoruz
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) { // navigation controller gizliyoruz
        self.navigationController?.navigationBar.isHidden = true
        gelenSehirText.text = ""
        
    }
    
    
    @IBAction func gecmisBtn(_ sender: UIButton) { // Geçmiş butonunu gizleyebiliyoruz
        table.isHidden = true
    }
    
    //verileri kaydetme
    func saveData() {
        UserDefaults.standard.set(gelenSehirVerileri, forKey: "veriler") //user default yapısıyla aldıgımız verileri
                                                                         //table viev da listelemek için saklıyoruz
    }
    
    func loadData() {
        if let loadData : [String] = UserDefaults.standard.value(forKey: "veriler") as? [String] {
            gelenSehirVerileri = loadData
            table.reloadData()
        }
    }
    
    
    
    @IBAction func btn(_ sender: UIButton) {
        table.isHidden = false //table gizliliği açıldı
        gecmis.isHidden = false // geçmiş buton gizliliği açıldı
        let sehir = gelenSehirText.text ?? ""
        gelenSehirVerileri.append(String(sehir))
        
        //ekleme islemi
        let indexPatch = IndexPath(row: gelenSehirVerileri.count - 1, section: 0)
        table.insertRows(at: [indexPatch], with: UITableView.RowAnimation.left)
        saveData()
        
        
        if indexPatch.row == 5 { //Listelenen 5 veriden sonra geçmişi otomatik olarak siliyoruz
            gelenSehirVerileri.removeAll()
            table.reloadData()
            saveData()
            
        }
        
        
        
        
        
        
            
            
        
        
        
        if sehir.isEmpty { //Alert Yapılarımız
            let alert = UIAlertController(title: "DİKKAT !", message: "Lütfen Sehir Adı giriniz", preferredStyle: .alert)
            
            let iptalBtn = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
            
            alert.addAction(iptalBtn)
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        else {
            let vievController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            
            vievController.sehir = sehir
            
            self.show(vievController, sender: nil) // Diğer sayfaya aldığımız veriyi gönderiyoruz
        
                
            
        }
        
    }
    
    
}

