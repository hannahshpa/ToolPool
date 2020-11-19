//
//  MapView.swift
//  ToolPool
//
//  Created by Giovanni Moya on 10/30/20.
//
import Foundation
import SwiftUI
import MapKit

class Coordinator: NSObject, MKMapViewDelegate {
    var control: MapView
    init(_ control: MapView) {
        self.control = control
    }
    // initializes map to view of user's location
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        if let annotationView = views.first {
            if let annotation = annotationView.annotation {
                if annotation is MKUserLocation {
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000,
                                                    longitudinalMeters: 1000)
                    mapView.setRegion(region, animated: true)
                }
            }
        }
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("selected annotation")
        guard let annotation = view.annotation else {
            return
        }
        
        let source = MKMapItem.forCurrentLocation()
        source.name = "Source"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: annotation.coordinate))
        destination.name = "Destination"
        
        MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])

    }
    

}

struct MapView: UIViewRepresentable {
    // stores tool object which defines names, location, etc
    let tools: [Tool]


    func makeUIView(context: Context) -> MKMapView {
        // initializes MapUI
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
    }

    func makeCoordinator() -> Coordinator {
        // handles Map UI interactions, like scrolling in, clicking, zooming in.
        Coordinator(self)
    }

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        // is called whenever need to update UI
        updateAnnotation(from: uiView)
    }

    private func updateAnnotation(from mapView: MKMapView) {
        // redraws annotations when new annotations are available
        mapView.removeAnnotations(mapView.annotations)
        let annotations = self.tools.map(ToolAnnotation.init)
        mapView.addAnnotations(annotations)
    }

}

//
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
