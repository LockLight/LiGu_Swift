//
//  LGVenueViewController.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/3.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit
import Moya

class LGVenueViewController: LGBaseViewController {
    
    private var hotComnandList = [HotCommandVennueModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        ApiLoadingProvider.requestArray(LGApi.HotCommandVenue(city: "深圳", lon: "22.284681", lat: "114.158177", orderBy: 1, pageNum: 1), model:HotCommandVennueModel.self) { [weak self] (returnData) in
//            LGLog("Hello")
//
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
