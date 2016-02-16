//
//  MapViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 09.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: MasterNavViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var items: [BarLocationInfo] = []
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.distanceFilter = 50
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse || CLLocationManager.authorizationStatus() == .AuthorizedAlways){
            locationManager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
        }
        
        
        if CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == .Denied)
        {
            
            let alertController = UIAlertController(title: "Доступ к геолокации запрещен", message:
                "Чтобы включить доступ перейдите в Настройки и включите геопозицию для этого приложения", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.Default,handler: { (action: UIAlertAction!) in
                
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Отмена", style: UIAlertActionStyle.Cancel,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
        
        
        
        mapView.delegate = self
        mapView.pitchEnabled = true
        mapView.showsBuildings = true
        
        centerMapOnLocation(initialLocation)
        
        setupTrackButton()
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        lUpdated = false
        
    }
    
    func setupTrackButton(){
        /*let trackButton = MKUserTrackingBarButtonItem(mapView: mapView)
        trackButton.target = self
        trackButton.
        //trackButton.action = "centerUserLocation"
        
        self.navigationItem.setRightBarButtonItem(trackButton, animated: true)*/
        let img = UIImage(named: "MapPoint")?.cropImage(scaledToSize: CGSize(width: 20, height: 28.8))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: img, style: UIBarButtonItemStyle.Plain, target: self, action: "centerUserLocation")
    }
    
    // MARK: - LocationManager delegate methods
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .Authorized, .AuthorizedWhenInUse:
            manager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
        default: break
        }
    }
    
    // MARK: - MapView delegate methods
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        //let region = mapView.visibleMapRect
        let region = mapView.region
        let span = region.span
        let center = region.center
        
        /*
        CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:(center.latitude - span.latitudeDelta * 0.5) longitude:center.longitude];
        CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:(center.latitude + span.latitudeDelta * 0.5) longitude:center.longitude];
        int metersLatitude = [loc1 distanceFromLocation:loc2];
        */
        let loc3 = CLLocation(latitude: center.latitude, longitude: (center.longitude - span.longitudeDelta * 0.5))
        let loc4 = CLLocation(latitude: center.latitude, longitude: (center.longitude + span.longitudeDelta * 0.5))
        let metersLongitude = loc3.distanceFromLocation(loc4)
        
        let maxD = metersLongitude
        
        APICalls.getBarsByCoords(region.center.latitude, lon: region.center.longitude, distance: maxD) { (bars) -> Void in
            self.items = bars
            
            mapView.removeAnnotations(mapView.annotations)
            
            for item in self.items{
                self.setupAnnotation(item)
            }
            
            //mapView.showAnnotations(mapView.annotations, animated: true)
            //mapView.reloadInputViews()
        }
        
    }
    
    
    func setupAnnotation(barL: BarLocationInfo){
        let loc = CLLocationCoordinate2D(latitude: barL.lat, longitude: barL.lon)
        let ann = BarAnnotation(title: "KILLFISH", subtitle: "\(barL.name)", coordinate: loc)
        
        ann.bar = barL
        /*
        let pann = MKPointAnnotation()
        pann.title = "lel"
        pann.subtitle = "lol"
        pann.coordinate = loc
        */
        
        mapView.addAnnotation(ann)
    }
    var lUpdated = false
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        //mapView.centerCoordinate = userLocation.location!.coordinate
        
        //centerMapOnLocation(userLocation.location!)
        if lUpdated{
            return
        }
        lUpdated = true
        centerUserLocation()

    }
    
    func centerUserLocation(){
        if mapView.userLocation.location == nil{
            return
        }
        centerMapOnLocation(mapView.userLocation.location!)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation is MKUserLocation) {
            mapView.userLocation.title = "Я здесь"
            return nil
        }
        
        let reuseID = "barAnn"
        var v = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
        
        if v != nil {
            v!.annotation = annotation
        } else {
            v = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            
            v!.canShowCallout = true
            
            v!.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "killfishICO")?.cropImage(scaledToSize: CGSize(width: 50, height: 50)))
            
            let btn = UIButton(type: .DetailDisclosure)
            v!.rightCalloutAccessoryView = btn
            
            v!.image = UIImage(named: "MapPointColored")?.cropImage(scaledToSize: CGSize(width: 20, height: 28.8))
        }
        
        return v
        
        /*
        if annotation is BarAnnotation{
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "barAnn")
            annotationView.canShowCallout = true
            
            //annotationView.pinColor = .Purple
            
            annotationView.image = UIImage(named:"IconOld")
            
            // 5
            
            let btn = UIButton(type: .DetailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            
            return annotationView
        }
        
        return nil
*/
        
        /*// 1
        let identifier = "BarAnnotation"
        
        // 2
        if annotation.isKindOfClass(BarAnnotation.self) {
            // 3
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            
            if annotationView == nil {
                //4
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                
                // 5
                
                let btn = UIButton(type: .DetailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
                
            } else {
                // 6
                annotationView!.annotation = annotation
            }
            
            //annotationView?.image = UIImage(named: "Card")
            
            return annotationView
        }
        
        // 7
        return nil
*/
    }
    /*
    func mapView(mapView: MKMapView!,
        viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            if (annotation is MKUserLocation) { return nil }
            
            let reuseID = "chest"
            var v = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
            
            if v != nil {
                v.annotation = annotation
            } else {
                v = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
                
                v.image = UIImage(named:"chest")
            }
            
            return v
    }
    */
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let barA = view.annotation as! BarAnnotation
        let placeName = barA.title
        let placeInfo = barA.subtitle!+"\nВремя работы: \(barA.bar!.time)"+"\nЧасовой пояс: \(barA.bar!.diff/60) МСК"
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    
    let initialLocation = CLLocation(latitude: 55.7522200, longitude: 37.6155600)
    let regionRadius: CLLocationDistance = 4000
    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}
