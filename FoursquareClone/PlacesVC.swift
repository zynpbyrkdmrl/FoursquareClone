//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Zeynep Bayrak Demirel on 5.05.2023.
//

import UIKit
import Parse

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var tableView: UITableView!
    
    var placeNameArray = [String]()
    var placeIDArray = [String]()
    var selectedPlaceID = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // sağ tarafa + ekleme
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        //sol tarafa logout ekleme
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromParse()
    }
    
    func getDataFromParse () {
        let query = PFQuery (className: "Places")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message:error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else {
                if objects != nil {
                    //tekrarlar olmasın diye
                    self.placeNameArray.removeAll()
                    self.placeIDArray.removeAll()
                    
                    for object in objects!{
                        if let placeName = object.object(forKey: "name") as? String {
                            if let placeID = object.objectId {
                                self.placeNameArray.append(placeName)
                                self.placeIDArray.append(placeID)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
            }
        }
        

    @objc func addButtonClicked () {
        self.performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
        
    }
    
    @objc func logoutButtonClicked () {
        PFUser.logOutInBackground { (error) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message:error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else {
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC //bunu yaparak detailsVCdeki değişkenlere ulaşabileceğiz.
            destinationVC.chosenPlaceID = selectedPlaceID
            
        }
    }
    
    //bir rowa tıklandıgında ne yapacagımız.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceID = placeIDArray[indexPath.row] //hangi indexe tıklandıysa onu selectedPlaceIDye eşitle
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = placeNameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    

}
