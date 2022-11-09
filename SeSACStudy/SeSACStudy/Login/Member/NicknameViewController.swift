import UIKit

class NicknameViewController: BaseViewController {

    let nicknameView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = nicknameView
        nicknameView.backgroundColor = .white
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
        nicknameView.certificationButton.addTarget(self, action: #selector(buttonClicked(button: )), for: .touchUpInside)
    }
    
    @objc func buttonClicked(button: UIButton){
        let vc = BirthiewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
}

