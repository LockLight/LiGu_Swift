//
//  LGAtlasViewController.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/17.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit
import MJRefresh

class LGAtlasViewController: LGBaseViewController {
    
    private var atlasList = [AtlasListModel]()
    private var page:Int = 0
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.hex(hexString: "#F1F1F4")
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 243
        tableView.register(cellType: LGAtlasListCell.self)
        tableView.LGHead = LGRefreshAutoHeader{[weak self] in self?.loadData(more: false)}
        tableView.LGFoot = LGRefreshFooter{[weak self] in self?.loadData(more: true)}
        tableView.LGempty = LGEmptyView{[weak self] in self?.loadData(more: false)}
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.random
        
        loadData(more: false)
        
    }
    
    override func configUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalTo(self.view.LGsnp.edges) }
    }
    
    func loadData(more:Bool){
        page = more ? (page + 1) : 0
        ApiLoadingProvider.requestArray(LGApi.atlasList(pageNum: page), model:AtlasListModel.self, success: {
            (returnData) in
            self.tableView.LGHead.endRefreshing()
            self.tableView.LGempty?.allowShow = true
            
            if (returnData.count) < LGPageSize{
                self.tableView.LGFoot.endRefreshingWithNoMoreData()
            }else{
                self.tableView.LGFoot.endRefreshing()
            }
            
            if more == false { self.atlasList.removeAll()}
            self.atlasList.append(contentsOf:returnData )
            self.tableView.reloadData()
        }) { (error) in
            LGLog("Error...\(error)")
        }
    }
}

extension LGAtlasViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return atlasList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: LGAtlasListCell.self)
        cell.model = atlasList[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.hex(hexString: "#F1F1F4")
        return view
    }
}
