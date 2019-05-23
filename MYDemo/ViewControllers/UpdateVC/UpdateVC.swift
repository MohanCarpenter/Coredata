//
//  UpdateVC.swift
//  MYDemo
//
//  Created by mac on 20/05/19.
//  Copyright © 2019 mhn. All rights reserved.
//

import UIKit
import CoreData

class UpdateVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate {
    var dict = NSManagedObject()

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtContactNo: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    let nscontext = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    
    var imgProfilePicture:UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.text = "\(dict.value(forKey: "name") ?? "")"
        txtContactNo.text = "\(dict.value(forKey: "contact") ?? "")"
        if let data = dict.value(forKey: "image") as? Data {
            imgView.image = UIImage(data: data)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func actionOpenGallery(_ sender: UIButton)
    {
        self.view.endEditing(true)
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let camera = "Camera"
        let gallery = "Gallery"
        let cancel = "Cancel"
        
        
        actionSheet.addAction(UIAlertAction(title: camera, style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: gallery, style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: cancel, style: UIAlertActionStyle.cancel, handler: nil))
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = actionSheet.popoverPresentationController {
                popoverController.sourceView = sender as? UIView
                popoverController.sourceRect = (sender as AnyObject).bounds
            }
        }
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func photoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var img:UIImage? = info[UIImagePickerControllerOriginalImage] as? UIImage
        if let iii = info[UIImagePickerControllerEditedImage] as? UIImage {
            img = iii
        }
        if (img != nil) {
            imgProfilePicture = img
            imgView.image = img!
        }
        picker.dismiss(animated: true, completion: nil);
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionBAck(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func INsert(_ sender: UIButton)
    {
       
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        
        request.predicate = NSPredicate(format: "(id = %@)", "\(dict.value(forKey: "id") ?? "")")

        
        do {
            let results = try nscontext.fetch(request)
            let objectUpdate = results[0] as! NSManagedObject
            objectUpdate.setValue(txtName.text!, forKey: "name")
            objectUpdate.setValue(txtContactNo.text!, forKey: "contact")
            if imgProfilePicture != nil {
                if let data = UIImagePNGRepresentation(imgProfilePicture!) {
                    objectUpdate.setValue(data, forKey: "image")
                }
            }
            do {
                try nscontext.save()
                self.navigationController?.popViewController(animated: true)

            }catch   {
                
            }
        }
        catch   {
         }
        
    }
     
    
}

