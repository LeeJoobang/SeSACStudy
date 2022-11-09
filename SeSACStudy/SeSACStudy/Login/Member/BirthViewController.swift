import UIKit

class BirthiewController: BaseViewController {

    let birthView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = birthView
        birthView.backgroundColor = .white

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        guard let customGray3 = UIColor.customGray3 else { return }
//        BirthView.numberView.layer.addBorder([.bottom], color: customGray3, width: 1.0)
    }
    
    
    
    override func configure() {
        let text = "생년월일을 알려주세요"
        birthView.numberTextLabel.numberOfLines = 0
        birthView.numberTextLabel.font = UIFont(name: UIFont.notoMedium, size: 20)
        birthView.numberTextLabel.text = text
        birthView.numberTextLabel.textAlignment = .center
        
//        BirthView.numberTextField.placeholder = "10자 이내로 입력"
        
        birthView.certificationButton.backgroundColor = .customGray6
        birthView.certificationButton.titleLabel?.font = UIFont(name: UIFont.notoMedium, size: 14)
        birthView.certificationButton.setTitle("다음", for: .normal)
        birthView.certificationButton.tintColor = .customGray3
        birthView.certificationButton.layer.cornerRadius = 5
        birthView.certificationButton.addTarget(self, action: #selector(buttonClicked(button: )), for: .touchUpInside)
    }
    
    @objc func buttonClicked(button: UIButton){
        let vc = EmailViewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
}

