//
//  ViewController.swift
//  MovieAlbum
//
//  Created by 성기훈 on 2022/02/07.
//

import UIKit
import CoreData
import MobileCoreServices
import UniformTypeIdentifiers

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imgView: UIImageView!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var arrPhotos: [Photo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLoadImageFromLibrary(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [UTType.image.identifier as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: UTType.image.identifier as NSString as String) {
            imgView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveImageButtonPressed(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context) as! Photo
        let jpeg = imgView.image?.jpegData(compressionQuality: 1.0)
        photo.image = jpeg
        
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func retrieveButtonPressed(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        
        do {
            arrPhotos = try context.fetch(fetchRequest) as? [Photo]
            
            if let photo = arrPhotos?.last {
                imgView.image = UIImage(data: photo.image!)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
