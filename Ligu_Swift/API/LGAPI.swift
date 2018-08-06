//
//  LGAPI.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/6.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import Moya
import HandyJSON
import Keys


enum LGApi {
    case HotCommandVenue(city:String,lon:String,lat:String,orderBy:Int,pageNum:Int) //热门推荐场馆
}

fileprivate struct LGApiConfig{
    fileprivate static let keys = Ligu_swiftKeys()
    static let apiKey = keys.lGNetworkKey()
    static let timestamp = Date().timeIntervalSince1970.description
}

extension LGApi:TargetType{
    var baseURL: URL{
        return URL(string: LGBaseUrl)!
    }

    var path: String{
        switch self {
        case .HotCommandVenue(_,_,_,_,let pageNum):
            return "venue/search?pageNo=\(pageNum)&pageSize=\(LGPageSize)"
        }
    }

    var method: Moya.Method{
        switch self {
        case .HotCommandVenue: return .get
        }
    }

    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }

    var task: Task{
        var parameters:[String:Any]!
        switch self {
        case .HotCommandVenue(let city,let lon,let lat,let orderBy, _):
            parameters["city"] = city
            parameters["lon"] = lon
            parameters["lat"] = lat
            parameters["descType"] = orderBy
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    var headers: [String : String]?{
        return [
            "X-Request-Token":"",
            "X-Request-DeviceName":UIDevice.current.modelName,
            "X-Request-Vendor":"Apple",
            "X-Request-OSVsersion":UIDevice.current.systemVersion,
            "X-Request-AppVersion":LGLocalVersion,
            "X-Request-AppType":"public",
            "X-Request-DeviceResolution":"\(screenWidth*screenHeight)",
            "X-Request-Time":Date().timeIntervalSince1970.description,
            "X-Request-Id":"ve.ios",
            "X-Request-Nonce":String(arc4random()%1000),
//            "X-Request-Sign"
        ]
    }
    
    //获得或者设置用于指定所执行的验证类型的值
    public var validationType:ValidationType{
        return .successCodes  //HTTP code 200-299
    }
}


