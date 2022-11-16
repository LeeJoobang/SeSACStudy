import UIKit

class NameTableViewCell: BaseTableViewCell {
    
    let infoLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let arrowView: UIImageView = {
        let view = UIImageView()
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
        [infoLabel, arrowView].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        infoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.leading.trailing.equalToSuperview().inset(32)
        }
    }
}
