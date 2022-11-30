import UIKit

import SnapKit

final class StudyGroupSecondViewCell: UICollectionViewCell{
    static let id = "StudyGroupSecondViewCell"
    
    let studyTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureUI()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUI(){
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1.0
    }
    
    func setupLayout(){
        self.contentView.addSubview(studyTitleLabel)
        studyTitleLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(self.contentView).inset(5)
            $0.leading.trailing.equalTo(self.contentView).inset(16)
        }
    }

}
