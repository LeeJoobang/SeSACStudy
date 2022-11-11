import UIKit

class GenderViewController: BaseViewController {

    let gendernameView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = gendernameView
        gendernameView.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let customGray3 = UIColor.customGray3 else { return }
//        gendernameView.numberView.layer.addBorder([.bottom], color: customGray3, width: 1.0)
    }
    
    
    
    override func configure() {
        let text = "성별을 선택해 주세요 \n 새싹 찾기 기능을 이용하기 위해서 필요해요."
        gendernameView.numberTextLabel.numberOfLines = 0
        gendernameView.numberTextLabel.font = UIFont(name: UIFont.notoMedium, size: 20)
        gendernameView.numberTextLabel.text = text
        gendernameView.numberTextLabel.textAlignment = .center
        
//        gendernameView.numberTextField.placeholder = "SeSAC@email.com"
        
        gendernameView.certificationButton.backgroundColor = .customGray6
        gendernameView.certificationButton.titleLabel?.font = UIFont(name: UIFont.notoMedium, size: 14)
        gendernameView.certificationButton.setTitle("다음", for: .normal)
        gendernameView.certificationButton.tintColor = .customGray3
        gendernameView.certificationButton.layer.cornerRadius = 5
        gendernameView.certificationButton.addTarget(self, action: #selector(buttonClicked(button: )), for: .touchUpInside)
    }
    
    @objc func buttonClicked(button: UIButton){

    }
}

