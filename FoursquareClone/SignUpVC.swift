//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Zeynep Bayrak Demirel on 4.05.2023.
//

import UIKit
import Parse

class SignUpVC: UIViewController {
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //VERİ KAYDETMEK
   /* let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Banana"
        parseObject["calories"] = 150
        parseObject.saveInBackground { success, error in //async olanı tercih ediyoruz, en güvenlisi.
            if error != nil {
                print(error?.localizedDescription)
            }else {
                print("uploaded")
            }
        }*/
        
        //VERİ ÇEKMEK
     /* let query = PFQuery(className: "Fruits")
        //query.whereKey("name", equalTo: "Apple") //ismi elma olanları getir
        query.whereKey("calories", greaterThan: "120")//kalorisi 120den büyük olanları getir
        query.findObjectsInBackground { (objects, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else {
                print(objects)
            }
        }*/
        

    }
    
    
    func makeAlert(titleInput: String, messageInput: String ) {
    
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != "" {
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { (user, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else {
                self.performSegue(withIdentifier: "toPlacesVC", sender:nil)
                }
            }
            
        }else {
            makeAlert(titleInput: "Error", messageInput: "Username / Password??")
        }
    }
    
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != ""{
            
            let user = PFUser()
            user.username = userNameText.text!
            user.password = passwordText.text!
            user.signUpInBackground { succsess, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!")
                }else{
                    self.performSegue(withIdentifier: "toPlacesVC", sender:nil)
                }
            }
            
        }else {
            makeAlert(titleInput: "Error", messageInput: "Username / Password??")
        }
    }
    
    
    
}

