import UIKit


class LoginView: BaseView{
    
    let numberTextLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let numberTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    let numberView: UIView = {
        let view = UIView()
        return view
    }()
    
    let certificationButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [numberTextLabel, numberView, numberTextField, certificationButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        numberTextLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(125)
            make.centerX.equalToSuperview()
            make.height.equalTo(64)
        }
        
        numberView.snp.makeConstraints { make in
            make.top.equalTo(numberTextLabel.snp.bottom).offset(64)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(numberTextLabel.snp.bottom).offset(64)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        certificationButton.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}
