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
    
    public var currentPage:NSInteger = 0{
        didSet{
            if currentPage > 1 {return}
            
            lineView.snp.remakeConstraints{
                $0.bottom.equalToSuperview()
                $0.centerX.equalTo(btnList[currentPage])
                $0.width.equalTo((btnList[currentPage].titleLabel?.snp.width)!)
                $0.height.equalTo(4)
            }
            
            //是根据约束立即计算frame并且设置
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            
            //先让原来选中的button变为NO
            selectBtn.isSelected = false
            //按钮数组里的某个元素
            btnList[currentPage].isSelected = true;
            selectBtn = btnList[currentPage]
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){
        self.backgroundColor = UIColor.white
        
        //分类按钮
        btnList.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 0, leadSpacing: 58.0, tailSpacing: 58.0)
        btnList.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
        }
        
        //下划线
        addSubview(lineView)
        lineView.snp.makeConstraints{
            $0.bottom.equalTo(btnList[0])
            $0.centerX.equalTo(btnList[0])
            $0.width.equalTo((btnList[0].titleLabel?.snp.width)!)
            $0.height.equalTo(4)
        }
        
        //默认让第0个按钮被选中，并且把选中按钮记录成第0个按钮
        btnList[0].isSelected = false
        selectBtn = btnList[0]
    }
    
    
    @objc private func changeCategory(_ sender:UIButton){
        //先清除原来选中按钮的选中状态
        selectBtn.isSelected = false
        sender.isSelected = true
        selectBtn = sender
        
        //更新下划线
        lineView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalTo(btnList[sender.tag]);
            $0.width.equalTo((btnList[sender.tag].titleLabel?.snp.width)!);
            $0.height.equalTo(4);
        }
        
        //是根据约束立即计算frame并且设置
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
        
        //把当前被点击的按钮的索引，赋值给整个视图的tag
        self.tag = sender.tag;
        //发送一条事件
        self.sendActions(for: .valueChanged)
    }
}
