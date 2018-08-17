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
import MBProgressHUD


/// EZSE: 当前请求参数
typealias Parameters = [String:Any]

fileprivate struct LGApiConfig{
    fileprivate static let keys = Ligu_swiftKeys()
    static let apiKey = keys.lGNetworkKey()
    static let platfromID = "ve.ios"
    static let randomNum = String(arc4random()%1000)
    static let timestamp = String(Date().timeIntervalSince1970)
}

enum LGApi {
    case HotCommandVenue(city:String,lon:String,lat:String,orderBy:Int,pageNum:Int) //热门推荐场馆
    case discoverCarousel(type:Int)  //发现轮播资讯
}

extension LGApi:TargetType{
    var baseURL: URL{
        return URL(string: LGBaseUrl)!
    }

    var path: String{
        switch self {
        case .HotCommandVenue(_,_,_,_,let pageNum):
            return "venue/search?pageNo=\(pageNum)&pageSize=\(LGPageSize)"
        case .discoverCarousel:
            return "banner/list"
        }
    }

    var method: Moya.Method{
        switch self {
        case .HotCommandVenue: return .post
        case .discoverCarousel: return .get
        }
    }

    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    
    var parameters:Parameters{
        switch self {
        case .HotCommandVenue(let city, let lon,let lat ,let orderBy,_):
            return ["city":     city,
                    "lon" :     lon,
                    "lat" :     lat,
                    "descType": orderBy
                   ]
        case .discoverCarousel(let type):
            return ["type":type]
        }
    }

    var task: Task{
        switch self {
        case .HotCommandVenue,.discoverCarousel:
            return .requestParameters(parameters:parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]?{
        var sign = String()
        switch self {
        case .HotCommandVenue(_,_,_,_,let pageNum):
            sign = signEncrypt("venue/search?pageNo=\(pageNum)&pageSize=\(LGPageSize)", parameters)
        case .discoverCarousel:
            sign = signEncrypt("banner/list", parameters)
        }
        return [
            "X-Request-Token":"",
            "X-Request-DeviceName":UIDevice.current.modelName,
            "X-Request-Vendor":"Apple",
            "X-Request-OSVsersion":UIDevice.current.systemVersion,
            "X-Request-AppVersion":LGLocalVersion,
            "X-Request-AppType":"public",
            "X-Request-DeviceResolution":"\(screenWidth)*\(screenHeight))",
//            "X-Request-Time":LGApiConfig.timestamp,
            "X-Request-Id":LGApiConfig.platfromID,
            "X-Request-Nonce":LGApiConfig.randomNum,
            "X-Request-Sign":sign
        ]
    }
    
    /// EZSE: 获得或者设置用于指定所执行的验证类型的值
    public var validationType:ValidationType{
        return .successCodes  //HTTP code 200-299
    }
    
    /// EZSE: 加密 url:当前url的path  params:当前请求参数
    private func signEncrypt(_ url:String,_ params:[String:Any]) -> String{
        var tempArr = Array<String>()
        tempArr.append(LGLocalVersion)
        tempArr.append(LGApiConfig.platfromID)
//        tempArr.append(LGApiConfig.timestamp)
        tempArr.append(LGApiConfig.randomNum)
        tempArr.append(LGApiConfig.keys.lGNetworkKey())
        tempArr += sortAllKeys(url, params)
        
        let result = tempArr.joined(separator: "&")
        LGLog("--->\(result)")
        return result.md5
    }
    
    /// EZSE: 升序key排列
    private func sortAllKeys(_ url:String,_ params:[String:Any]) -> Array<String>{
        var mergeParams = params
        
       //如果URL中存在?说明url上拼接了参数
        if url.contains("?") {
            let urlTemp = url.components(separatedBy: "?").last
            let urlParams = Dictionary<String, Any>.urlConvertToDict(urlTemp!)
            mergeParams += urlParams
        }
        
        let keys = Array(mergeParams.keys)
        
        //如果字典为空就直接返回string类型空数组
        if keys.isEmpty { return [""] }
        
        var keyArray = Array<String>()
        let sortedArray = keys.sorted()
        for key in sortedArray {
            var tempStr = String()
            
            let val = mergeParams[key] as AnyObject
            if val is Array<Any> || val is Dictionary<String, Any>{
                let jsonData = try? JSONSerialization.data(withJSONObject: val, options: JSONSerialization.WritingOptions(rawValue: 0))
                tempStr = String(data: jsonData!, encoding: .utf8)!
                if tempStr.contains("\\"){
                    tempStr = tempStr.replacingOccurrences(of: "\\", with: "")
                }
            }else{
                tempStr = String(format: "%@", val as! CVarArg)
            }
            
            keyArray.append(String(format: "%@=%@", key,tempStr))
        }
        
        return keyArray
    }
}








