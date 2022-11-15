import Foundation
import Alamofire

enum SeSACAPI {
    case signUP(phoneNumber: String, FCMtoken: String, nick: String, birth: String, Email: String, gender: Int)
    case profile
}

extension SeSACAPI {
    var parameters: [String: Any]{
        switch self {
        case .signUP(let phoneNumber, let FCMtoken, let nick, let birth, let Email, let gender):
            return [
                "phoneNumber" : phoneNumber,
                "FCMtoken" : FCMtoken,
                "nick": nick,
                "birth": birth,
                "email": Email,
                "gender" : gender
            ]
        default: return ["":""]
        }
    }
}
