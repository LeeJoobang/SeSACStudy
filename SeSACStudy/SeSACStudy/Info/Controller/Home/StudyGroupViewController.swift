import UIKit

class StudyGroupViewController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let search = UISearchBar(frame: CGRect(x: 0, y: 0, width: 310, height: 0))
        search.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: search)
    }
    
}
