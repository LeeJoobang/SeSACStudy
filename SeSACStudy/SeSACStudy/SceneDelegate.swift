import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if UserDefaults.standard.bool(forKey: "First") { //onboard
            if UserDefaults.standard.bool(forKey: "success") { //가입 완료
                var vc = LaunchViewController()
                let nav = UINavigationController(rootViewController: vc)
                self.window?.rootViewController = vc
                
                DispatchQueue.global().async {
                    vc.getData { statusCode, User in
                        switch statusCode{
                        case 200:
                            print("데이터 정상적으로 담았음.")
                            print("user.nick: \(User?.nick)")
                            let vc = BaseTabBarController()
                            self.window?.rootViewController = vc
                        case 401:
                            print("fcm token 만료")
                        default:
                            fatalError()
                        }
                    }
                }
            } else {
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                window?.rootViewController = nav
            }
        } else {
            let vc = OnboadingViewController()
            window?.rootViewController = UINavigationController(rootViewController: vc)
        }
        window?.makeKeyAndVisible()
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
}
