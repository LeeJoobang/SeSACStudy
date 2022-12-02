import UIKit

import Alamofire

class GenderViewController: BaseViewController {
    
    let genderView = GenderView()
    var womanResult = Int()
    var manResult = Int()
    
    
    private var leftButtonState: Bool = false {
        didSet{
            if leftButtonState {
                rightButtonState = false
                manResult = 1
            } else {
                manResult = 0
            }
        }
    }
    
    private var rightButtonState: Bool = false {
        didSet{
            if rightButtonState {
                leftButtonState = false
                womanResult = 1
            } else {
                womanResult = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = genderView
        genderView.backgroundColor = .white
    }
    
    override func configure() {
        let text = "성별을 선택해 주세요 \n 새싹 찾기 기능을 이용하기 위해서 필요해요."
        genderView.GenderTextLabel.numberOfLines = 0
        genderView.GenderTextLabel.font = UIFont(name: UIFont.notoMedium, size: 20)
        genderView.GenderTextLabel.text = text
        genderView.GenderTextLabel.textAlignment = .center
        
        genderView.leftButton.addTarget(self, action: #selector(leftButtonClicked(button: )), for: .touchUpInside)
        genderView.rightButton.addTarget(self, action: #selector(rightButtonClicked(button: )), for: .touchUpInside)
        
        genderView.certificationButton.backgroundColor = .customGray6
        genderView.certificationButton.titleLabel?.font = UIFont(name: UIFont.notoMedium, size: 14)
        genderView.certificationButton.setTitle("다음", for: .normal)
        genderView.certificationButton.tintColor = .white
        genderView.certificationButton.layer.cornerRadius = 5
        genderView.certificationButton.addTarget(self, action: #selector(buttonClicked(button: )), for: .touchUpInside)
    }
    
    @objc func leftButtonClicked(button: UIButton){
        print("왼쪽 버튼 클릭")
        if rightButtonState == false {
            leftButtonState.toggle()
            if leftButtonState {
                genderView.leftButton.configuration?.baseBackgroundColor = .customGreen
                genderView.certificationButton.backgroundColor = .customGreen
            } else {
                genderView.leftButton.configuration?.baseBackgroundColor = .white
                genderView.certificationButton.backgroundColor = .customGray6
            }
        }
        
    }
    
    @objc func rightButtonClicked(button: UIButton){
        print("오른쪽 버튼 클릭")
        if leftButtonState == false{
            rightButtonState.toggle()
            if rightButtonState {
                genderView.rightButton.configuration?.baseBackgroundColor = .customGreen
                genderView.certificationButton.backgroundColor = .customGreen
            } else {
                genderView.rightButton.configuration?.baseBackgroundColor = .white
                genderView.certificationButton.backgroundColor = .customGray6
            }
        }
    }
    
    @objc func buttonClicked(button: UIButton){
        // MARK: 회원가입 신청
        print("회원가입 버튼 클릭")
        print("womanResult: \(womanResult), manResult: \(manResult)")
        if womanResult == 1 || manResult == 1 {
            print("apiService 진행")
            if womanResult == 1 {
                UserDefaults.standard.set(1, forKey: "gender")
            } else {
                UserDefaults.standard.set(0, forKey: "gender")
            }
            let apiService = APIService()
            // MARK: 회원가입 성공 또는 실패에 대한 로직 반영
            apiService.signup { code in // 성공후에 상태코드를 통해 분기처리함.
                guard let code = code else { return }
                switch code {
                case 200:
                    print("🌹회원가입 성공")
//                    let vc = BaseTabBarController()
//                    self.navigationController?.pushViewController(vc, animated: true)
                    UserDefaults.standard.set(1, forKey: "success")
                    
                    let vc = BaseTabBarController()
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                    guard let delegate = sceneDelegate else { return }
                    delegate.window?.rootViewController = vc
                case 401:
                    print("Firebase Token 만료")
                default:
                    fatalError()
                    
                }
            }
            
            print("")
        } else {
            print("성별을 선택하지 않았습니다.")
        }
    }
}

