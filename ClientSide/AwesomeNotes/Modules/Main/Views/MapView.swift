//
//  MapView.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 17/08/2023.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapView: UIViewRepresentable {
    @State private var currentLocation: CLLocationCoordinate2D?
    var centerCoordinate: CLLocationCoordinate2D
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.region = MKCoordinateRegion(center: centerCoordinate,
                                            span: MKCoordinateSpan(latitudeDelta: Constants.latitudeDelta,
                                                                   longitudeDelta: Constants.longituteDelta))
        

        let annotation = MKPointAnnotation()
        annotation.title = "You are here."
        annotation.coordinate = centerCoordinate
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
}

extension MapView {
    struct Constants {
        static let latitudeDelta: CGFloat = 0.05
        static let longituteDelta: CGFloat = 0.05
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: CLLocationCoordinate2D())
    }
}
