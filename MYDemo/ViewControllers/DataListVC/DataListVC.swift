//
//  DataListVC.swift
//  MYDemo
//
//  Created by mac on 20/05/19.var
//  Copyright © 2019 mhn. All rights reserved.
//

import UIKit
import CoreData

class DataListVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblView: UITableView!
    var arrList = [NSManagedObject]()
    let nscontext = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        
        do {
            let results = try nscontext.fetch(fetchRequest) as! [NSManagedObject]
            
            arrList = results
            tblView.reloadData()
           
           
        } catch  {
            
        }
        
    
    }
 // MARK: -
   
    @IBAction func actionAdd(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewVC") as! AddNewVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        let obj = arrList[indexPath.row]
        
        cell.textLabel?.text = "\(obj.value(forKey: "name") ?? "")"
        cell.detailTextLabel?.text = "\(obj.value(forKey: "contact") ?? "")"
        if let data = obj.value(forKey: "image") as? Data {
            cell.imageView?.image = UIImage(data: data)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateVC") as! UpdateVC
        vc.dict = arrList[indexPath.row]

        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let obj = arrList[indexPath.row]

         
            
            do {
                try nscontext.delete(obj)
                
            }catch   {
                
            }
            
            
          
        }
    }
//     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.editingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == .delete) {
//
//
//        }
//    }
}
