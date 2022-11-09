import UIKit

class LoginViewController: BaseViewController {

    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        loginView.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginView.numberTextField.useUnderLine()
    }
    
    override func configure() {
        loginView.numberTextLabel.numberOfLines = 0
        loginView.numberTextLabel.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        loginView.numberTextLabel.text = "새싹 서비스 이용을 위해 \n 휴대폰 번호를 입력해 주세요"
        loginView.numberTextLabel.setLineSpacing(spacing: 15.0)
        loginView.numberTextLabel.textAlignment = .center
        
        loginView.numberTextField.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        loginView.numberTextField.useUnderLine()
    }
    
    
}


extension UILabel {
    func setLineSpacing(spacing: CGFloat){
        guard let text = text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}

extension UITextField{
    func useUnderLine(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
