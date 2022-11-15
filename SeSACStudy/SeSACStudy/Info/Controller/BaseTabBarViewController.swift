import Foundation
import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self

        let selectedItemTextColor = UIColor.customGreen
        let unselectedItemTextColor = UIColor.customGray6

        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedItemTextColor]
        tabBarApperance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: unselectedItemTextColor]
                
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem.selectedImage = UIImage(named: "homeSelect")
        homeVC.tabBarItem.image = UIImage(named: "home")
        homeVC.tabBarItem.title = "홈"
        
        let shopVC = UINavigationController(rootViewController: ShopViewController())
        shopVC.tabBarItem.selectedImage = UIImage(named: "shopSelect")
        shopVC.tabBarItem.image = UIImage(named: "shop")
        shopVC.tabBarItem.title = "새싹샵"
        
        let friendVC = UINavigationController(rootViewController: FriendViewController())
        friendVC.tabBarItem.selectedImage = UIImage(named: "friendSelect")
        friendVC.tabBarItem.image = UIImage(named: "friend")
        friendVC.tabBarItem.title = "새싹친구"
        
        let infoVC = UINavigationController(rootViewController: InfoViewController())
        infoVC.tabBarItem.selectedImage = UIImage(named: "infoSelect")
        infoVC.tabBarItem.image = UIImage(named: "info")
        infoVC.tabBarItem.title = "내정보"
        
        
        viewControllers = [homeVC, shopVC, friendVC, infoVC]
    }

}
