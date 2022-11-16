import UIKit

class StudyTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let textfield: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        textField.leftViewMode = .always
        return textField
    }()

    let lineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.customGray3?.cgColor
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
        [label, textfield, lineView].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.leading.equalTo(self.contentView.snp.leading).offset(16)
        }
        
        textfield.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
            make.width.equalTo(164)
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(self.textfield.snp.bottom).offset(2)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
            make.width.equalTo(164)
            make.height.equalTo(1)
        }
    }
}
