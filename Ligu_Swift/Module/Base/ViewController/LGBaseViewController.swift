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
        
        view.backgroundColor = UIColor.random
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }else{
            automaticallyAdjustsScrollViewInsets = false
        }
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func configUI(){}
    
    
}
