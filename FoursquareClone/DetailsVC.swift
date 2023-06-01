//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Zeynep Bayrak Demirel on 23.05.2023.
//

import UIKit
import MapKit
import Parse
class DetailsVC: UIViewController {
    
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsTypeLabel: UILabel!
    @IBOutlet weak var detailsAtmosphereLabel: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    
    var chosenPlaceID = "" //bunu alıp diğer tarafta PlacesVC'de seçilen ID'ye eşitleyeceğiz
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceID) //Parseteki objectId'si chosenPlaceId'ye eşit olanları getir sadece
        query.findObjectsInBackground { objects, error in
            if error != nil {
                
            }else{
                print(objects)
            }
        }
    }


}
