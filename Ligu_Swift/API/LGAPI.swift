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

let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else { return }
    switch type {
    case .began:
        MBProgressHUD.hide(for: vc.view, animated: false)
        MBProgressHUD.showAdded(to: vc.view, animated: true)
    case .ended:
        MBProgressHUD.hide(for: vc.view, animated: true)
    }
}

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<LGApi>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

let ApiProvider = MoyaProvider<LGApi>(requestClosure:timeoutClosure)
let ApiLoadingProvider = MoyaProvider<LGApi>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

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
            sign = signEncrypt("venue/search?pageNo=\(pageNum)&pageSize=\(LGPageSize)", params)
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
    
    //加密
    private func signEncrypt(_ url:String,_ params:[String:Any]) -> String{
        var tempArr = Array<String>()
        tempArr.append(LGLocalVersion)
        tempArr.append(LGApiConfig.platfromID)
        tempArr.append(LGApiConfig.timestamp)
        tempArr.append(LGApiConfig.randomNum)
        tempArr.append(LGApiConfig.keys.lGNetworkKey())
        tempArr += sortAllKeys(url, params)
        
        let result = tempArr.joined(separator: "&")
        
        return result.md5
    }
    
    //升序key
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
                tempStr = mergeParams[key] as! String
            }
            
            keyArray.append(String(format: "%@=%@", key,tempStr))
        }
        
        return keyArray
    }
}

extension Response{
    func mapModel<T:HandyJSON>(_ type:T.Type) throws -> T{
        let jsonString = String(data:data,encoding:.utf8)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

extension MoyaProvider{
    @discardableResult
    open func request<T:HandyJSON>(_ target:Target,
                                   model:T.Type,
                                   completion: ((_ returnData: T?) -> Void)?) -> Cancellable? {

        return request(target, completion: { (result) in
            guard let completion = completion else {return}
            guard let returnData = try? result.value?.mapModel(ResponseData<T>.self) else {
                completion(nil)
                return
            }
            completion(returnData?.data)
        })
    }
}




