//
//  Tool.swift
//  ToolPool
//
//  Created by Giovanni Moya on 11/18/20.
//

import Foundation
import MapKit

struct Tool {
    
    let placemark: MKPlacemark

    //TODO: remove, don't need
//    var id: UUID {
//        return UUID()
//    }
    
    var name: String {
        self.placemark.name ?? ""
    }

    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
}
