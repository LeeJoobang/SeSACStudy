import UIKit

import SnapKit

class StudyGroupViewController: UIViewController{
    
    let text = [
        "아무거나",
        "SeSAC",
        "코딩",
        "Swift",
        "SwiftUI",
        "CoreData",
        "Python",
        "Java"
    ]
    
    var searchTexts = [String]()
    
    lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(StudyGroupHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StudyGroupHeaderView.id)
        view.register(StudyGroupViewCell.self, forCellWithReuseIdentifier: StudyGroupViewCell.id)
        view.register(StudyGroupSecondViewCell.self, forCellWithReuseIdentifier: StudyGroupSecondViewCell.id)
        return view
    }()
    
    let certificationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customGreen
        button.layer.cornerRadius = 10
        button.setTitle("새싹찾기", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        self.tabBarController?.tabBar.isHidden = true
        collectionView.addSubview(certificationButton)
        collectionView.delegate = self
        collectionView.dataSource = self
        let search = UISearchBar(frame: CGRect(x: 0, y: 0, width: 310, height: 0))
        search.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: search)
        search.delegate = self
        certificationButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        setConstraint()
    }
    
    @objc func buttonClicked(){
    }
    
    func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 8.0
        let height: CGFloat = 32.0
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(60), heightDimension: .absolute(height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16+32, leading: 16, bottom: 8, trailing: 16)
        section.interGroupSpacing = spacing
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(18)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top, absoluteOffset: CGPoint(x: 0, y: 32))
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
//        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func setConstraint(){
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(36)
            make.leading.equalTo(self.view.snp.leading).offset(16)
            make.trailing.equalTo(self.view.snp.trailing).offset(-16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(0)
        }
        
        certificationButton.snp.makeConstraints { make in
            make.leading.equalTo(self.view.snp.leading).offset(16)
            make.trailing.equalTo(self.view.snp.trailing).offset(-16)
            make.height.equalTo(48)
            make.bottom.lessThanOrEqualTo(collectionView.keyboardLayoutGuide.snp.top).offset(-10)
        }
    }
}

extension StudyGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return text.count
        case 1:
            return searchTexts.count
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section{
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StudyGroupViewCell.id, for: indexPath) as? StudyGroupViewCell else { return UICollectionViewCell() }
            switch indexPath.item {
            case 0...2:
                cell.studyTitleLabel.text = text[indexPath.item]
                cell.studyTitleLabel.textColor = .red
                cell.layer.borderColor = UIColor.red.cgColor
                return cell

            case 3...7:
                cell.studyTitleLabel.text = text[indexPath.item]
                cell.studyTitleLabel.textColor = .black
                cell.layer.borderColor = UIColor.customGray4?.cgColor
                return cell

            default:
                fatalError()
            }
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StudyGroupSecondViewCell.id, for: indexPath) as? StudyGroupSecondViewCell else { return UICollectionViewCell() }
            cell.studyTitleLabel.text = searchTexts[indexPath.item]
            cell.studyTitleLabel.textColor = .customGreen
            cell.layer.borderColor = UIColor.customGreen?.cgColor
            return cell

        default:
            fatalError()
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print("kind: \(kind)")
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StudyGroupHeaderView.id, for: indexPath) as! StudyGroupHeaderView
            switch indexPath.section {
            case 0:
                header.label.text = "지금 주변에는"
            case 1:
                header.label.text = "내가 하고 싶은"
            default:
                fatalError()
            }
            return header
        default:
            print("default")
            return UICollectionReusableView()
        }
    }
}

extension StudyGroupViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
//        var tmp = searchText.components(separatedBy: " ")
        if searchText.contains(" "){
            print("🌝띄어쓰기 포함")
            var temp = searchText.components(separatedBy: " ")
            for item in temp {
                if item.count <= 8 {
                    print("🌝8글자 이하")
                    if searchTexts.contains(item){
                        print("이미 포함됨")
                    } else {
                        searchTexts.append(item)
                        print(searchTexts)
                    }
                } else {
                    print("🌝8글자 이상")
                }
            }
        } else if searchText.count <= 8{
            print("🌞8글자 이하")
            if searchTexts.contains(searchText){
                print("이미 포함됨")
            } else {
                searchTexts.append(searchText)
                print(searchTexts)

            }
        } else {
            print("🌞8글자 이상")
        }
        collectionView.reloadData()
    }
}

extension Array where Element: Hashable {
    func removeDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        return filter({ addedDict.updateValue(true, forKey: $0) == nil})
    }
}
