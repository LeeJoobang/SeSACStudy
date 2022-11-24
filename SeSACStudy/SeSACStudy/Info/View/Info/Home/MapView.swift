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
    
    let locationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setImage(UIImage(named: "place"), for: .normal)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 6
        return button
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
        self.addSubview(locationButton)
    }
    
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        centerImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        locationButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.mapView.snp.leading).offset(12)
            make.height.width.equalTo(48)
        }
        
    }
    
}
