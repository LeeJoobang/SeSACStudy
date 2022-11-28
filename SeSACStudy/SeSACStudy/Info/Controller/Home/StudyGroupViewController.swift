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
    
    lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(StudyGroupHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StudyGroupHeaderView.id)
        view.register(StudyGroupViewCell.self, forCellWithReuseIdentifier: StudyGroupViewCell.id)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        let search = UISearchBar(frame: CGRect(x: 0, y: 0, width: 310, height: 0))
        search.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: search)
        setConstraint()
    }
    
    func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 8.0
        let height: CGFloat = 32.0
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(60), heightDimension: .absolute(height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.80), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(spacing)
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func setConstraint(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        
    }
    
}

extension StudyGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return text.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StudyGroupViewCell.id, for: indexPath) as? StudyGroupViewCell else { return UICollectionViewCell() }
        cell.studyTitleLabel.text = text[indexPath.item]
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print("kind: \(kind)")
        
//        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StudyGroupHeaderView.id, for: indexPath) as? StudyGroupHeaderView else {return UICollectionReusableView()}
//        header.prepare(text: "헤더 타이틀")
//        return header
//
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
