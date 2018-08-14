//
//  LGDiscoverViewController.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/3.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit

class LGDiscoverViewController: LGBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ApiLoadingProvider.request(LGApi.discoverCarousel(type: 1), model: CarouseModel.self) { [weak self] (returnData) in
            LGLog("Hello")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
