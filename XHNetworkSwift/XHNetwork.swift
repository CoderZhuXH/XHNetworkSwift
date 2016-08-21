//
//  XHNetwork.swift
//  XHNetworkSwiftExample
//
//  Created by xiaohui on 16/8/21.
//  Copyright © 2016年 returnoc.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHNetworkSwift

import UIKit
import Alamofire

class XHNetwork: NSObject {
    
    /**
     *  网络请求成功闭包:
     */
    typealias NetworkSuccess = (response:AnyObject) -> ()
    
    /**
     *  网络请求失败闭包:
     */
    typealias NetworkFailure = (error:NSError) -> ()
    
    /**
     *  网络请求单例
     */
    static let shareNetwork = XHNetwork()
    
}
//MARK: - 网络请求
extension XHNetwork
{
    
    /**
     GET 请求
     
     - parameter urlString:  请求URL
     - parameter parameters: 请求参数
     - parameter success:    成功回调
     - parameter failure:    失败回调
     */
    func GET(urlString: String ,parameters: [String : AnyObject]? ,success: NetworkSuccess, failure: NetworkFailure){
        
        Alamofire.request(.GET, urlString, parameters: parameters).responseJSON { response in
            
            switch response.result {
                
            case .Success(let value):
                
                success(response:value)
                
            case .Failure(let error):
                
                failure(error:error)
                debugPrint(error)
                
            }
        }
    }
    
    /**
     POST请求
     
     - parameter urlString:  请求URL
     - parameter parameters: 请求参数
     - parameter success:    成功回调
     - parameter failure:    失败回调
     */
    func POST(urlString: String ,parameters: [String : AnyObject]? ,success: NetworkSuccess, failure: NetworkFailure) {
        
        Alamofire.request(.POST, urlString, parameters: parameters).responseJSON { response in
            
            switch response.result {
                
            case .Success(let value):
                
                success(response: value)
                
            case .Failure(let error):
                
                failure(error: error)
                debugPrint(error)
                
            }
        }
    }

}
