//
//  LGDiscoverViewController.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/3.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit
import LLCycleScrollView

class LGDiscoverViewController: LGBaseViewController {
    
    private var bannerList = [CarouseModel]()
    
    private lazy var bannerView:LLCycleScrollView = {
        let bw = LLCycleScrollView()
        bw.backgroundColor = UIColor.background
        bw.placeHolderImage = #imageLiteral(resourceName: "carouselFigure_placeholder")
        bw.coverImage = #imageLiteral(resourceName: "carouselFigure_placeholder")
        bw.imageViewContentMode = UIViewContentMode.scaleToFill
        bw.autoScrollTimeInterval = 3.0
        bw.lldidSelectItemAtIndex = didSelectBanner(Index:)
        return bw
    }()
    
    override func configUI() {
        view.addSubview(bannerView)
        bannerView.snp.makeConstraints {
            $0.top.right.left.equalToSuperview()
            $0.height.equalTo(140 * LGScale)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiLoadingProvider.requestArray(LGApi.discoverCarousel(type: 1), model: CarouseModel.self){
            [weak self] (returnData) in
            self?.bannerList = returnData ?? []
            var array = Array<String>()
            for model in (self?.bannerList)!{
                array.append(model.imgUrl ?? "")
            }
            self?.bannerView.imagePaths = array
        }
    }
    

    //MARK: 点击bannner
    private func didSelectBanner(Index:NSInteger){
        LGLog("点击了\(Index)")
    }
}
