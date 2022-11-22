import UIKit

class InfoViewController: BaseViewController{
    
    let infoTableView = InfoTableView()
    private let infoList = ["김새싹", "공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "이용 약관"]
    private let infoImage = ["profile", "faq", "notice", "permit", "qna", "setting_alarm"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = infoTableView
        infoTableView.backgroundColor = .white
        infoTableView.tableView.backgroundColor = .white
        infoTableView.tableView.delegate = self
        infoTableView.tableView.dataSource = self
        
        self.infoTableView.tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.reuseIdentifier)
        
        navigationItem.title = "설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black.cgColor]
        getProfileName()
    }
    
    func getProfileName(){
        guard let idToken = UserDefaults.standard.string(forKey: "idToken") else { return print("somthing weird") }
        let apiService = APIService()
            APIService().profile(id: idToken) { code in
                print(idToken)
                print(code)
            }
        
    }
    
    
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.reuseIdentifier, for: indexPath) as! InfoTableViewCell
        cell.infoLabel.text = infoList[indexPath.row]
        cell.infoView.contentMode = .scaleAspectFit
        cell.infoView.image = UIImage(named: infoImage[indexPath.row])
        cell.arrowView.image = indexPath.row == 0 ? UIImage(named: "arrow") : nil
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return 96
        case 1...5:
            return 74
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            print("🌹내정보 이동")
            let vc = InfoDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1...5:
            print("1-5 row click")
        default:
            fatalError()
        }
    }

}
