import UIKit

class GenderTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let leftButton: UIButton = {
        var button = UIButton.Configuration.filled()
        var title = AttributedString.init("남자")
        title.font = UIFont(name: UIFont.notoRegular, size: 14)
        button.attributedTitle = title
//        button.baseBackgroundColor = .white
        button.buttonSize = .small
        button.baseForegroundColor = .black
        button.imagePlacement = .top
        button.background.strokeWidth = 1
        button.background.strokeColor = .gray
        
        let view = UIButton(configuration: button)
        return view
    }()
    
    let rightButton: UIButton = {
        var button = UIButton.Configuration.filled()
        var title = AttributedString.init("여자")
        title.font = UIFont(name: UIFont.notoRegular, size: 14)
        button.attributedTitle = title
//        button.baseBackgroundColor = .white
        button.buttonSize = .small
        button.baseForegroundColor = .black
        button.imagePlacement = .top
        button.background.strokeWidth = 1
        button.background.strokeColor = .gray
        let view = UIButton(configuration: button)
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [leftButton, rightButton])
        view.backgroundColor = .clear
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [label, stackView].forEach {
            self.contentView.addSubview($0)
        }
        
        [leftButton, rightButton].forEach {
            self.stackView.addArrangedSubview($0)
        }
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.leading.equalTo(self.contentView.snp.leading).offset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
            make.height.equalTo(58)
            make.width.equalTo(120)
        }
    }
    
    func leftButtonClicked(state: Bool){
        if state == true {
            leftButton.configuration?.baseBackgroundColor = .customGreen
        } else {
            leftButton.configuration?.baseBackgroundColor = .white
        }
    }
    
    func rightButtonClicked(state: Bool){
        if state == true{
            rightButton.configuration?.baseBackgroundColor = .customGreen
        } else {
            rightButton.configuration?.baseBackgroundColor  = .white
        }
    }
}
