import UIKit

class GenderSubView: BaseView{
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .green
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [imageView, label].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }


    }
}
