import UIKit

import SnapKit

final class StudyGroupHeaderView: UICollectionReusableView {
    
    static let id = "studyGroupHeaderView"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraint(){
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(0)
            make.left.trailing.equalToSuperview().inset(0)
        }
    }
}
