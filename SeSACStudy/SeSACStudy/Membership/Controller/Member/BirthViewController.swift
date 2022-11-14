import UIKit

class BirthiewController: BaseViewController {
    
    let birthView = BirthView()
    private let datePicker = UIDatePicker()
    private var date: Data?
    private var year = String()
    private var month = String()
    private var day = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = birthView
        view.backgroundColor = .white
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
        birthView.leftView.textfield.becomeFirstResponder() // 첫화면 datepicker 띄우기
        
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
        
        birthView.certificationButton.titleLabel?.font = UIFont(name: UIFont.notoMedium, size: 14)
        birthView.certificationButton.setTitle("다음", for: .normal)
        birthView.certificationButton.tintColor = .customGray3
        birthView.certificationButton.backgroundColor = .customGray6
        birthView.certificationButton.layer.cornerRadius = 5
        
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
        
        self.birthView.leftView.textfield.tintColor = .clear // textfield cursor 깜빡임 처리
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
        year = String(describing: dates[0])
        month = String(describing: dates[1])
        day = String(describing: dates[2])
        
        self.birthView.leftView.textfield.text = year
        self.birthView.centerView.textfield.text = month
        self.birthView.rightView.textfield.text = day
        
        // MARK: 만나이 계산 호출
        let result = iscalculateAge(yy: year, mm: month, dd: day)
        print("result: \(result)")
        if result {
            birthView.certificationButton.backgroundColor = .customGreen
            birthView.certificationButton.isEnabled = true
            birthView.certificationButton.addTarget(self, action: #selector(buttonClicked(button: )), for: .touchUpInside)
        } else {
            birthView.certificationButton.backgroundColor = .customGray3
            birthView.certificationButton.isEnabled = false
        }
    }
    
    // MARK: 만나이 계산 진행
    func iscalculateAge(yy year: String, mm month: String, dd day: String) -> Bool {
        var result = false
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.locale = Locale(identifier: "ko_KR")
        let dates = formatter.string(from: now).split(separator: " ")
        var nowYear = String(describing: dates[0])
        
        var americanAge = (Int(nowYear) ?? 0) - (Int(year) ?? 2022)
        let selectDay = Int(dates[1] + dates[2]) ?? 0
        let today = Int(month + day) ?? 0

        // MARK: 만 계산 세부 로직(선택 월일과 오늘 월일을 비교함)
        if americanAge >= 17 {
            if selectDay < today { 
                print("만 17세 미만이다.")
                result = false
            } else {
                let birth = "\(year)-\(month)-\(day)T09:23:44.054Z"
                print("🌹birth: \(birth)")
                UserDefaults.standard.set(birth, forKey: "birth")
                print("만 17세 이상이다.")
                result = true
            }
        } else {
            print("만 17세 미만이다.")
            result = false
        }
        return result
    }
    
}

