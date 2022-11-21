//import UIKit
//
//import MapKit
//
//
//class MapView: BaseView{
//    
//    let map: MapView = {
//        let map = MapView()
//        return map
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func configure() {
//        self.addSubview(map)
//    }
//    
//    override func setConstraints() {
//        map.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//    
//}
