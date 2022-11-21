import UIKit

import MultiSlider

class AgeTableViewCell: BaseTableViewCell {
    

    var startAge: Int = 18
    var endAge: Int = 35
    let label: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.notoMedium, size: 14)
        label.textColor = UIColor.customGreen
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
    
    // MARK: multislider - library 사용
    let multislider: MultiSlider = {
        let slider = MultiSlider()
        slider.minimumValue = 18.0
        slider.maximumValue = 65.0
        slider.value = [18.0, 35.0]
        
        slider.orientation = .horizontal
        slider.isVertical = false
        
        slider.tintColor = .customGreen
        slider.outerTrackColor = .customGray3
        slider.thumbTintColor = .customGreen
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        
        return slider
    }()
    
    @objc func sliderChanged(slider: MultiSlider) {
        print("thumb \(slider.draggedThumbIndex) moved")
        print("now thumbs are at \(slider.value)") // e.g., [1.0, 4.5, 5.0]
        startAge = Int(round(slider.value[0]))
        endAge = Int(round(slider.value[1]))
        
        ageLabel.text = "\(String(describing: startAge))-\(String(describing: endAge))"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [label, ageLabel, multislider].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.leading.equalTo(self.contentView.snp.leading).offset(16)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
        }
        
        multislider.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY).offset(8)
            make.leading.trailing.equalToSuperview().inset(26)
        }
        
    }
}
