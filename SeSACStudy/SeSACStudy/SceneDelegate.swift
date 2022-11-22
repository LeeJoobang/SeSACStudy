import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
//        let vc = BaseTabBarController()
//        let vc = Test2ViewController()
//        let nav = UINavigationController(rootViewController: vc)
//        window?.rootViewController = vc
        

        if UserDefaults.standard.bool(forKey: "First") {
            if UserDefaults.standard.bool(forKey: "success") {
                guard let id = UserDefaults.standard.string(forKey: "idToken") else { return }
                print(id)
                let api = APIService()
                api.profile(id: id) { statusCode, userInfo in
                    print("🌹: \(statusCode)")
                    print("🌹: \(userInfo)")
                }
                
                let vc = BaseTabBarController()
                window?.rootViewController = vc
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

