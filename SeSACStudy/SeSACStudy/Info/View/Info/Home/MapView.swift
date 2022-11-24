import UIKit

import MapKit


class MapView: BaseView{
    
    let mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    let centerImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "centerImage")
        image.contentMode = .scaleAspectFit
        image.sizeToFit()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        self.addSubview(mapView)
        self.addSubview(centerImage)
    }
    
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        centerImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        
    }
    
}
