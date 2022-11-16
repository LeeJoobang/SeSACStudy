import UIKit

class BackgroundTableViewCell: BaseTableViewCell {
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.sizeToFit()
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        self.contentView.addSubview(backgroundImage)
    }
    
    override func setConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
    }
}
