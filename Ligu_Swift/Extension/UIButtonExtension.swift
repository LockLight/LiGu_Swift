//
//  UIButtonExtension.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/17.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit

extension UIButton{
    convenience init(text:String,fontSize:CGFloat = 15,normalColor:UIColor,selectedColor:UIColor){
        self.init()
        
        self.setTitle(text, for:.normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        self.setTitleColor(normalColor, for: .normal)
        self.setTitleColor(selectedColor, for: .selected)
        self.sizeToFit()
    }
}
