import UIKit

class GenderViewController: BaseViewController {

    let gendernameView = GenderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = gendernameView
        gendernameView.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func configure() {
        let text = "성별을 선택해 주세요 \n 새싹 찾기 기능을 이용하기 위해서 필요해요."
        gendernameView.GenderTextLabel.numberOfLines = 0
        gendernameView.GenderTextLabel.font = UIFont(name: UIFont.notoMedium, size: 20)
        gendernameView.GenderTextLabel.text = text
        gendernameView.GenderTextLabel.textAlignment = .center
                
        gendernameView.certificationButton.backgroundColor = .customGray6
        gendernameView.certificationButton.titleLabel?.font = UIFont(name: UIFont.notoMedium, size: 14)
        gendernameView.certificationButton.setTitle("다음", for: .normal)
        gendernameView.certificationButton.tintColor = .customGray3
        gendernameView.certificationButton.layer.cornerRadius = 5
        gendernameView.certificationButton.addTarget(self, action: #selector(buttonClicked(button: )), for: .touchUpInside)
    }
    
    @objc func buttonClicked(button: UIButton){
        // MARK: 회원가입 신청
        let apiService = APIService()
        
    }
    
    
}

