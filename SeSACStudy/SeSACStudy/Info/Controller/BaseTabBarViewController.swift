import Foundation
import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
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
}
