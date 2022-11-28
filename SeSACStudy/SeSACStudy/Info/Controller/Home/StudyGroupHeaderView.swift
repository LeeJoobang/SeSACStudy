import UIKit

import SnapKit

final class StudyGroupHeaderView: UICollectionReusableView {
    
    static let id = "studyGroupHeaderView"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        setConstraint()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraint(){
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
    }
}
