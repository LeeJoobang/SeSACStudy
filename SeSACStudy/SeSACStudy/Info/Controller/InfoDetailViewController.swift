import UIKit

class InfoDetailViewController: BaseViewController{
    
    let infoDetailView = InfoTableView()
    private let infoDetailList = ["내 성별", "자주 하는 스터디", "내 번호 검색 허용", "상대방 연령대", "회원탈퇴"]
    
    private var leftButtonState: Bool = true {
        didSet{
            if leftButtonState {
                rightButtonState = false
                infoDetailView.tableView.reloadData()
            }
        }
    }
    
    private var rightButtonState: Bool = false {
        didSet{
            if rightButtonState {
                leftButtonState = false
                infoDetailView.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = infoDetailView
        infoDetailView.backgroundColor = .white
        infoDetailView.tableView.delegate = self
        infoDetailView.tableView.dataSource = self
        registerCell()
        infoDetailView.tableView.separatorStyle = .none
    }
    
    func registerCell(){
        self.infoDetailView.tableView.register(BackgroundTableViewCell.self, forCellReuseIdentifier: BackgroundTableViewCell.reuseIdentifier)
        self.infoDetailView.tableView.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.reuseIdentifier)
        self.infoDetailView.tableView.register(GenderTableViewCell.self, forCellReuseIdentifier: GenderTableViewCell.reuseIdentifier)
        self.infoDetailView.tableView.register(StudyTableViewCell.self, forCellReuseIdentifier: StudyTableViewCell.reuseIdentifier)
        self.infoDetailView.tableView.register(NumberTableViewCell.self, forCellReuseIdentifier: NumberTableViewCell.reuseIdentifier)
        self.infoDetailView.tableView.register(AgeTableViewCell.self, forCellReuseIdentifier: AgeTableViewCell.reuseIdentifier)
        self.infoDetailView.tableView.register(WithdrawalTableViewCell.self, forCellReuseIdentifier: WithdrawalTableViewCell.reuseIdentifier)
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
    // MARK: section 2개 구분
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // MARK: section별 row 갯수 적용
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 5
        default:
            fatalError()
        }
    }
    
    // MARK: section - row별 각 cell 표시
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            // MARK: case 0 - background Image, name + case 1 - gender etc.
        case 0:
            switch indexPath.row{
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: BackgroundTableViewCell.reuseIdentifier, for: indexPath) as! BackgroundTableViewCell
                cell.backgroundImage.image = UIImage(named: "background1")
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: NameTableViewCell.reuseIdentifier, for: indexPath) as! NameTableViewCell
                cell.infoLabel.text = "김새싹"
                cell.infoLabel.font = UIFont(name: UIFont.notoRegular, size: 14)
                cell.arrowView.image = UIImage(named: "arror")
                return cell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row{
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: GenderTableViewCell.reuseIdentifier, for: indexPath) as! GenderTableViewCell
                cell.label.text = "내성별"
                cell.label.font = UIFont(name: UIFont.notoRegular, size: 14)
                
                cell.leftButtonClicked(state: leftButtonState)
                cell.rightButtonClicked(state: rightButtonState)
                cell.leftButton.addTarget(self, action: #selector(leftButtonToggle), for: .touchUpInside)
                cell.rightButton.addTarget(self, action: #selector(rightButtonToggle), for: .touchUpInside)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: StudyTableViewCell.reuseIdentifier, for: indexPath) as! StudyTableViewCell
                guard let customGray3 = UIColor.customGray3 else { return UITableViewCell() }
                
                cell.label.text = "자주 하는 스터디"
                cell.label.font = UIFont(name: UIFont.notoRegular, size: 14)
                
                cell.textfield.placeholder = "스터디를 입력해 주세요"
                cell.textfield.font = UIFont(name: UIFont.notoRegular, size: 14)
                
                cell.textfield.textAlignment = .center
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: NumberTableViewCell.reuseIdentifier, for: indexPath) as! NumberTableViewCell
                cell.label.text = "내 번호 검색 허용"
                cell.label.font = UIFont(name: UIFont.notoRegular, size: 14)
                
                cell.switchBox.isOn = true
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: AgeTableViewCell.reuseIdentifier, for: indexPath) as! AgeTableViewCell
                cell.label.text = "상대방 연령대"
                cell.label.font = UIFont(name: UIFont.notoRegular, size: 14)
                
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: WithdrawalTableViewCell.reuseIdentifier, for: indexPath) as! WithdrawalTableViewCell
                cell.label.text = "회원탈퇴"
                cell.label.font = UIFont(name: UIFont.notoRegular, size: 14)
                return cell
            default:
                fatalError()
            }
        default:
            fatalError()
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && (indexPath.row == 0) {
            return 194
        } else if indexPath.section == 1 && (indexPath.row == 3){
            return 80
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 4 {
            }
        }
    }
}

// MARK: 성별 toggle 반응에 따른 상태 변화
extension InfoDetailViewController{
    @objc func leftButtonToggle() {
        leftButtonState.toggle()
    }
    
    @objc func rightButtonToggle(){
        rightButtonState.toggle()
    }
}
