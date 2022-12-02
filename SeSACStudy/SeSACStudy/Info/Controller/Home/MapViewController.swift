import UIKit

import MapKit
import CoreLocation

class MapViewController: BaseViewController {
    
    var mapView = MapView()
    
    let loctionManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mapView
        self.mapView.mapView.delegate = self
        mapView.backgroundColor = .white
        loctionManager.delegate = self
        
        mapView.locationButton.addTarget(self, action: #selector(loactionButtonClicked), for: .touchUpInside)
        mapView.floatButton.addTarget(self, action: #selector(floatButtonClicked), for: .touchUpInside)
    }
    
    @objc func floatButtonClicked(){
        
        print("hi")
        let vc = StudyGroupViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loactionButtonClicked(){
        checkUserDeviceLocationServiceAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D){
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 700, longitudinalMeters: 700)
        mapView.mapView.setRegion(region, animated: true)
       
        //let annotation = MKPointAnnotation()
        //annotation.coordinate = center
        //mapView.mapView.addAnnotation(annotation)
    }
    
}
extension MapViewController {
    // MARK: 사용자의 위치서비스 onoff를 확인 후, 기기 위치서비스 onoff 유무 확인
    func checkUserDeviceLocationServiceAuthorization(){
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = loctionManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어서 위치 관련 요청을 못합니다.")
        }
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOTDETERMINDED")
            loctionManager.desiredAccuracy = kCLLocationAccuracyBest
            loctionManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도")
//            loctionManager.startUpdatingLocation()
            
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            // 실시간으로 현재 위치를 확인 후 centerimage가 위치할 수 있도록 함.
            loctionManager.startUpdatingLocation()
        default:
            print("DEFAULT")
        }
    }

    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    //위치값을 가져왔을 때 현재 위치값을 가져올 수 있게 된다.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        }
        loctionManager.stopUpdatingLocation()
    }
    
    //위치를 받아오지 못했을 경우, 새싹 캠퍼스로 표시
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
        let center = CLLocationCoordinate2D(latitude: 37.517819364682694, longitude: 126.88647317074734)
        setRegionAndAnnotation(center: center)

    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationServiceAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("")
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let centerLocation = self.mapView.mapView.centerCoordinate
        print(centerLocation.longitude, centerLocation.latitude)
        // 위치 값이 변화할 때마다        
        let api = APIService()
        api.currentLocation(lat: centerLocation.latitude, long: centerLocation.longitude) { statusCode in
            switch statusCode{
            case 200:
                print("🍁성공")
            case 401:
                print("🍁firebase token error")
            case 406:
                print("🍁미가입 회원")
            case 500:
                print("🍁Server Error")
            case 501:
                print("🍁Client Error")
            default:
                fatalError()
            }
        }
        
    }
}

