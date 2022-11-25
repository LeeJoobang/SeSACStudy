import Foundation
import Alamofire

enum SeSACAPI {
    case signUP(phoneNumber: String, FCMtoken: String, nick: String, birth: String, Email: String, gender: Int)
    case saveInformation(searchable: Int, ageMin: Int, ageMax: Int, gender: Int, study: String)
    case profile
    case withdraw
    case currentLocation(lat: Double, long: Double)
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
        case .saveInformation(let searchable, let ageMin, let ageMax, let gender, let study):
            return [
                "searchable" : searchable,
                "ageMin" : ageMin,
                "ageMax" : ageMax,
                "gender" : gender,
                "study" : study
            ]
        case .currentLocation(let lat, let long):
            return [
                "lat": lat,
                "long": long
            ]
        default: return ["":""]
        }
    }
}
