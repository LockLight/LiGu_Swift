//
//  LGNavigationController.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/2.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture

class LGNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
		fd_fullscreenPopGestureRecognizer.isEnabled = true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 { viewController.hidesBottomBarWhenPushed = true }
        super.pushViewController(viewController, animated: animated)
    }
	
	// MARK: - 全屏滑动返回(不想用第三方的话可以使用这个方法)
	private func fullscreenPop() {
		
		// 1.获取系统的Pop手势
		guard let systemGes = interactivePopGestureRecognizer else { return }
		
		// 2.获取手势添加到的View中
		guard let gesView = systemGes.view else { return }
		
		let targets = systemGes.value(forKey: "_targets") as? [NSObject]
		guard let targetObjc = targets?.first else { return }
		
		// 3.2.取出target
		guard let target = targetObjc.value(forKey: "target") else { return }
		
		// 3.3.取出Action
		let action = Selector(("handleNavigationTransition:"))
		
		// 4.创建自己的Pan手势
		let panGes = UIPanGestureRecognizer()
		gesView.addGestureRecognizer(panGes)
		panGes.addTarget(target, action: action)
	}
}

extension UINavigationController{
    override open var preferredStatusBarStyle:UIStatusBarStyle{
        guard let topVC = topViewController else {
            return .default
        }
        return topVC.preferredStatusBarStyle
    }
}

enum LGNavigationBarStyle {
    case white
    case black
    case clear
}

extension UINavigationController{
    func barStyle(_ style:LGNavigationBarStyle){
        //navibar,BarButtonItem文字属性
        let itemAttr = [NSAttributedStringKey.foregroundColor: UIColor.hex(hexString:"#00ACCC"),
                       NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        let barAttr =  [NSAttributedStringKey.foregroundColor: UIColor.hex(hexString:"#000000"),
                        NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
        
        UIBarButtonItem.appearance().setTitleTextAttributes(itemAttr, for: .normal)
        navigationBar.titleTextAttributes = barAttr
        
       
        switch style {
        case .white:
            navigationBar.barStyle = .default
            navigationBar.setBackgroundImage(UIColor.hex(hexString: "#FDFDFE").image(), for: .default)
            navigationBar.shadowImage = UIImage()
        case .black:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIColor.black.image(), for: .default)
            navigationBar.shadowImage = UIImage()
        case .clear:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = nil
        }
    }
}


