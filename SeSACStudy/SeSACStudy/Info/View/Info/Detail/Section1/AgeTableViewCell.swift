import UIKit

class AgeTableViewCell: BaseTableViewCell {
    
    
    let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let sliderImage: UISlider = {
        let slider = UISlider(frame:CGRectMake(20, 260, 280, 20))
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.tintColor = UIColor.customGreen
        slider.value = 50
        return slider
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [label, sliderImage].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.leading.equalTo(self.contentView.snp.leading).offset(16)
        }
        
        sliderImage.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
    }
}
