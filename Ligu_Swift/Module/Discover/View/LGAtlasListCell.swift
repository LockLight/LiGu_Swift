//
//  LGAtlasListCell.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/21.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit

class LGAtlasListCell: LGBaseNibTableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lastTimeLabel: UILabel!
    @IBOutlet weak var imgCountBgView: UIView!
    @IBOutlet weak var imgCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        contentView.backgroundColor = UIColor.hex(hexString: "#F1F1F4")
        bgView.backgroundColor = UIColor.random
        bgView.layer.cornerRadius = 8
        bgView.layer.masksToBounds = true
        imgCountBgView.setFilletBy(corners:[.topLeft,.bottomLeft], cornerRadii: CGSize(width:3,height:3))
    }

}
