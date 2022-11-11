import UIKit

class EmailViewController: BaseViewController {

    let emailView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = emailView
        emailView.backgroundColor = .white
        emailView.numberTextField.addTarget(self, action: #selector(EmailViewController.textfieldDidChange(_:)), for: UIControl.Event.allEditingEvents)

    }
    
    // MARK: 닉네임 실시간 반영 및 버튼 컬러 변경
    @objc func textfieldDidChange(_ textfield: UITextField){
        guard let emailText = emailView.numberTextField.text else { return }
        print(emailText)
        let result = isEmail(candidate: emailText)
        print(result)
        if result {
            emailView.certificationButton.backgroundColor = .customGreen
            emailView.certificationButton.isEnabled = true
        } else {
            emailView.certificationButton.backgroundColor = .customGray3
            emailView.certificationButton.isEnabled = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let customGray3 = UIColor.customGray3 else { return }
        emailView.numberView.layer.addBorder([.bottom], color: customGray3, width: 1.0)
    }
    
    
    
    override func configure() {
        let text = "이메일을 입력해주세요 \n 휴대폰 번호 변경시 인증을 위해 사용해요"
        emailView.numberTextLabel.numberOfLines = 0
        emailView.numberTextLabel.font = UIFont(name: UIFont.notoMedium, size: 20)
        emailView.numberTextLabel.text = text
        emailView.numberTextLabel.textAlignment = .center
        
        emailView.numberTextField.placeholder = "SeSAC@email.com"
        
        emailView.certificationButton.backgroundColor = .customGray6
        emailView.certificationButton.titleLabel?.font = UIFont(name: UIFont.notoMedium, size: 14)
        emailView.certificationButton.setTitle("다음", for: .normal)
        emailView.certificationButton.tintColor = .customGray3
        emailView.certificationButton.layer.cornerRadius = 5
        emailView.certificationButton.addTarget(self, action: #selector(buttonClicked(button: )), for: .touchUpInside)
    }
    
    @objc func buttonClicked(button: UIButton){
        let vc = GenderViewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func isEmail(candidate: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = phonePredicate.evaluate(with: candidate)
        return isValid
    }
}

