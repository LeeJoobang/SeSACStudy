import UIKit

import SnapKit

class TestCompositionLayoutViewController: UIViewController{
    
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
        view.register(TestCompostionLayoutViewCell.self, forCellWithReuseIdentifier: TestCompostionLayoutViewCell.id)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view = collectionView
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        
        
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
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
}

extension TestCompositionLayoutViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return text.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCompostionLayoutViewCell.id, for: indexPath) as? TestCompostionLayoutViewCell else { return UICollectionViewCell() }
        cell.studyTitleLabel.text = text[indexPath.item]
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
}
