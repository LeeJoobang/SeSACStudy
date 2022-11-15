import UIKit

class InfoDetailViewController: BaseViewController{
    
    let infoDetailView = InfoDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = infoDetailView
        infoDetailView.backgroundColor = .white
        self.infoDetailView.tableView.register(InfoDetailViewCell.self, forCellReuseIdentifier: InfoDetailViewCell.reuseIdentifier)

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
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoDetailViewCell.reuseIdentifier, for: indexPath)
        return cell
    }
    
    
}
