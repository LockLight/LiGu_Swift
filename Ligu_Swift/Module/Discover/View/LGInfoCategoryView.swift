//
//  LGInfoCategoryView.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/17.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit

class LGInfoCategoryView: UIControl {
    private lazy var lineView:UIView = {
        let lw = UIView()
        lw.backgroundColor = UIColor.hex(hexString: "#00ACCC")
        return lw
    }()
    
    private lazy var selectBtn:UIButton = {
        let selectBtn = UIButton()
        return selectBtn
    }()
    
    private lazy var btnList:Array<UIButton> = {
        let categoryArr = ["全部资讯","图集"]
        var btnList = Array<UIButton>()
        for i in 0..<categoryArr.count{
            let btn = UIButton(text: categoryArr[i], fontSize: 16.0, normalColor: UIColor.hex(hexString: "#5C5C5C"), selectedColor: UIColor.hex(hexString: "#00ACCC"))
            btn.tag = i
            btn.addTarget(self, action: #selector(changeCategory(_:)), for: .touchUpInside)
            btnList.append(btn)
            self.addSubview(btn)
        }
        return btnList
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){
        self.backgroundColor = UIColor.white
        
        
    }
    
    @objc private func changeCategory(_ sender:UIButton){
        
    }
}
