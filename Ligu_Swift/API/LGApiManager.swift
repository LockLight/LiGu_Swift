//
//  LGApiManager.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/17.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import MBProgressHUD


/// EZSE: 超时时长
private var requestTimeOut:Double = 20

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

let LoggerPlugin = NetworkLoggerPlugin(verbose: true, cURL: true,responseDataFormatter: { (data: Data) -> Data in
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)// Data 转 JSON
        // JSON 转 Data，格式化输出。
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
})

let myEndpointClosure = { (target: LGApi) -> Endpoint in
    //这里把endpoint重新构造一遍主要为了解决网络请求地址里面含有? 时无法解析的bug  https://github.com/Moya/Moya/issues/1198
    LGLog("baseURL:\(target.baseURL)\n path:\(target.path)")
    let url = target.baseURL.absoluteString + target.path
    LGLog("url:\(url)")
    
    var endpoint = Endpoint(url: url,
                            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
    return endpoint
}

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<LGApi>.RequestResultClosure) -> Void in
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = requestTimeOut
        if let requestData = urlRequest.httpBody{
            LGLog("\(urlRequest.url!)"+"\n"+"\(urlRequest.httpMethod ?? "")"+"发送参数"+"\(String(data: urlRequest.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        }else{
            LGLog("\(urlRequest.url!)"+"\(String(describing: urlRequest.httpMethod))")
        }
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

let ApiProvider = MoyaProvider<LGApi>(requestClosure:timeoutClosure,plugins:[LoggerPlugin])
let ApiLoadingProvider = MoyaProvider<LGApi>(requestClosure: timeoutClosure, plugins: [LoadingPlugin,LoggerPlugin])

/// EZSE: 模型解析
extension Response{
    func mapModel<T:HandyJSON>(_ type:T.Type) throws -> T{
        let jsonString = String(data:data,encoding:.utf8)
        
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
    
    func mapModelArray<T:HandyJSON>(_type:T.Type) throws -> [T]{
        let jsonDict = Dictionary<String,Any>.constructFromJSON(json: String(data:data,encoding:.utf8)!)!
        let jsonArrayString = jsonDict["data"] as! String
        guard let model = [T].deserialize(from: jsonArrayString) else{
            throw MoyaError.jsonMapping(self)
        }
        return model as! [T]
    }
}

/// EZSE: 请求方法封装
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
    
    @discardableResult
    open func requestArray<T:HandyJSON>(_ target:Target,
                                        model:T.Type,
                                        completion: ((_ returnData: [T]?) -> Void)?) -> Cancellable? {
        
        return request(target, completion: { (result) in
            
            guard let completion = completion else {return}
            guard let returnData = try? result.value?.mapModel(ResponseData<[T]>.self) else {
                completion(nil)
                return
            }
            completion(returnData?.data)
        })
    }
}
