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
        
        initTabbarAttr()
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.hex(hexString: "#FFFFFF")
        
        //场馆
        let venneVC = LGVenueViewController()
        addChildViewController(venneVC,
                               title: "场馆",
                               image: UIImage(named: "venue_tabBarItem_unselected"),
                               selectedImage: UIImage(named: "venue_tabBarItem_selected"))
        //发现
        let discoverVC = LGDiscoverViewController()
        addChildViewController(discoverVC,
                               title: "发现",
                               image: UIImage(named: "found_tabBarItem_unselected"),
                               selectedImage: UIImage(named: "found_tabBarItem_selected"))
        //赛事
        let matchVC = LGMatchViewController()
        addChildViewController(matchVC,
                               title: "赛事",
                               image: UIImage(named: "match_tabBarItem_unselected"),
                               selectedImage: UIImage(named: "match_tabBarItem_selected"))
        //社交圈
        let socialVC = LGSocialViewController()
        addChildViewController(socialVC,
                               title: "社交圈",
                               image: UIImage(named: "socialCircle_tabBarItem_unselected"),
                               selectedImage: UIImage(named: "socialCircle_tabBarItem_selected"))
        //我的
        let mineVC = LGMineViewController()
        addChildViewController(mineVC,
                               title: "我的",
                               image: UIImage(named: "my_tabBarItem_unselected"),
                               selectedImage: UIImage(named: "my_tabBarItem_selected"))
    }
    
    func addChildViewController(_ childController: UIViewController,title:String?,image:UIImage?,selectedImage:UIImage?) {
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: title,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
        addChildViewController(LGNavigationController(rootViewController: childController))
    }
    
    func initTabbarAttr(){
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


extension LGTabbarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .default }
        return select.preferredStatusBarStyle
    }
}

