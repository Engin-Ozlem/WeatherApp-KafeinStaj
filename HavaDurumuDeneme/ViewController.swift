//
//  ViewController.swift
//  HavaDurumuDeneme
//
//  Created by macbookair on 8.08.2022.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    
    @IBOutlet weak var gelenSehirText: UITextField!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var gecmis: UIButton!
    
    
    var gelenSehirVerileri = [String]()
    
    
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
        cell.textLabel?.text = gelenSehirVerileri[indexPath.row]
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) { // navigation controller gizliyoruz
        self.navigationController?.navigationBar.isHidden = true
        gelenSehirText.text = ""
        
    }
    
    
    @IBAction func gecmisBtn(_ sender: UIButton) {
        table.isHidden = true
    }
    
    //verileri kaydetme
    func saveData() {
        UserDefaults.standard.set(gelenSehirVerileri, forKey: "veriler")
    }
    
    func loadData() {
        if let loadData : [String] = UserDefaults.standard.value(forKey: "veriler") as? [String] {
            gelenSehirVerileri = loadData
            table.reloadData()
        }
    }
    
    
    
    @IBAction func btn(_ sender: UIButton) {
        table.isHidden = false
        gecmis.isHidden = false
        let sehir = gelenSehirText.text ?? ""
        gelenSehirVerileri.append(String(sehir))
        
        //ekleme islemi
        let indexPatch = IndexPath(row: gelenSehirVerileri.count - 1, section: 0)
        table.insertRows(at: [indexPatch], with: UITableView.RowAnimation.left)
        saveData()
        
        
        if indexPatch.row == 4 {
            gelenSehirVerileri.removeAll()
            table.reloadData()
            saveData()
            
        }
        
        
        
        
        
        
            
            
        
        
        
        if sehir.isEmpty {
            let alert = UIAlertController(title: "DİKKAT !", message: "Lütfen Sehir Adı giriniz", preferredStyle: .alert)
            
            let iptalBtn = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
            
            alert.addAction(iptalBtn)
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        else {
            let vievController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            
            vievController.sehir = sehir
            
            self.show(vievController, sender: nil)
        
                
            
        }
        
    }
    
    
}

