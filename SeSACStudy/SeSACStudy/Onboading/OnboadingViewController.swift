import UIKit

import SnapKit

class OnboadingViewController: BaseViewController{
    var pageViewControllerList: [UIViewController] = []
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    let pageViewControl: UIPageControl = {
        let control = UIPageControl()
        control.pageIndicatorTintColor = .lightGray
        control.currentPageIndicatorTintColor = .black
        return control
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "button"), for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(pressButton(button: )), for: .touchUpInside)
        [pageViewController.view, pageViewControl, button].forEach {
            view.addSubview($0)
        }
        setLayout()
        initPageViewController()
        pageViewControl.numberOfPages = pageViewControllerList.count
    }
    
    @objc func pressButton(button: UIButton){
        print("button clicked")

        UserDefaults.standard.set(true, forKey: "First")
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let vc = LoginViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    func setLayout() {
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).multipliedBy(0.1)
            make.leading.trailing.bottom.equalTo(view)
        }
        
        pageViewControl.snp.makeConstraints { make in
            make.bottom.equalTo(button.snp.top).offset(-42)
            make.centerX.equalTo(view)
        }
        
        button.snp.makeConstraints { make in
            make.bottom.equalTo(-80)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
    func initPageViewController(){
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        let firstVC = FirstViewController()
        let secondVC = SecondViewController()
        let thirdVC = ThirdViewController()
        
        pageViewControllerList = [firstVC, secondVC, thirdVC]
        guard let firstView = pageViewControllerList.first else { return }
        pageViewController.setViewControllers([firstView], direction: .forward, animated: true)
    }
}

extension OnboadingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        print(viewControllerIndex)
        let previousIndex = viewControllerIndex - 1
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        print(viewControllerIndex)
        let nextIndex = viewControllerIndex + 1
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let firstView = pageViewController.viewControllers?.first, let index = pageViewControllerList.firstIndex(of: firstView) else { return }
        pageViewControl.currentPage = index
    }
}
