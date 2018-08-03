//
//  LGNavigationController.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/2.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit

class LGNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let interactiveGes = interactivePopGestureRecognizer else { return }
        guard let targetView = interactiveGes.view else { return }
        guard let internalTargets = interactiveGes.value(forKey: "targets") as? [NSObject] else {return}
        guard let internalTarget = internalTargets.first?.value(forKey: "target") else { return }
        let action  = Selector(("handleNavigationTransition:"))
        
        let fullScreenGesture = UIPanGestureRecognizer(target: internalTarget, action: action)
        fullScreenGesture.delegate = self
        targetView.addGestureRecognizer(fullScreenGesture)
        interactiveGes.isEnabled = false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 { viewController.hidesBottomBarWhenPushed = true }
        super.pushViewController(viewController, animated: animated)
    }

}

extension UINavigationController:UIGestureRecognizerDelegate{
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let isLeftToRight = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight
        guard let ges = gestureRecognizer as? UIPanGestureRecognizer else {
            return true
        }
        if ges.translation(in: gestureRecognizer.view).x * (isLeftToRight ? 1 : -1) <= 0
            || value(forKey: "__isTransitioning") as! Bool
            || disablePopGesture{
            return false
        }
        return viewControllers.count != 1
    }
}

extension UINavigationController{
    override open var preferredStatusBarStyle:UIStatusBarStyle{
        guard let topVC = topViewController else {
            return .lightContent
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
    private struct AssociatedKeys{
        static var disablePopGesture:Void?
    }
    
    var disablePopGesture:Bool{
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.disablePopGesture) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.disablePopGesture, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func barStyle(_ style:LGNavigationBarStyle){
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
            navigationBar.shadowImage = UIImage()
        }
    }
}


