//
//  AddPlaceVC.swift
//  FoursquareClone
//
//  Created by Zeynep Bayrak Demirel on 11.05.2023.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var placeAtmosphereText: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        
        
        if placeNameText.text != "" && placeTypeText.text != "" && placeAtmosphereText.text != "" {
            if let chosenImage = placeImageView.image {
                
                PlaceModel.sharedInstance.placeName = placeNameText.text!
                PlaceModel.sharedInstance.placeType = placeTypeText.text!
                PlaceModel.sharedInstance.placeAtmosphere = placeAtmosphereText.text!
                PlaceModel.sharedInstance.placeImage = chosenImage
            }
            self.performSegue(withIdentifier: "toMapVC", sender: nil)
        }else {
         
            let alert = UIAlertController(title: "Error", message: "Place Name / Type / Atmosphere ??", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @objc func chooseImage () {
    
        let picker = UIImagePickerController ()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    //fotografı seçtikten sonra onu ekranda imageView da göstericez
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
