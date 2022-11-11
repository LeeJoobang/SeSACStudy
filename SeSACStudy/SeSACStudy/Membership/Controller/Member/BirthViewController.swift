import UIKit

class BirthiewController: BaseViewController {
    
    let birthView = BirthView()
    private let datePicker = UIDatePicker()
    private var date: Data?
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = birthView
        view.backgroundColor = .white
        //첫화면 - datepicker 등장
        // 만 나이 17세 버튼 활성화
        configureDatePicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let customGray3 = UIColor.customGray3 else { return }
        birthView.leftView.textfield.layer.addBorder([.bottom], color: customGray3, width: 1.0)
        birthView.centerView.textfield.layer.addBorder([.bottom], color: customGray3, width: 1.0)
        birthView.rightView.textfield.layer.addBorder([.bottom], color: customGray3, width: 1.0) 
    }

    
    override func configure() {
        let text = "생년월일을 알려주세요"
        birthView.BirthTextLabel.numberOfLines = 0
        birthView.BirthTextLabel.font = UIFont(name: UIFont.notoMedium, size: 20)
        birthView.BirthTextLabel.text = text
        birthView.BirthTextLabel.textAlignment = .center
        
        birthView.leftView.label.textColor = .black
        birthView.leftView.label.textAlignment = .center
        birthView.leftView.label.text = "년"
        birthView.leftView.label.font = UIFont(name: UIFont.notoRegular, size: 16)
        birthView.centerView.label.textColor = .black
        birthView.centerView.label.textAlignment = .center
        birthView.centerView.label.text = "월"
        birthView.centerView.label.font = UIFont(name: UIFont.notoRegular, size: 16)
        birthView.rightView.label.textColor = .black
        birthView.rightView.label.textAlignment = .center
        birthView.rightView.label.text = "일"
        birthView.rightView.label.font = UIFont(name: UIFont.notoRegular, size: 16)
        
        birthView.certificationButton.backgroundColor = .customGray6
        birthView.certificationButton.titleLabel?.font = UIFont(name: UIFont.notoMedium, size: 14)
        birthView.certificationButton.setTitle("다음", for: .normal)
        birthView.certificationButton.tintColor = .customGray3
        birthView.certificationButton.layer.cornerRadius = 5
        birthView.certificationButton.addTarget(self, action: #selector(buttonClicked(button: )), for: .touchUpInside)
    }
        
    @objc func buttonClicked(button: UIButton){
        let vc = EmailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: 날짜 선택
    private func configureDatePicker(){
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko_KR")
        self.birthView.leftView.textfield.inputView = self.datePicker
        self.birthView.centerView.textfield.inputView = self.datePicker
        self.birthView.rightView.textfield.inputView = self.datePicker
    }
    
    // MARK: 날짜 선택 - 각 텍스트뷰 년도, 월, 일 구분
    @objc func datePickerValueDidChange(_ datePicker: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.locale = Locale(identifier: "ko_KR")
        let dates = formatter.string(from: datePicker.date).split(separator: " ")
        let year = String(describing: dates[0])
        let month = String(describing: dates[1])
        let day = String(describing: dates[2])

        self.birthView.leftView.textfield.text = year
        self.birthView.centerView.textfield.text = month
        self.birthView.rightView.textfield.text = day

    }
    
}

