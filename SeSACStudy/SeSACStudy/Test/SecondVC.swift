////
////  SecondeViewController.swift
////  SeSACStudy
////
////  Created by Jooyoung Lee on 2022/11/08.
////
//
//import UIKit
//
//class SecondVC: UIViewController {
//    
//    // MARK: - Property
//    weak var label: UILabel?
//    
//    // MARK: - View Life Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .orange
//        self.view = view
//        
//        let label = UILabel()
//        self.label = label
//        label.text = "두번째 뷰"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        self.view.addSubview(label)
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//        ])
//    }
//
//}
