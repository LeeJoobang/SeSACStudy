import Foundation

import Alamofire
import FirebaseAuth

struct User: Codable{
    let _id: String
    let __v: Int
    let uid: String
    let phoneNumber: String
    let email: String
    let FCMtoken: String
    let nick: String
    let birth: String
    let gender: Int
    let study: String
    let comment: [String]
    let reputation: [Int]
    let sesac: Int
    let sesacCollection: [Int]
    let background: Int
    let backgroundCollection: [Int]
    let purchaseToken: [String]
    let transactionId: [String]
    let reviewedBefore: [String]
    let reportedNum: Int
    let reportedUser: [String]
    let dodgepenalty: Int
    let dodgeNum: Int
    let ageMin: Int
    let ageMax: Int
    let searchable: Int
    let createdAt: String
}


class APIService{
//    func getProfile(id idToken: String) {
//        let apiURL = URL(string: "http://api.sesac.co.kr:1210/v1/user")!
//        let apiHeaders: HTTPHeaders = [
//            "Content-Type": "application/x-www-form-urlencoded",
//            "idtoken": idToken
//        ]
//        AF.request(apiURL, method: .get, headers: apiHeaders)
//            .responseDecodable(of: User.self) { response in
//                print(response)
//                switch response.result {
//
//                case .success(let value):
//                    print(value)
//                case .failure(_):
//                    print("error")
//                }
//            }
//    }
    
    // MARK: .get 을 유저 유무를 확인하는 메소드
    func profile(id idToken: String, completion: @escaping(Int?, User?) -> Void) {
        //         let api = SeSACAPI.profile // api의 url과 header값이 필요하다.
        let apiURL = URL(string: "http://api.sesac.co.kr:1210/v1/user")!
        let apiHeaders: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "idtoken": idToken
        ]
        AF.request(apiURL, method: .get, headers: apiHeaders)
            .responseDecodable(of: User.self) { response in
                let statusCode = response.response?.statusCode
//                let data = response.data
//                print("🌹reponse data: \(data)")
//                print("🌹reponse status: \(statusCode)")
//                print("🌹response.result: \(response.result)")
                switch response.result{
                case .success(let data):
                    print(data)
                    print("🌹Singleton Data Input 성공")
                    completion(statusCode, data)
                case .failure(_:):
                    print("실패")
                    print(response.response?.statusCode)
                    if response.response?.statusCode == 401 {
                        print("실패 401 - userdefault 값 전체 삭제")
                        for key in UserDefaults.standard.dictionaryRepresentation().keys {
                                    UserDefaults.standard.removeObject(forKey: key.description)
                                }

                    }
                    completion(statusCode, nil)
                }
            }
    }
    
    func signup(completion: @escaping(Int?) -> Void){ // 등록절차
        guard let idToken = UserDefaults.standard.string(forKey: "idToken") else { return }
        guard let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") else { return  }
        guard let fcmToken = UserDefaults.standard.string(forKey: "fcmToken") else { return }
        guard let nick = UserDefaults.standard.string(forKey: "nickName") else { return }
        guard let birth = UserDefaults.standard.string(forKey: "birth") else { return }
        guard let email = UserDefaults.standard.string(forKey: "email") else { return }
        let gender = UserDefaults.standard.integer(forKey: "gender")
        
        print("🌹 idtoken: \(String(describing: idToken))")
        print("🌹 phoneNumber: \(String(describing: phoneNumber))")
        print("🌹 FCMtoken: \(String(describing: fcmToken))")
        print("🌹 nickName: \(String(describing: nick))")
        print("🌹 birth: \(String(describing: birth))")
        print("🌹 email: \(String(describing: email))")
        print("🌹 gender: \(String(describing: gender))")
        
        let api = SeSACAPI.signUP(phoneNumber: phoneNumber, FCMtoken: fcmToken, nick: nick, birth: birth, Email: email, gender: gender)
        let apiURL = URL(string: "http://api.sesac.co.kr:1210/v1/user")!
        let apiHeaders: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "idtoken": idToken
        ]
        
        AF.request(apiURL, method: .post, parameters: api.parameters, headers: apiHeaders).responseString {
            response in
            print(response)
            print(response.response?.statusCode)
            print("🌹APIService - Signup: 등록완료")
            completion(response.response?.statusCode) // 등록이 완료되었을 때 코드를 불러와 적용
        }
    }
    
    /*
     
     {baseURL}/v1/user/mypage
     
     {
     2   "searchable" : 1,
     3   "ageMin" : 20,
     4   "ageMax" : 30,
     5   "gender" : 1,
     6   "study" : "Coding"
     7}
     */
    
    
    func saveInformation(completion: @escaping(Int?) -> Void){
        guard let idToken = UserDefaults.standard.string(forKey: "idToken") else { return }
        guard let searchable = UpdateInfo.shared.searchable else
        { return }
        guard let ageMin = UpdateInfo.shared.ageMin else
        { return }
        guard let ageMax = UpdateInfo.shared.ageMax else
        { return }
        guard let gender = UpdateInfo.shared.gender else
        { return }
        guard let study = UpdateInfo.shared.study else
        { return }

        let api = SeSACAPI.saveInformation(searchable: searchable, ageMin: ageMin, ageMax: ageMax, gender: gender, study: study)
        let apiURL = URL(string: "http://api.sesac.co.kr:1210/v1/user/mypage")!
        let apiHeaders: HTTPHeaders = [
            "idtoken": idToken
        ]
        
        AF.request(apiURL, method: .put, parameters: api.parameters, headers: apiHeaders).responseString {
            response in
            print(response)
            print(response.response?.statusCode)
            print("🌹APIService - 저장: 저장완료")
            completion(response.response?.statusCode) // 등록이 완료되었을 때 코드를 불러와 적용
        }
    }
    
    
    func withdraw(completion: @escaping(Int?) -> Void){
        guard let idToken = UserDefaults.standard.string(forKey: "idToken") else { return }
        
        let apiURL = URL(string: "http://api.sesac.co.kr:1210/v1/user/withdraw")!
        let apiHeaders: HTTPHeaders = [
            "idtoken": idToken
        ]
        
        AF.request(apiURL, method: .post, headers: apiHeaders).responseString {
            response in
            print(response)
            print(response.response?.statusCode)
            print("🌹APIService - 탈퇴: 탈퇴완료")
            completion(response.response?.statusCode) // 등록이 완료되었을 때 코드를 불러와 적용
        }
        
    }
}
