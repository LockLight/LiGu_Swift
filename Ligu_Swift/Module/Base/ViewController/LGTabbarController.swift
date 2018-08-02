//
//  LGTabbarController.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/2.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit

class LGTabbarController: UITabBarController {
    override func viewDidLoad() {
        super .viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.hex(hexString: "#FFFFFF")
        
        //场馆
        
        //发现
        
        //赛事
        
        //社交圈
        
        //我的
    }
    
}

extension LGTabbarController{
    public class func initializeOnceMethod(){
        // 1.正常状态下的文字
        let normalAttr = [NSAttributedStringKey.foregroundColor: UIColor.hex(hexString:"#272324"),
                          NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10)]
        
        // 2.选中状态下的文字
        let selectAttr = [NSAttributedStringKey.foregroundColor: UIColor.hex(hexString:"#00ACCC"),
                          NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10)]
        
        UITabBarItem.appearance().setTitleTextAttributes(normalAttr, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectAttr, for: .selected)
    }
}

