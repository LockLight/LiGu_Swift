//
//  UIViewExtension.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/21.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit

extension UIView{
    public func setFilletBy(corners:UIRectCorner,cornerRadii:CGSize){
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let maskLayer  = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = bezierPath.cgPath
        self.layer.mask = maskLayer
    }
}
