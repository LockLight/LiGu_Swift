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
    
    private lazy var cateGoryView:LGInfoCategoryView = {
        let cgView = LGInfoCategoryView()
        cgView.addTarget(self, action: #selector(changePage(_:)), for: .valueChanged)
        return cgView
    }()
    
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        //添加根控制器
        var classStr = ["LGInfoListViewController","LGAtlasViewController"]
        var viewList  = Array<UIView>();
        for i in 0..<classStr.count{
            let vc = getViewController(fromString: classStr[i])!
            self.addChildViewController(vc)
            scrollView.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
            viewList.append(vc.view)
        }
        
        viewList.snp.distributeViewsAlong(axisType: .horizontal, fixedItemLength: 0, leadSpacing: 0, tailSpacing: 0)
        viewList.snp.makeConstraints{
            $0.top.bottom.size.equalToSuperview()
        }
        
        return scrollView
    }()
    
    override func configUI() {
        view.addSubview(bannerView)
        bannerView.snp.makeConstraints {
            $0.top.right.left.equalToSuperview()
            $0.height.equalTo(140 * LGScale)
        }
        
        view.addSubview(cateGoryView)
        cateGoryView.snp.makeConstraints{
            $0.top.equalTo(bannerView.snp.bottom)
            $0.right.left.equalToSuperview()
            $0.height.equalTo(44 * LGScale)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.top.equalTo(cateGoryView.snp.bottom)
            $0.right.left.bottom.equalToSuperview()
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
    
    //MARK: LGCInfomationCategoryView Event
    @objc private func changePage(_ sender:LGInfoCategoryView){
        LGLog(sender.tag)
        scrollView.scrollRectToVisible(CGRect(x:CGFloat(Int(screenWidth) * sender.tag),
                                              y:0,
                                              width:screenWidth,
                                              height:scrollView.bounds.size.height), animated: true)
    }
    
    //MARK: 根据string创建控制器
    func getViewController(fromString: String) -> UIViewController? {
        guard let viewController: UIViewController.Type = fromString.convertToClass() else {
            return nil
        }
        return viewController.init()
    }
}

extension LGDiscoverViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isTracking || scrollView.isDragging || scrollView.isDecelerating{
            let currentPage = NSInteger(scrollView.contentOffset.x / screenWidth)
            cateGoryView.currentPage = currentPage
        }
    }
}
