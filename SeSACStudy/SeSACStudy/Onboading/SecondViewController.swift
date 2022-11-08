import UIKit

import SnapKit

class SecondViewController: UIViewController{
    
    let textImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text_img2")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let contentImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "onboarding_img2")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textImage)
        view.addSubview(contentImage)
        
        textImage.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(72)
            make.leading.equalTo(72)
            make.trailing.equalTo(-72)
            make.height.equalTo(50)
        }
        
        contentImage.snp.makeConstraints { make in
            make.top.equalTo(textImage.snp.bottom).offset(56)
            make.leading.equalTo(7)
            make.trailing.equalTo(-7)
            make.height.equalTo(360)
        }
    }
}

