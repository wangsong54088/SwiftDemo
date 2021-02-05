//
//  AppNetWork.swift
//  SwiftDemo
//
//  Created by apple on 2021/2/5.
//

import UIKit
import AFNetworking

// 请求方式
enum HTTPRequestType {
    case GET
    case POST
}

class AppNetWork: AFHTTPSessionManager {
    
    // 接口请求成功回调
    typealias SucessBlock = (_ json:Any) ->()
    // 接口请求返回错误回调
    typealias ErrorBlock = (_ message: String) ->()
    // 接口请求失败回调
    typealias FailuredBlock = () ->()
    var requestParameter : [String : NSObject] = [String : NSObject]()
    var headers : [String : String] = [String : String]()
    private static let ip = "https://api.github.com"
    
    // 单例写法
    static let shared: AppNetWork = {
        let shareInstence = AppNetWork()
        shareInstence.requestSerializer = AFJSONRequestSerializer()
        shareInstence.responseSerializer = AFHTTPResponseSerializer()
        shareInstence.requestSerializer.setValue("application/json,text/html", forHTTPHeaderField: "Accept")
        shareInstence.requestSerializer.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return shareInstence
    }()
    
    func appHttpRequest(url: String,requestType: HTTPRequestType,parameters: Any?,successBlock: @escaping SucessBlock,errorBlock: @escaping ErrorBlock,failuredBlock: @escaping FailuredBlock) -> Void {
        request(requestType: requestType, urlString: url, parameters: (parameters as! [String : AnyObject])) { (result, error) in
            if error == nil {
                if result == nil {
                    errorBlock ("数据获取失败")
                } else{
                    let dataStr = String(data: result as! Data, encoding: String.Encoding.utf8)
                    successBlock (dataStr as Any)
                }
            } else{
                failuredBlock()
            }
        }
    }
    
    // 逃逸闭包关键字(一直存在不销毁):@escaping
    private func request(requestType:HTTPRequestType,urlString:String,parameters:[String:AnyObject]?,complated:@escaping(Any?, Error?)->()){
        // 构造url
        let url = "\(AppNetWork.ip)\(urlString)"
        // 构造公共参数(这儿构造公共请求参数)
        print("接口：\(url)请求参数：\(String(describing: parameters))")
        // 闭包
        let success = {
            (tasks:URLSessionDataTask,json:Any) ->() in complated(json, nil)
            // 打印服务端获取的数据
            let dataStr = String(data: json as! Data, encoding: String.Encoding.utf8)
            let dict = self.jsonStringToDic(dataStr!)
            print("接口：\(url)响应参数：\(dict as Any)")
        }
        let failure = {
            (tasks:URLSessionDataTask?,error:Error) ->() in complated(nil, error)
            // 打印错误
            print("接口：\(url)错误：\(error as Any)")
        }
        // 请求
        if requestType == .GET {
            get(url, parameters: requestParameter,headers: headers, progress: nil, success: success, failure: failure)
        }else{
            self.post(url, parameters: requestParameter,headers: headers, progress: nil, success: success, failure: failure)
        }
    }
}
