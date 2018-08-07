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
    static let platfromID = "ve.ios"
    static let timestamp = Date().timeIntervalSince1970.description
    static let randomNum = String(arc4random()%1000)
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
        var params:[String:Any]!
        var sign = String()
        switch self {
        case .HotCommandVenue(let city,let lon,let lat,let orderBy,let pageNum):
            params["city"] = city
            params["lon"] = lon
            params["lat"] = lat
            params["descType"] = orderBy
            sign = signEncrypt("venue/search?pageNo=\(pageNum)&pageSize=\(LGPageSize)", params, LGApiConfig.randomNum, LGApiConfig.timestamp)
        }
        return [
            "X-Request-Token":"",
            "X-Request-DeviceName":UIDevice.current.modelName,
            "X-Request-Vendor":"Apple",
            "X-Request-OSVsersion":UIDevice.current.systemVersion,
            "X-Request-AppVersion":LGLocalVersion,
            "X-Request-AppType":"public",
            "X-Request-DeviceResolution":"\(screenWidth*screenHeight)",
            "X-Request-Time":LGApiConfig.timestamp,
            "X-Request-Id":LGApiConfig.platfromID,
            "X-Request-Nonce":LGApiConfig.randomNum,
            "X-Request-Sign":sign
        ]
    }
    
    //获得或者设置用于指定所执行的验证类型的值
    public var validationType:ValidationType{
        return .successCodes  //HTTP code 200-299
    }
    
    //
    private func signEncrypt(_ url:String,_ params:[String:Any],_ randomNum:String,_ timeStamp:String) -> String{
        var tempArr = Array<String>()
        tempArr.append(LGLocalVersion)
        tempArr.append(LGApiConfig.platfromID)
        tempArr.append(LGApiConfig.timestamp)
        tempArr.append(LGApiConfig.randomNum)
        tempArr.append(LGApiConfig.keys.lGNetworkKey())
        
        
        return ""
    }
    
    private func sortAllKeys(_ url:String,_ params:[String:Any]) -> Array<String>{
        var mergeParams = params
        
       //如果URL中存在?说明url上拼接了参数
        if url.contains("?") {
            var urlTemp = url.components(separatedBy: "?").last
            var urlParams = Dictionary<String, String>.urlConvertToDict(urlTemp!)
            
        }
        
        return []
    }

}


