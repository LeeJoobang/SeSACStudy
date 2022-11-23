import UIKit

class AlertViewController: BaseViewController{
    
    let alertView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정말 탈퇴하시겠습니까?"
        label.font = UIFont(name: UIFont.notoMedium , size: 16)
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "탈퇴하시면 새싹 스터디를 이용할 수 없어요ㅠ"
        label.font = UIFont(name: UIFont.notoRegular , size: 14)
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .customGray2
        return button
        
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .customGreen
        return button
        
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        buttonAction()
    }
    
    override func configure() {
        self.view.addSubview(alertView)
        [titleLabel, contentLabel, cancelButton, confirmButton].forEach {
            alertView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        alertView.snp.makeConstraints { make in
            make.centerY.equalTo(self.view.snp.centerY)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(156)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(alertView.snp.centerX)
            make.top.equalTo(alertView.snp.top).offset(16)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.centerX.equalTo(alertView.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(16)
            make.leading.equalTo(alertView.snp.leading).offset(16)
            make.trailing.equalTo(alertView.snp.centerX).offset(-4)
            make.height.equalTo(48)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(16)
            make.leading.equalTo(alertView.snp.centerX).offset(4)
            make.trailing.equalTo(alertView.snp.trailing).offset(-16)
            make.height.equalTo(48)
        }
    }
    
    func buttonAction(){
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)

    }
    
    @objc func cancelButtonClicked(){
        dismiss(animated: true)
    }
    @objc func confirmButtonClicked(){
        dismiss(animated: true)
        let apiService = APIService()
        apiService.withdraw { code in
            switch code {
            case 200:
                print("🍄 SeSAC Study 회원탈퇴 성공")
                let vc = OnboadingViewController()
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                guard let delegate = sceneDelegate else { return }
                delegate.window?.rootViewController = vc
                
            case 401:
                print("🍄 Firebase Token Error")
            case 406:
                print("🍄 이미 탈퇴 처리된 회원/미가입 회원")
            case 500:
                print("🍄 Server Error")
            case 501:
                print("🍄 Client Error")
            default:
                fatalError()
            }
        }
    }
}
