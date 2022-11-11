import UIKit

import FirebaseAuth


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
        resend()
//        checkMessage()
    }
    
    @objc func buttonClicked(button: UIButton){
        print("button clicked")
        let vc = NicknameViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func resend(){
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return print("somthing weird") }
        
        print("resend - verificationID: \(verificationID)")

        let testVerificationCode = "123456"
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: testVerificationCode)
        
        Auth.auth().signIn(with: credential) { authData, error in
            if (error != nil) {
                print("testVerificationCode incorrect")
                return
            }
            print("인증완료: \(String(describing: authData?.user.uid))")
        }
    }
    
//    func checkMessage(){
//        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return print("somthing weird") }
//
////        self.verifyID = verificationID
//
//        print("check - verificationID: \(verificationID)")
//
//        PhoneAuthProvider.provider().verifyPhoneNumber("+821033225679", uiDelegate: nil) { (verification, error) in
//            if (error == nil) {
//                verification
//            } else {
//                print("phone verfication error: \(error.debugDescription) ")
//            }
//        }
//
//    }
    
    
}
