//
//  LGRefresh.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/22.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit
import MJRefresh

extension UIScrollView {
    var LGHead: MJRefreshHeader {
        get { return mj_header }
        set { mj_header = newValue }
    }
    
    var LGFoot: MJRefreshFooter {
        get { return mj_footer }
        set { mj_footer = newValue }
    }
}

class LGRefreshAutoHeader: MJRefreshHeader {}

class LGRefreshFooter: MJRefreshBackNormalFooter {}

class LGRefreshAutoFooter: MJRefreshAutoFooter {}
