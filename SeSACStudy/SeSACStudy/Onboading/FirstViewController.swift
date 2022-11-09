import UIKit

import SnapKit

class FirstViewController: BaseViewController{
    let textImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text_img1")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let contentImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "onboarding_img1")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(textImage)
            view.addSubview(contentImage)
            textImage.snp.makeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(72)
                make.leading.trailing.equalToSuperview().inset(72)
                make.height.equalTo(50)
            }
        
        contentImage.snp.makeConstraints { make in
            make.top.equalTo(textImage.snp.bottom).offset(56)
            make.leading.trailing.equalToSuperview().inset(7)
            make.height.equalTo(360)
        }
    }
    
}
