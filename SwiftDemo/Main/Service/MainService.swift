//
//  MainService.swift
//  SwiftDemo
//
//  Created by apple on 2021/2/5.
//

import UIKit

class MainService: NSObject {

    // 接口请求成功回调
    typealias SucessBlock = (_ json:Any) ->()
    // 接口请求返回错误回调
    typealias ErrorBlock = (_ message: String) ->()
    // 接口请求失败回调
    typealias FailuredBlock = () ->()
    
    func getGithubApiData(successBlock: @escaping SucessBlock,errorBlock: @escaping ErrorBlock) -> Void {
        let url = ""
        let dict = ["id":"2"]
        AppNetWork.shared.appHttpRequest(url: url, requestType: HTTPRequestType.GET, parameters: dict, successBlock: { (json) in
            // 缓存数据
            var saveArray = [NSDictionary]()
            let dict = ["id":"1","data":json,"title":"历史数据:\(String.getCurrentTime())"]
            let cacheData = AppStorageTool.getDataFromDocument(fileName: "historylistData")
            let cacheArray = try? JSONSerialization.jsonObject(with: cacheData as Data, options: .mutableContainers)
            if (cacheArray != nil) {
                for d in cacheArray as! NSArray {
                    saveArray.append(d as! NSDictionary);
                }
                saveArray.insert(dict as NSDictionary, at: 0)
            } else{
                saveArray.append(dict as NSDictionary)
            }
            let data : NSData! = try? JSONSerialization.data(withJSONObject: saveArray, options: []) as NSData?
            AppStorageTool.saveDataToDocument(fileName: "historylistData", data: data)
            successBlock (json)
        }, errorBlock: { (message) in
            errorBlock (message)
        }) {
            errorBlock ("服务器连接失败")
        }
    }
}
