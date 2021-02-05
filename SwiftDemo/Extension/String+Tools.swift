//
//  String+Tools.swift
//  SwiftDemo
//
//  Created by apple on 2021/2/5.
//

import Foundation

extension String {
    
    
    /// 字符串转数组
    /// - Parameter jsonString:
    /// - Returns:
    static func getArrayFromJSONString(jsonString:String) ->NSArray{
        let jsonData:Data = jsonString.data(using: .utf8)!
        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if array != nil {
            return array as! NSArray
        }
        return array as! NSArray
    }
    
    /// 数组转字符串
    /// - Parameter array:
    /// - Returns: 
    static func getJSONStringFromArray(array:NSArray) -> String {
        if (!JSONSerialization.isValidJSONObject(array)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: array, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    
    // 获取当前时间
    static func getCurrentTime() -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式
        let time = dateformatter.string(from: Date())
        return time
    }
}
