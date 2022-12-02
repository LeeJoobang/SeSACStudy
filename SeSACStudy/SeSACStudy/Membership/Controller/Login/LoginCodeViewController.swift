import UIKit

import FirebaseAuth
import Alamofire

class LoginCodeViewController: BaseViewController {
    
    let loginCodeView = LoginView()
    var verifyID: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginCodeView
        loginCodeView.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let customGray3 = UIColor.customGray3 else { return }
        loginCodeView.numberView.layer.addBorder([.bottom], color: customGray3, width: 1.0)
    }
    
    override func configure() {
        loginCodeView.numberTextLabel.numberOfLines = 0
        loginCodeView.numberTextLabel.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        loginCodeView.numberTextLabel.text = "인증문자를 발송하였습니다."
        loginCodeView.numberTextLabel.textAlignment = .center
        
        loginCodeView.numberTextField.placeholder = "인증번호"
        
        loginCodeView.certificationButton.backgroundColor = .customGray6
        loginCodeView.certificationButton.titleLabel?.font = UIFont(name: UIFont.notoMedium, size: 14)
        loginCodeView.certificationButton.setTitle("인증하고 시작하기", for: .normal)
        loginCodeView.certificationButton.tintColor = .customGray3
        loginCodeView.certificationButton.layer.cornerRadius = 5
        loginCodeView.certificationButton.addTarget(self, action: #selector(buttonClicked(button: )), for: .touchUpInside)
    }
    // 로직 검사를 위해 임시적으로 주석처리
    //     @objc func buttonClicked(button: UIButton){
    //         print("button clicked")
    //         let vc = NicknameViewController()
    //         self.navigationController?.pushViewController(vc, animated: true)
    //     }
    
    // 로직 검사를 위해 임시적으로 주석처리
    @objc func buttonClicked(button: UIButton){
        // MARK: idToken 발급
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return print("somthing weird") }
        let textfieldText = loginCodeView.numberTextField.text
        guard let testVerificationCode = textfieldText else {
            // data 미입력에 대한 토스트 메세지 출력
            return
        }
        
        FCMService.shared.getCredential(verficationID: verificationID, vericationCode: testVerificationCode) { testResult, error in
            if testResult {
                print("error: \(String(describing: error))")
                return
            }
        }
        
        FCMService.shared.getIDToken { idToken, error in
            guard let idToken = idToken else { return }
            // MARK: idToken 값 userDefault 저장
            UserDefaults.standard.set(idToken, forKey: "idToken")
            
            self.fetchProfile()
        }
    }
    
    
    func fetchProfile() {
        guard let id = UserDefaults.standard.string(forKey: "idToken") else { return }
        let apiService = APIService()
        apiService.profile(id: id) { code, userInfo in
            guard let code = code else { return }
            switch code {
            case 200...299:
                print("🌹 code number: \(code)")
                print(UserDefaults.standard.string(forKey: "idToken"))
                UserDefaults.standard.set(1, forKey: "success")
                
                //                    let api = APIService()
                //                    api.profile(id: idToken) { statusCode, userInfo in
                guard let userInfo = userInfo else { return }
                //                        print("🌹: \(statusCode)")
                //                        print("🌹: \(userInfo.nick)")
                //                        print("🌹: \(userInfo.ageMax)")
                let updateUser = UpdateInfo.shared
                updateUser.nick = userInfo.nick
                updateUser.ageMax = userInfo.ageMax
                updateUser.ageMin = userInfo.ageMin
                updateUser.gender = userInfo.gender
                updateUser.searchable = userInfo.searchable
                updateUser.phoneNumber = userInfo.phoneNumber
                updateUser.study = userInfo.study
                //                        print("🌹: \(updateUser.nick)")
                //                        print("🌹: \(updateUser.ageMax)")
                let vc = BaseTabBarController()
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                guard let delegate = sceneDelegate else { return }
                delegate.window?.rootViewController = vc
                
            case 401: //Firebase Token Erro
                print("🌹401 error")
                FCMService.shared.getIDToken { idToken, error in
                    guard let idToken = idToken else { return }
                    // MARK: idToken 값 userDefault 저장
                    UserDefaults.standard.set(idToken, forKey: "idToken")
                    self.fetchProfile()
                }
            case 406:
                print("🌹406 - nickname ViewController 이동")
                let vc = NicknameViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                fatalError()
            }
            
        }
    }
}

// MARK: method 수정 - 이건 뭘까?
//    func deleteUserDefault(){
//        print("🌹deleteUserDefault - 넣을지 고민중")
//        let keyName = ["nickName", "birth", "email", "gender"]
//        for key in keyName {
//            UserDefaults.standard.removeObject(forKey: key)
//        }
//    }



