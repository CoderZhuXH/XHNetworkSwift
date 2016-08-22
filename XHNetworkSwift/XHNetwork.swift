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
     *  上传进度闭包:(回调:1.单次上传大小 2.已经上传大小,3.文件总大小)
     */
    typealias UploadProgress = (bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) -> ()
    
    /**
     *  下载进度闭包:(回调:1.单次写入大小 2.已经写入大小,3.文件总大小)
     */
    typealias DownloadProgress = (bytesRead:Int64, totalBytesRead:Int64, totalBytesExpectedToRead:Int64) -> ()
    
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
        
        /*
         responseJSON:申明返回JSON类型数据
         你也可以根据实际需求,修改返回下列类型
         response
         responseData
         responseString
         responsePropertyList
         */
        Alamofire.request(.GET, urlString, parameters: parameters).responseJSON { response in
            
            switch response.result {
                
            case .Success(let value):
                
                /**
                 *  成功
                 */
                success(response:value)
                
            case .Failure(let error):
                
                /**
                 *  失败
                 */
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
                
                /**
                 *  成功
                 */
                success(response: value)
                
            case .Failure(let error):
                
                /**
                 *  失败
                 */
                failure(error: error)
                debugPrint(error)
                
            }
        }
    }
    
    /**
     文件上传
     
     - parameter urlString:      URL
     - parameter fileURL:        要上传文件路径URL
     - parameter uploadProgress: 上传进度回调(子线程)
     - parameter success:        成功回调
     - parameter failure:        失败回调
     */
    func upload(urlString: String ,fileURL:NSURL ,uploadProgress:UploadProgress, success: NetworkSuccess, failure: NetworkFailure){
        
        Alamofire.upload(.POST,urlString, file: fileURL)
            .progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                
                /*
                 bytesWritten 单次上传大小
                 totalBytesWritten  已经上传了大小
                 totalBytesExpectedToWrite 文件总大小
                 */
                
                /**
                 *  子线程回调上传进度
                 */
                uploadProgress(bytesWritten:bytesWritten,totalBytesWritten:totalBytesWritten,totalBytesExpectedToWrite:totalBytesExpectedToWrite)
                
//                dispatch_async(dispatch_get_main_queue()) {
//                    print("Total bytes written on main queue: \(totalBytesWritten)")
//                }
            }
            .validate()
            .responseJSON { response in
                
                switch response.result {
                    
                case .Success(let value):
                    
                    /**
                     *  成功
                     */
                    success(response: value)
                    
                case .Failure(let error):
                    
                    /**
                     *  失败
                     */
                    failure(error: error)
                    debugPrint(error)
                    
                }
        }
        
    }

    /**
     文件下载(自定义存储路径)
     
     - parameter urlString: 下载URL
     - parameter downloadProgress: 下载进度回调(子线程)
     - parameter fileSavePathURL: 文件存储路径URL
     - parameter success:   成功回调
     - parameter failure:   失败回调
     */
    func download0(urlString: String ,savePathURL:NSURL ,downloadProgress: DownloadProgress, success: NetworkSuccess, failure: NetworkFailure){
        
        Alamofire.download(.GET, urlString) { temporaryURL, response in
            
            return savePathURL
            
            }.progress { bytesRead, totalBytesRead, totalBytesExpectedToRead  in
                print(totalBytesRead)
                
                /*
                 bytesRead 单次下载大小
                 totalBytesRead  已经下载大小
                 totalBytesExpectedToRead 文件总大小
                 */
                
                /**
                 *  子线程回调下载进度
                 */
                downloadProgress(bytesRead:bytesRead,totalBytesRead:totalBytesRead,totalBytesExpectedToRead:totalBytesExpectedToRead)

            }
            .response { _, _, _, error in
                if let error = error {
                    
                    /**
                     *  失败
                     */
                    failure(error:error)
                    debugPrint("Failed with error: \(error)")
                    
                } else {
                    
                    /**
                     *  成功
                     */
                    success(response: savePathURL.absoluteString)
                    
                }
        }
    }
    
    /**
     文件下载(默认存储路径)
     
     - parameter urlString:        URL
     - parameter downloadProgress: 下载进度回调(子线程)
     - parameter success:          成功回调
     - parameter failure:          失败回调
     */
    func download1(urlString: String ,downloadProgress: DownloadProgress,success: NetworkSuccess, failure: NetworkFailure){
        
        let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        
        let savePathURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        
        Alamofire.download(.GET, urlString, destination: destination)
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                
                /*
                 bytesRead 单次下载大小
                 totalBytesRead  已经下载大小
                 totalBytesExpectedToRead 文件总大小
                 */
                
                /**
                 *  子线程回调下载进度
                 */
                downloadProgress(bytesRead:bytesRead,totalBytesRead:totalBytesRead,totalBytesExpectedToRead:totalBytesExpectedToRead)

            }
            .response { _, _, _, error in
                if let error = error {
                    
                    /**
                     *  失败
                     */
                    failure(error:error)
                    debugPrint("Failed with error: \(error)")
                    
                } else {
                    
                    /**
                     *  成功
                     */
                    success(response: savePathURL.absoluteString)
                    
                }
        }
    }


}
