//
//  Mark.swift
//  SeSACStudy
//
//  Created by Jooyoung Lee on 2022/12/14.
//

import MapKit

class CustomAnnotationView: MKAnnotationView{
    static let identifier = "CustomAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
            backgroundColor = .clear
        }
}

class Marker: NSObject, MKAnnotation{
    let image: Int?
    let coordinate: CLLocationCoordinate2D
    
    init(image: Int?, coordinate: CLLocationCoordinate2D) {
        self.image = image
        self.coordinate = coordinate
        
        super.init()
    }
}

