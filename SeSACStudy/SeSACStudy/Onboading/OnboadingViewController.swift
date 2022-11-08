import UIKit

import SnapKit

class OnboadingViewController: UIViewController{
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
        [pageViewController.view, pageViewControl, button].forEach {
            view.addSubview($0)
        }

        setConstraints()
        initPageViewController()
        
        pageViewControl.numberOfPages = pageViewControllerList.count
    }
    
    func setConstraints() {
        pageViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        pageViewControl.snp.makeConstraints { make in
            make.bottom.equalTo(button.snp.top).offset(-42)
            make.centerX.equalTo(view)
        }
                
        button.snp.makeConstraints { make in
            make.bottom.equalTo(-80)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
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
}
