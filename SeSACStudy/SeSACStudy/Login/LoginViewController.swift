import UIKit

class LoginViewController: BaseViewController {

    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        loginView.backgroundColor = .white
    }
    
    override func configure() {
        loginView.numberTextLabel.numberOfLines = 0
        loginView.numberTextLabel.font = loginView.numberTextLabel.font.withSize(20)
        loginView.numberTextLabel.text = "새싹 서비스 이용을 위해 \n휴대폰 번호를 입력해 주세요"
        loginView.numberTextLabel.setLineSpacing(spacing: 15.0)
        loginView.numberTextLabel.textAlignment = .center
        
        loginView.numberTextField.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
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
