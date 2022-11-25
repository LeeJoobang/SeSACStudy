import Foundation

enum HTTPInfomation {
    static let apiBaseURL = "http://api.sesac.co.kr:1210"
    static let contentKey = "Content-Type"
    static let idtokenKey = "idtoken"
    static let contentValue = "application/x-www-form-urlencoded"
}

enum HTTPPath {
    static let userPath = "/v1/user"
    static let searchPath = "/v1/queue/search"
    static let mypagePath = "/v1/user/mypage"
    static let withdrawPath = "/v1/user/withdraw"
}
