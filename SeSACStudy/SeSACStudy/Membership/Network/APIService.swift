import Foundation

import Alamofire

struct Profile: Codable{
    let user: User
}

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
    
    // MARK: .get 을 유저 유무를 확인하는 메소드
    func profile(id idToken: String, completion: @escaping(Int?) -> Void) {
        //         let api = SeSACAPI.profile // api의 url과 header값이 필요하다.
        let apiURL = URL(string: "http://api.sesac.co.kr:1207/v1/user")!
        let apiHeaders: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "idtoken": idToken
        ]
        
        AF.request(apiURL, method: .get, headers: apiHeaders)
            .responseDecodable(of: Profile.self) { response in
                let statusCode = response.response?.statusCode
                print("reponse status: \(response.response?.statusCode)")
                switch response.result{
                case .success(let data):
                    print(data)
                    print("성공")
                    completion(statusCode)
                case .failure(_):
                    print("실패")
                    print(response.response?.statusCode)
                    completion(statusCode)

                }
            }
    }
    
    func signup(id idToken: String){
        guard let fcmToken = UserDefaults.standard.string(forKey: "fcmToken") else { return print("somthing weird") }
        let api = SeSACAPI.signUP(phoneNumber: "+821033225679", FCMtoken: fcmToken, nick: "이주방", birth: "1990-01-16T09:23:44.054Z", Email: "hii5074@gmail.com", gender: 0)
        let apiURL = URL(string: "http://api.sesac.co.kr:1207/v1/user")!
        
        let apiHeaders: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "idtoken": idToken
        ]
        
        print("api.parameters: \(api.parameters)")
        print("api: \(api)")

        
        AF.request(apiURL, method: .post, parameters: api.parameters, headers: apiHeaders).responseString {
            response in
            print("APIService - Signup: 등록완료")
            print(response)
            print(response.response?.statusCode)
        }
    }

    
    
    
}
