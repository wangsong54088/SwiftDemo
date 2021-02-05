//
//  AppNetWork+Tools.swift
//  SwiftDemo
//
//  Created by apple on 2021/2/5.
//

import Foundation
import UIKit

extension AppNetWork {
    
    // MARK: - 字符串转字典
    func jsonStringToDic(_ str: String) -> [String : Any]?{
        let data = str.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
            return dict
        }
        return nil
    }
}
