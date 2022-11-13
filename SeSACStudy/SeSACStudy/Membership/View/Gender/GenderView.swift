import UIKit

class GenderView: BaseView{
    
    let GenderTextLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let leftView: GenderSubView = {
        let view = GenderSubView()
        view.backgroundColor = .gray
        view.imageView.image = UIImage(named: "man")
        view.label.text = "남자"
        view.label.textAlignment = .center
        return view
    }()

    let rightView: GenderSubView = {
        let view = GenderSubView()
        view.backgroundColor = .gray
        view.imageView.image = UIImage(named: "woman")
        view.label.text = "여자"
        view.label.textAlignment = .center

        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [leftView, rightView])
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
        [GenderTextLabel, stackView, certificationButton].forEach {
            self.addSubview($0)
        }
        
        [leftView, rightView].forEach {
            self.stackView.addArrangedSubview($0)
        }
    }
    
    override func setConstraints() {
        GenderTextLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(125)
            make.centerX.equalToSuperview()
            make.height.equalTo(64)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(GenderTextLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(120)
        }
        
        certificationButton.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(stackView.snp.bottom).offset(72)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.bottom.lessThanOrEqualTo(self.keyboardLayoutGuide.snp.top).offset(-10)
        }
    }
}
