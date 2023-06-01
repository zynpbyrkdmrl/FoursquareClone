//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Zeynep Bayrak Demirel on 24.05.2023.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel () //paylaşılan bir obje, kim kullanırsa kullansın bu objeyi elde edecek.
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage ()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init () {} // başka hiçbir yerden initializing işleminin yapılamayacagını belirtmiş olduk
    
    
}
