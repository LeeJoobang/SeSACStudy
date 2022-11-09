import UIKit

class EmailViewController: BaseViewController {

    let emailView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = emailView
        emailView.backgroundColor = .white
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
}

