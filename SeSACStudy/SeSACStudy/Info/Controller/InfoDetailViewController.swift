import UIKit

class InfoDetailViewController: BaseViewController{
    
    let infoDetailView = InfoDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = infoDetailView
        infoDetailView.backgroundColor = .white
        self.infoDetailView.tableView.register(InfoDetailViewCell.self, forCellReuseIdentifier: InfoDetailViewCell.reuseIdentifier)
        
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
