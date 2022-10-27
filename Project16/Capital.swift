//
//  Country.swift
//  Project16
//
//  Created by Derya Antonelli on 27/10/2022.
//

import Foundation
import MapKit

class Capital: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let info: String
    
    init(title: String?, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
