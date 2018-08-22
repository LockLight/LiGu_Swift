//
//  LGEmptyDataSet.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/22.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import Foundation
import EmptyDataSet_Swift

extension UIScrollView {
    
    private struct AssociatedKeys {
        static var LGemptyKey: Void?
    }
    
    var LGempty: LGEmptyView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.LGemptyKey) as? LGEmptyView
        }
        set {
            self.emptyDataSetDelegate = newValue
            self.emptyDataSetSource = newValue
            objc_setAssociatedObject(self, &AssociatedKeys.LGemptyKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

class LGEmptyView: EmptyDataSetSource, EmptyDataSetDelegate {
    
    var image: UIImage?
    
    var allowShow: Bool = false
    var verticalOffset: CGFloat = 0
    
    
    private var tapClosure: (() -> Void)?
    
    init(image: UIImage? = UIImage(named: "nodata"), verticalOffset: CGFloat = 0, tapClosure: (() -> Void)?) {
        self.image = image
        self.verticalOffset = verticalOffset
        self.tapClosure = tapClosure
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return verticalOffset
    }
    
    internal func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return image
    }
    
    internal func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return allowShow
    }
    
    internal func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        guard let tapClosure = tapClosure else { return }
        tapClosure()
    }
}
