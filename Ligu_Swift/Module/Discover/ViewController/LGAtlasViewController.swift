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
        tableView.LGHead = LGRefreshAutoHeader{[weak self] in self?.loadData();  self?.page = 0 }
        tableView.LGFoot = LGRefreshFooter{[weak self] in self?.loadData(); self?.page += 1 }
        tableView.LGempty = LGEmptyView{[weak self] in self?.loadData()}
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.random
        
        loadData()
        
    }
    
    override func configUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalTo(self.view.LGsnp.edges) }
    }
    
    func loadData(){
        ApiLoadingProvider.requestArray(LGApi.atlasList(pageNum: page), model:AtlasListModel.self) { (returnData) in
//            if self.page == 0 { return self.atlasList.removeAll()}
//            self.atlasList.append(contentsOf:returnData ?? [])
//
//            self.tableView.LGHead.endRefreshing()
//
//            if self.atlasList.count > 0{
//                self.tableView.LGFoot.isHidden = false
//                if self.atlasList.count < LGPageSize{
//                    self.tableView.LGFoot.endRefreshingWithNoMoreData()
//                }
//            }else{
//                self.tableView.LGFoot.isHidden = true
//            }
//            self.tableView.LGempty?.allowShow = true
            self.atlasList = returnData ?? []
            
            self.tableView.reloadData()
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
