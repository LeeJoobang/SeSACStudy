import UIKit

class StudyGroupReusableView: UICollectionReusableView{
    
    static let id = "StudyGroupReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        
    }
    
    private func setConstraint(){
        
    }
}
