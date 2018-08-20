//
//  LGInfoListViewController.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/17.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit

class LGInfoListViewController: LGBaseViewController {
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.hex(hexString: "#F1F1F4")
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 104
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.random
    }

    override func configUI() {
        
    }
}

extension LGInfoListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.hex(hexString: "#F1F1F4")
        return view
    }
}
