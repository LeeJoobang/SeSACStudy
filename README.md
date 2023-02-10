## Service Level Project

### 앱 소개

| ![1](https://user-images.githubusercontent.com/84652513/218088803-2b77606b-372c-4772-a16b-ef2ab116eeeb.jpeg) | ![2](https://user-images.githubusercontent.com/84652513/218088908-3008fabf-fc46-404f-8116-8e18f80bfc51.jpeg) | ![3](https://user-images.githubusercontent.com/84652513/218088975-c6cd060f-4876-455a-8a30-b01bc4486283.jpeg) | ![4](https://user-images.githubusercontent.com/84652513/218089029-9bf7dc56-baaa-4849-9cdb-1d13712b0301.jpeg) |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |

| ![5](https://user-images.githubusercontent.com/84652513/218089167-95772efa-ace0-4243-8648-d1e269c5b7da.jpeg) | ![6](https://user-images.githubusercontent.com/84652513/218089555-acfa2b78-670a-4e3c-881e-8ed41177d1f7.jpeg) | ![7](https://user-images.githubusercontent.com/84652513/218089628-939d948a-8183-475d-b0c2-1c94465faedb.jpeg) | ![8](https://user-images.githubusercontent.com/84652513/218089730-77652948-ad8a-4791-8e97-50c351258ad7.jpeg) |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |

- 현재 사용자 위치에서 스터디를 원하는 새싹 멤버들을 매칭하는 기능을 구현했습니다. Firebase Auth를 사용해 사용자 핸드폰 번호를 통해 본인을 인증합니다. 회원 정보를 입력함으로써 개인 정보를 입력하고 서버에 입력하였습니다. CompositionLayout을 활용해 레이아웃의 유연성을 높일 수 있습니다. CLLocation을 사용해 지도에 표시된 스터디원을 유무를 확인할 수 있습니다.

### 개발기간 및 사용 기술

#### 개발기간

- `22. 11. 07. - 12. 07.(5주)

#### 사용 기술

- UIKit, Autolayout, SnapKit, MapKit, Firebase Auth, SPM, Figma, SocketIO, Alamofire, FireBaseAuth, FCM, Toast, SocketIO

### 고민과 해결

- 코드의 상세 내용이나, 불필요한 외부 노출을 명시적으로 제한하고자 접근 제어자 사용

  ```swift
  // MARK: 전화번호 변경
  // 번호에 대한 간섭이 일어날 경우 회원가입 구별에 대한 문제가 생길 수 있으므로 쉽사리 접근하지 못하도록 관리에 신경써야함.
      private func phoneNumberformat(with mask: String, phone: String) -> String {
          let numbers = phone.replacingOccurrences(of: "^01([0|1])([0-9]{9})$", with: "", options: .regularExpression)
          var result = ""
          var index = numbers.startIndex
          for ch in mask where index < numbers.endIndex {
              if ch == "X" {
                  result.append(numbers[index])
                  index = numbers.index(after: index)
              } else {
                  result.append(ch)
              }
          }
          return result
      }
  ```

- 회원가입 및 사용되는 View의 중복된 UI 및 특성있는 뷰에 대해 능동적으로 대응하기 위해 BaseView를 기준으로  CustomView를 만들어 적절한 대응을 하고자 함.

  ```swift
  	//BaseView
  class BaseView: UIView { 
      override init(frame: CGRect) {
          super.init(frame: frame)
          configure()
          setConstraints()
      }
      required init?(coder: NSCoder) {
          fatalError()
      }
      func configure() { }
      
      func setConstraints() { }
  }
  
  // customView
  class LoginView: BaseView{
      
      let numberTextLabel: UILabel = {
          let label = UILabel()
          return label
      }()
      // 중략
      
      override init(frame: CGRect) {
          super.init(frame: frame)
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      override func configure() {
          [numberTextLabel, numberView, numberTextField, certificationButton].forEach {
              self.addSubview($0)
          }
      }
      
      override func setConstraints() {
        // 중략
          numberTextLabel.snp.makeConstraints { make in
              make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(125)
              make.centerX.equalToSuperview()
              make.height.equalTo(64)
          }
      }
  }
  
  ```

- 스터디명이 작성될 경우 텍스트 크기에 따라 뷰의 표시를 유동적으로 할 수 있는 부분에 대해 고민하였음. 이를 해결하기 위해 CompositionLayout을 활용함. 

  ```swift
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
  ```

- 회원가입 후 서버로부터 받아온 정보(email, FCMtoken, nick etc)를 여러 뷰에서 공용으로 사용하기 위해 Singleton Pattern 사용

  ```swift
  // 싱글톤 1. 정보
  class UpdateInfo{
      static let shared = UpdateInfo()
      
      var _id: String?
    // 중략
      private init() { }
  
  }
  // 싱글톤 2. FCM 토큰 
  class FCMService{
      static let shared = FCMService()
      
      // MARK: verificationID
      func getCredential(verficationID: String, vericationCode: String, completion: @escaping(Bool, Error?) -> Void){
             }
      //중략
      private init(){}
  }
  
  ```

### 회고

- 서비스 레벨에서 이뤄지는 과제에 대한 명세서를 받아 이를 확인하고 작업을 진행하는 과정이 쉽지 않았습니다. 과제 정의가 이뤄져 있지만, 세부적인 내용에 대해서는 실무자(멘토)를 통해 내용을 확인하고, 이를 설득하는 과정이 필요했습니다. 더불어 Confluence 활용을 해볼 수 있었습니다.
- 표현되는 뷰가 많아짐에 따라 중복도 늘어갔습니다. 기본이 되는 뷰를 활용해 중복성을 최대한 줄여보려고 CustomView를 사용했지만, 그럼에도 불구하고 뷰의 갯수가 많아 처리가 쉽지 않았습니다.
- 이전까지 Table View, Collection View를 사용해 뷰를 표현했지만, 유동적인 텍스트를 자연스럽게 표현하기 위해 고민했습니다. Composition Layout을 구성하는 item, group, section을 활용해 구성하는데, Section별로 다른 레이아웃을 구성하기에 용이하다는 것을 배울 수 있었습니다. 
