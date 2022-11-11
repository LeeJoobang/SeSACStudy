import UIKit

class BirthView: BaseView{
    
    let BirthTextLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let leftView: BirthSubView = {
        let view = BirthSubView()
        view.label.textAlignment = .left
        view.textfield.textAlignment = .center
        return view
    }()
    
    let centerView: BirthSubView = {
        let view = BirthSubView()
        view.label.textAlignment = .left
        view.textfield.textAlignment = .center
        return view
    }()

    let rightView: BirthSubView = {
        let view = BirthSubView()
        view.label.textAlignment = .left
        view.textfield.textAlignment = .center
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [leftView, centerView, rightView])
        view.backgroundColor = .clear
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()
    
    let birthLineView: UIView = {
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
        [BirthTextLabel, birthLineView, stackView, certificationButton].forEach {
            self.addSubview($0)
        }
        
        [leftView, centerView, rightView].forEach {
            self.stackView.addArrangedSubview($0)
        }
    }
    
    override func setConstraints() {
        BirthTextLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(125)
            make.centerX.equalToSuperview()
            make.height.equalTo(64)
        }
        
        birthLineView.snp.makeConstraints { make in
            make.top.equalTo(BirthTextLabel.snp.bottom).offset(64)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(BirthTextLabel.snp.bottom).offset(64)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        certificationButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(stackView.snp.bottom).offset(72)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.bottom.lessThanOrEqualTo(self.keyboardLayoutGuide.snp.top).offset(-10)
        }
    }
}
