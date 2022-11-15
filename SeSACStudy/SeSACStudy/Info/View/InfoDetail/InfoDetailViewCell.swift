import UIKit

class InfoDetailViewCell: BaseTableViewCell {

    let infoView: UIImageView = {
        let view = UIImageView()
        view.sizeToFit()
        return view
    }()
    
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
        [infoView, infoLabel, arrowView].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {

        infoView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        infoView.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.leading.equalTo(self.contentView.snp.leading).offset(16)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.leading.lessThanOrEqualTo(self.infoView.snp.trailing).offset(10)
        }
        
        arrowView.snp.makeConstraints { make in
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
    }
}
