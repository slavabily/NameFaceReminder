//
//  MapView.swift
//  NameFaceReminder
//
//  Created by slava bily on 28/5/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    
    var annotations: [MKPointAnnotation]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if annotations.count != uiView.annotations.count {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(annotations)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // this is our unique identifier for view reuse
            let identifier = "Placemark"
            // attempt to find the cell we can recycle
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                // we don't find one; make new one
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                // alow this to show pop up information
                annotationView?.canShowCallout = true
                // attach the information button to the view
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                // we have a view to reuse, so give it a new annotation
                annotationView?.annotation = annotation
            }
            // whether it's a new view or a recycled one, send it back
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let placeMark = view.annotation as? MKPointAnnotation else { return }
            
            parent.selectedPlace = placeMark
            parent.showingPlaceDetails = true
        }
    }
}

// for preview:
extension CodableMKPointAnnotation {
    static var example: CodableMKPointAnnotation {
        let annotation = CodableMKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to 2012 Summer Olimpics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(CodableMKPointAnnotation.example.coordinate),selectedPlace: .constant(CodableMKPointAnnotation.example), showingPlaceDetails: .constant(false), annotations: [CodableMKPointAnnotation.example])
    }
}

