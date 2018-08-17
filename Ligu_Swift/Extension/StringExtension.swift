//
//  StringExtension.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/8/8.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import Foundation

extension String {
    var md5: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        if let data = data(using: String.Encoding.utf8) {
            _ = data.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(data.count), &digest)
            }
        }

        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
    
    func convertToClass<T>() -> T.Type? {
        return StringClassConverter<T>.convert(string: self)
    }
}

class StringClassConverter<T> {
    
    static func convert(string className: String) -> T.Type? {
        guard let nameSpace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String else {
            return nil
        }
        guard let aClass: T.Type = NSClassFromString("\(nameSpace).\(className)") as? T.Type else {
            return nil
        }
        return aClass
    }
}
