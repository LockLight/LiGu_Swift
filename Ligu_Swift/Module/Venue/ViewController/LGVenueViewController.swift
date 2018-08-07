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
    
    let provider = MoyaProvider<LGApi>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        provider.request(.HotCommandVenue(city: "深圳", lon: "23.33", lat: "57.77", orderBy: 1, pageNum: 1)) {
            [weak self] result in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
