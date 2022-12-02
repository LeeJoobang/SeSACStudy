import Foundation
import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {

    let updateUserInfo = UpdateInfo.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
        
        self.delegate = self

        let homeVC = UINavigationController(rootViewController: MapViewController())
        homeVC.tabBarItem.image = UIImage(named: "home")
        homeVC.tabBarItem.title = "홈"
        
        let shopVC = UINavigationController(rootViewController: ShopViewController())
        shopVC.tabBarItem.image = UIImage(named: "shop")
        shopVC.tabBarItem.title = "새싹샵"
        
        let friendVC = UINavigationController(rootViewController: FriendViewController())
        friendVC.tabBarItem.image = UIImage(named: "friend")
        friendVC.tabBarItem.title = "새싹친구"
        
        let infoVC = UINavigationController(rootViewController: InfoViewController())
        infoVC.tabBarItem.image = UIImage(named: "info")
        infoVC.tabBarItem.title = "내정보"
        
        viewControllers = [homeVC, shopVC, friendVC, infoVC]
    }
    
    // MARK: nick 가져오기
    func getUserInfo(){
        guard let id = UserDefaults.standard.string(forKey: "idToken") else { return }
        let api = APIService()
        api.profile(id: id) { statusCode, userInfo in
            //성공 실패 데이터 받아오기
            switch statusCode {
            case 200:
                self.updateUserInfo.nick = userInfo?.nick
                print("🍁updateUserInfo.nick: \(self.updateUserInfo.nick)")
            case 401:
                print("401 error가 발생하였습니다.")
            default:
                fatalError()
            }
            
        }
    }
}
