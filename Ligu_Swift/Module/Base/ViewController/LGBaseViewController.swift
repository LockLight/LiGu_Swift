//
//  LGBaseViewController.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/2.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit

class LGBaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.background
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }else{
            automaticallyAdjustsScrollViewInsets = false
        }
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNaviBar()
    }
    
    func configUI(){}
    
    func configNaviBar(){
        guard let navi = navigationController else {return}
        if navi.visibleViewController == self{
            navi.barStyle(.white)
            navi.disablePopGesture = false
            navi.setNavigationBarHidden(false, animated: true)
            if navi.viewControllers.count > 1{
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .plain, target: self, action: #selector(pressBack))
            }
        }
    }
    
    @objc func pressBack(){
        navigationController?.popViewController(animated: true)
    }
}

extension LGBaseViewController{
    override var preferredStatusBarStyle:UIStatusBarStyle{
        return .default
    }
}
