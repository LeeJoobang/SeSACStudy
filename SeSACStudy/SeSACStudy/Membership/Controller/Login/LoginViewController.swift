import UIKit

import FirebaseAuth

class LoginViewController: BaseViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        loginView.backgroundColor = .white
        loginView.numberTextField.addTarget(self, action: #selector(LoginViewController.textfieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    
    // MARK: 핸드폰 번호 실시간 반영 및 버튼 컬러 변경
    @objc func textfieldDidChange(_ textfield: UITextField){
        guard let phonetext = loginView.numberTextField.text else { return }
        let phoneFormat = phoneNumberformat(with: "XXX-XXXX-XXXX", phone: phonetext)

        let result = isPhone(candidate: phoneNumberformat(with: "XXX-XXXX-XXXX", phone: phonetext))

        if result {
            loginView.certificationButton.backgroundColor = .customGreen
            loginView.numberTextField.text = phoneFormat
            loginView.certificationButton.isEnabled = true
        } else {
            loginView.certificationButton.backgroundColor = .customGray3
            loginView.certificationButton.isEnabled = false
        }
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
    
    /* 로직 진행을 위한 잠시 주석처리
    @objc func buttonClicked(button: UIButton){

                let vc = LoginCodeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
    }
     */
    
    // 로직 진행을 위한 잠시 주석 처리
    @objc func buttonClicked(button: UIButton){
        let phoneNumber = "+821033225679"
//        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if error != nil {
                    print("error: \(error)")
                    return
                }
                print("성공 - verificationID : \(verificationID)")
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")

                let vc = LoginCodeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
    }
    
    // MARK: 전화번호 변경
    private func phoneNumberformat(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "^01([0|1])([0-9]{9})$", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    // MARK: 핸드폰 번호 유효성 검사
    func isPhone(candidate: String) -> Bool {
        let regex = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = phonePredicate.evaluate(with: candidate)
        return isValid
    }
   
}

