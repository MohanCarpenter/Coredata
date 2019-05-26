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
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataListCell") as! DataListCell
        
        //(style: UITableViewCellStyle.value1, reuseIdentifier: "DataListCell")
        let obj = arrList[indexPath.row]
        
        cell.lblName?.text = "\(obj.value(forKey: "name") ?? "")"
        // cell.detailTextLabel?.text = "\(obj.value(forKey: "contact") ?? "")"
        if let data = obj.value(forKey: "image") as? Data {
            cell.imgImage.image = UIImage(data: data)
        }
        cell.btnSelect.tag = indexPath.row
        cell.btnSelect.addTarget(self, action:  #selector(self.actionSelectInfo(bnt:)) , for: .touchUpInside)
        return cell
    }
    
    @objc func actionSelectInfo(bnt:UIButton)  {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoVC") as! InfoVC
        vc.dict = arrList[bnt.tag]
        
        self.navigationController?.pushViewController(vc, animated: true)

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
