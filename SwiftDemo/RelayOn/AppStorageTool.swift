//
//  AppStorageTool.swift
//  SwiftDemo
//
//  Created by apple on 2021/2/5.
//

import UIKit

class AppStorageTool: NSObject {

    /// 缓存数据到plist
    /// - Parameters:
    ///   - fileName: 文件名
    ///   - data: 数据
    static func saveDataToDocument(fileName: String, data: NSData){
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let newFileName = ("\(documentPath)/\(fileName)")
        data.write(toFile: newFileName, atomically: true)
    }
    
    /// 获取缓存到document数据
    /// - Parameter fileName: 文件名
    /// - Returns:
    static func getDataFromDocument(fileName: String) -> NSData{
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let newFileName = ("\(documentPath)/\(fileName)")
        guard let data = try? NSData(contentsOfFile: newFileName, options: NSData.ReadingOptions(rawValue: 0)) else { return NSData.init() }
        return data
    }
}
