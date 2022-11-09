//
//  LoginCodeViewController.swift
//  SeSACStudy
//
//  Created by Jooyoung Lee on 2022/11/09.
//

import UIKit

import FirebaseAuth


class LoginCodeViewController: BaseViewController {
    
    let loginView = LoginView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        loginView.backgroundColor = .white
    }
    
    
    override func configure() {
        loginView.numberTextLabel.numberOfLines = 0
        loginView.numberTextLabel.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        loginView.numberTextLabel.text = "인증문자를 발송하였습니다."
        loginView.numberTextLabel.setLineSpacing(spacing: 15.0)
        loginView.numberTextLabel.textAlignment = .center
        
        loginView.numberTextField.placeholder = "인증번호"
        
        loginView.certificationButton.backgroundColor = .customGreen
        //        loginView.certificationButton.addTarget(self, action: #selector(buttonClicked(button: )), for: .touchUpInside)
        
        resend()
    }
    
    func resend(){
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return print("somthing weird") }
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
}
