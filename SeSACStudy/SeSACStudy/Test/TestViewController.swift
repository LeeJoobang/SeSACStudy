import UIKit

class TestViewController: BaseViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customGray3
        
        let alertView = UIAlertController(title: "위치확인", message: "이건가?", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        
        /*
        let test = UIAlertAction(title: "test", style: .default)
        let testView = UIView()
        testView.backgroundColor = .green
        test.setValue(testView, forKey: "testViewadd")
        alertView.addAction(test)
        
        return Thread 1: "[<UIAlertAction 0x600003d01200> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key testViewadd."
         */
        
        // 왜 여기서는 문제가 안생기지?
         let cancelAlert = UIAlertAction(title: "Cancel", style: .default, handler:nil)
         cancelAlert.setValue(UIColor.blue, forKey: "titleTextColor")
         alertView.addAction(cancelAlert)
        
        
        /* 이렇게 쓰면 오류가 생긴다고??
         let cancelAlert = UIAlertAction(title: "Cancel", style: .default, handler: nil)
         cancelAlert.setValue(UIColor.green, forKey: "testview")
         alertView.addAction(cancelAlert)
         */
        
        let contentView = UIViewController()
        contentView.view.backgroundColor = .red
        
        alertView.setValue(contentView, forKey: "contentViewController")

        
        self.present(alertView, animated: true)

    }
    
}
