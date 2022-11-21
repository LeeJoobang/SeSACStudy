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
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: testVerificationCode)
        Auth.auth().signIn(with: credential) { authData, error in
            if (error != nil) {
                print("testVerificationCode incorrect")
                return
            }
            // MARK: sesac 서버로부터 인증번호 - 미가입, 가입 유저 확인
            let currentUser = Auth.auth().currentUser
            currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                if let error = error {
                    print("error 발생")
                    return
                }

                // MARK: 미가입유저 - 회원가입 로직 진행, 가입유저 - 로그인 로직
                guard let idToken = idToken else { return }
                if idToken != "" {
                    // MARK: idToken 값 userDefault 저장
                    UserDefaults.standard.set(idToken, forKey: "idToken")
                    // MARK: 가입 유저 유무 확인 로직
                    let apiService = APIService()
                    apiService.profile(id: idToken) { code in
                        guard let code = code else { return }
                        switch code {
                        case 200...299:
                            print("🌹 code number: \(code)")
                            print(UserDefaults.standard.string(forKey: "idToken"))
//                            let vc = BaseTabBarController()
//                            self.navigationController?.pushViewController(vc, animated: true)
                            
                            let vc = BaseTabBarController()
                            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                            guard let delegate = sceneDelegate else { return }
                            delegate.window?.rootViewController = vc
                            
                        case 400...499:
                            print("🌹 code number: \(code)")
                            let vc = NicknameViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
                        default:
                            print("오류")
                        }
                    }
                }
            }
        }
    }
    
    func deleteUserDefault(){
        print("🌹deleteUserDefault - 넣을지 고민중")
        let keyName = ["nickName", "birth", "email", "gender"]
        for key in keyName {
                    UserDefaults.standard.removeObject(forKey: key)
        }
    }
}
