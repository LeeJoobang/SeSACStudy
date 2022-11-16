import UIKit

class InfoDetailViewController: BaseViewController{
    
    let infoDetailView = InfoTableView()
    private let infoDetailList = ["내 성별", "자주 하는 스터디", "내 번호 검색 허용", "상대방 연령대", "회원탈퇴"]
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = infoDetailView
        infoDetailView.backgroundColor = .white
        infoDetailView.tableView.delegate = self
        infoDetailView.tableView.dataSource = self
        self.infoDetailView.tableView.register(BackgroundTableViewCell.self, forCellReuseIdentifier: BackgroundTableViewCell.reuseIdentifier)
        self.infoDetailView.tableView.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.reuseIdentifier)

   }
    
    override func configure() {
        navigationInfo()
    }
    
    private func navigationInfo(){
        navigationItem.title = "정보 관리"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black.cgColor]
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(title: "저장", style: .plain, target: nil, action: #selector(clickedButton))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func clickedButton(button: UIButton){
        print("다음버튼 클릭")
    }
}

extension InfoDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row{
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: BackgroundTableViewCell.reuseIdentifier, for: indexPath) as! BackgroundTableViewCell
                
                cell.backgroundImage.image = UIImage(named: "background1")
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: NameTableViewCell.reuseIdentifier, for: indexPath) as! NameTableViewCell
                cell.infoLabel.text = "김새싹"
                cell.arrowView.image = UIImage(named: "arror")
                
                
                return cell
            default:
                fatalError()
            }
        case 1:
            print("indexpath.section case 1에 해담함")
        default:
            fatalError()
            
        }
        return UITableViewCell()
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        switch indexPath.section{
//        case 0:
//            switch indexPath.row{
//            case 1:
//                return 60
//            default:
//                fatalError()
//            }
//        case 1:
//            switch indexPath.row{
//            case 0, 1, 2, 4:
//                return 60
//            case 3:
//                return 80
//            default:
//                fatalError()
//            }
//        default:
//            fatalError()
//        }
//
//    }

    
    
}
