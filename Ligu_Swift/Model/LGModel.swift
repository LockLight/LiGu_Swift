//
//  LGModel.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/8.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import HandyJSON

struct newsListModel:HandyJSON {
    var title:String?
    var isUseFul:Int?
    var articleTypeId:Int?
    var isShow:Int?
    var thumImg:String?
    var coverImg:String?
    var createTime:String?
    var usefulCount:Int?
    var browseCount:Int?
    var typeName:Int?
    var isTop1:NSInteger?
}

struct AtlasListModel:HandyJSON {
    var atlasID:String?
    var coverImg:String?
    var createTime:String?
    var name:String?
    var modifyTime:String?{
        get{
            return DateClass.timeStampToString(self.modifyTime!, "yyyy/MM/dd")
        }
    }
    var imageCount:String?
}

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

struct CarouseModel:HandyJSON{
    var imgUrl:String?
    var activeUrl:String?
    var id:String?
    var articleId:String?
    var isArticle:Int?
}

extension Array:HandyJSON{}

struct ResponseData<T: HandyJSON>: HandyJSON {
    var totalCount:Int = 0
    var tips:String?
    var status:Int?
    var code:Int?
    var data:T?
}

