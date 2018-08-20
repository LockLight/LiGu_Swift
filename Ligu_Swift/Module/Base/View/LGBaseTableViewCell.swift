//
//  LGBaseTableViewCell.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/20.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit
import Reusable

class LGBaseTableViewCell: UITableViewCell,Reusable{

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI(){
        
    }
    
}
