//
//  Tool.swift
//  ToolPool
//
//  Created by Giovanni Moya on 11/18/20.
//

import Foundation
import MapKit

struct ToolModel {
    
    var placemark: MKPlacemark// = MKPlacemark()
    var name: String
    var title: String
    var coordinate: CLLocationCoordinate2D
    
    init(name: String, title: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.title = title
        self.coordinate = coordinate
        self.placemark = MKPlacemark(coordinate: coordinate)// = coordinate
    }
    
    

    //TODO: remove, don't need
//    var id: UUID {
//        return UUID()
//    }
    
//    var name: String {
//        self.placemark.name ?? ""
//    }
//
//    var title: String {
//        self.placemark.title ?? ""
//    }
//
//    var coordinate: CLLocationCoordinate2D {
//        self.placemark.coordinate
//    }
}
