//
//  ToolAnnotation.swift
//  ToolPool
//
//  Created by Giovanni Moya on 11/18/20.
//

//displays annotation on the map
import Foundation
import MapKit
import UIKit

// inherits from annotation class so this is an actual annotation
final class ToolAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(tool: ToolModel) {
        self.title = tool.name
        self.coordinate = tool.coordinate
    }
}
