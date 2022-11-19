import UIKit

class NumberTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let switchBox: UISwitch = {
       let switchA = UISwitch()
       return switchA
   }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [label, switchBox].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.leading.equalTo(self.contentView.snp.leading).offset(16)
        }
        
        switchBox.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
        }

    }
}
