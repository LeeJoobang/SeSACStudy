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
    
}
