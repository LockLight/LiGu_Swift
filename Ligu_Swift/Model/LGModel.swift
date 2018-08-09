//
//  LGModel.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/8.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import HandyJSON

struct HotCommandVennueModel:HandyJSON{
    var businessCirclesName:String?
    var description:String?
    var distance:String?
    var id:String?
    var logoUrl:String?
    var name:String?
    var score:String?
    var judgeCount:String?
}

extension Array:HandyJSON{}

struct ResponseData<T: HandyJSON>: HandyJSON {
    var tips:String?
    var status:Int?
    var code:String?
    var data:T?
}

