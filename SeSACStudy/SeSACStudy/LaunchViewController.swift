//
//  LaunchViewController.swift
//  SeSACStudy
//
//  Created by Jooyoung Lee on 2022/12/02.
//

import UIKit

class LaunchViewController: BaseViewController{
    
    let sesacimageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "splash_logo")
        return image
    }()
    
    let logoimageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "splash_text")
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func getData(completion: @escaping (Int?, User?)-> Void){
        guard let id = UserDefaults.standard.string(forKey: "idToken") else { return }
        print(id)
        let api = APIService()
        api.profile(id: id) { statusCode, userInfo in
            switch statusCode {
            case 200:
                guard let userInfo = userInfo else { return }
                print("🌹: \(statusCode)")
                print("🌹: \(userInfo.nick)")
                print("🌹: \(userInfo.ageMax)")
                let updateUser = UpdateInfo.shared
                updateUser.nick = userInfo.nick
                updateUser.ageMax = userInfo.ageMax
                updateUser.ageMin = userInfo.ageMin
                updateUser.gender = userInfo.gender
                updateUser.searchable = userInfo.searchable
                updateUser.phoneNumber = userInfo.phoneNumber
                updateUser.study = userInfo.study
                print("🌹: \(updateUser.nick)")
                print("🌹: \(updateUser.ageMax)")
                completion(statusCode, userInfo)
            case 401:
                print("🌹: \(statusCode)")
                let fetch = LoginCodeViewController()
                
                FCMService.shared.getIDToken { idToken, error in
                    guard let idToken = idToken else { return }
                    // MARK: idToken 값 userDefault 저장
                    UserDefaults.standard.set(idToken, forKey: "idToken")
                    
                    fetch.fetchProfile()
                }

            default:
                fatalError()
            }
            
        }
    }
    
    override func configure() {
        [sesacimageView, logoimageView].forEach {
            view.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        sesacimageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(219)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(220)
            $0.height.equalTo(264)
        }
        
        logoimageView.snp.makeConstraints{
            $0.top.equalTo(sesacimageView.snp.bottom).offset(32)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(292)
            $0.height.equalTo(101)
        }
    }
}

