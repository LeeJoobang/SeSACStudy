import UIKit

class BirthSubView: BaseView{
    
    let textfield: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        return text
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [textfield, label].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        textfield.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        label.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.leading.equalTo(textfield.snp.trailing).offset(-10)
            make.trailing.equalToSuperview().multipliedBy(0.28)
        }


    }
}
