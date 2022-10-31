//
//  ViewController.swift
//  Project16
//
//  Created by Derya Antonelli on 17/10/2022.
//

import UIKit
import MapKit

extension UIStackView {
    public func roundBorders(corners: UIRectCorner.Element, radius: CGFloat) {
        let corners = UIRectCorner(arrayLiteral: corners)
        
        // Determine the size of the rounded corners
        let cornerRadii = CGSize(width: radius, height: radius)
        
        let maskPath = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: cornerRadii
        )
        
        // Apply the mask layer to the view
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        maskLayer.frame = self.bounds

        self.layer.mask = maskLayer
    }
}

// https://developer.apple.com/documentation/uikit/view_layout

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var ViewButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    @IBAction func updateMapView(_ sender: UIButton) {
        StackView.isHidden = false
//        action here
//        mapView.preferredConfiguration = MKImageryMapConfiguration()
    }
    
    
    
    @IBAction func setNormalMapView(_ sender: UIButton) {
         mapView.preferredConfiguration = MKStandardMapConfiguration()
    }
    
    
    @IBAction func setSatelliteMapView(_ sender: UIButton) {
        mapView.preferredConfiguration = MKHybridMapConfiguration()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        initStackView()
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        mapView.preferredConfiguration = MKImageryMapConfiguration()
       
        // If the annotation isn't from a capital city, it must return nil so iOS uses a default view.
        guard annotation is Capital else { return nil }
        
        // Define a reuse identifier. This is a string that will be used to ensure we reuse annotation views as much as possible.
        let identifier = "Capital"
        
        // Try to dequeue an annotation view from the map view's pool of unused views.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        // If it isn't able to find a reusable view, create a new one using MKPinAnnotationView and sets its canShowCallout property to true. This triggers the popup with the city name.
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            // Create a new UIButton using the built-in .detailDisclosure type. This is a small blue "i" symbol with a circle around it.
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.markerTintColor = .magenta
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
    }
    
    func initStackView() {
        StackView.isHidden = true
        StackView.roundBorders(corners: [UIRectCorner.topLeft, UIRectCorner.topRight], radius: 15.0)
    }
}

