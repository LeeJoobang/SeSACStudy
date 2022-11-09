import UIKit

import FirebaseAuth

class LoginViewController: BaseViewController {

    let loginView = LoginView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        loginView.backgroundColor = .white

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let customGray3 = UIColor.customGray3 else { return }
        loginView.numberView.layer.addBorder([.bottom], color: customGray3, width: 1.0)
    }
    
    
    
    override func configure() {
        let text = "새싹 서비스 이용을 위해 \n 휴대폰 번호를 입력해 주세요"
        loginView.numberTextLabel.numberOfLines = 0
        loginView.numberTextLabel.font = UIFont(name: UIFont.notoMedium, size: 20)
        loginView.numberTextLabel.text = text
        loginView.numberTextLabel.addInterlineSpacing(spacingValue: 3.0)
        loginView.numberTextLabel.textAlignment = .center
        
        loginView.numberTextField.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        loginView.numberTextField.keyboardType = .numberPad
        
        loginView.certificationButton.backgroundColor = .customGray6
        loginView.certificationButton.titleLabel?.font = UIFont(name: UIFont.notoMedium, size: 14)
        loginView.certificationButton.setTitle("인증 번호 받기", for: .normal)
        loginView.certificationButton.tintColor = .customGray3
        loginView.certificationButton.layer.cornerRadius = 5
        loginView.certificationButton.addTarget(self, action: #selector(buttonClicked(button: )), for: .touchUpInside)
    }
    
    @objc func buttonClicked(button: UIButton){
        print("button clicked")
        let phoneNumber = "+821033225679"
        
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
              if let error = error {
                print("error: \(error)")
                return
              }
              print("성공 - verificationID : \(verificationID)")
              UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
              
              let vc = LoginCodeViewController()
              self.navigationController?.pushViewController(vc, animated: true)
          }
    }
}

