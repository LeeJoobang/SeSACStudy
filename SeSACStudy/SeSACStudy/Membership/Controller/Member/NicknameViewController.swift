import UIKit

class NicknameViewController: BaseViewController {
    
    let nicknameView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = nicknameView
        nicknameView.backgroundColor = .white
        nicknameView.numberTextField.addTarget(self, action: #selector(NicknameViewController.textfieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    
    // MARK: 닉네임 실시간 반영 및 버튼 컬러 변경
    @objc func textfieldDidChange(_ textfield: UITextField){
        guard let nicknameText = nicknameView.numberTextField.text else { return }
        let result = isNickname(candidate: nicknameText)
        if result {
            UserDefaults.standard.set(nicknameText, forKey: "nickName")
            nicknameView.certificationButton.backgroundColor = .customGreen
            nicknameView.certificationButton.isEnabled = true
            nicknameView.certificationButton.addTarget(self, action: #selector(buttonClicked(button: )), for: .touchUpInside)
        } else {
            nicknameView.certificationButton.backgroundColor = .customGray3
            nicknameView.certificationButton.isEnabled = false
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let customGray3 = UIColor.customGray3 else { return }
        nicknameView.numberView.layer.addBorder([.bottom], color: customGray3, width: 1.0)
    }
    
    override func configure() {
        let text = "닉네임을 입력해 주세요"
        nicknameView.numberTextLabel.numberOfLines = 0
        nicknameView.numberTextLabel.font = UIFont(name: UIFont.notoMedium, size: 20)
        nicknameView.numberTextLabel.text = text
        nicknameView.numberTextLabel.textAlignment = .center
        
        nicknameView.numberTextField.placeholder = "10자 이내로 입력"
        
        nicknameView.certificationButton.backgroundColor = .customGray6
        nicknameView.certificationButton.titleLabel?.font = UIFont(name: UIFont.notoMedium, size: 14)
        nicknameView.certificationButton.setTitle("다음", for: .normal)
        nicknameView.certificationButton.tintColor = .customGray3
        nicknameView.certificationButton.layer.cornerRadius = 5
    }
    
    @objc func buttonClicked(button: UIButton){
        let vc = BirthiewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func isNickname(candidate: String) -> Bool {
        let regex = "[가-힣A-Za-z0-9]{1,10}"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = phonePredicate.evaluate(with: candidate)
        return isValid
    }
}

