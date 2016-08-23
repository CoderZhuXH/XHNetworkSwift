//
//  ViewController.swift
//  XHNetworkSwiftExample
//
//  Created by xiaohui on 16/8/21.
//  Copyright © 2016年 returnoc.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHNetworkSwift

import UIKit

let SERVE = "http://aotuyuan.qinto.com/wl/Api.php/"
//GET,POST测试URL
let URL_TEST = SERVE + "Api/indexInformation"

//下载测试URL
let URL_DOWN = "http://120.25.226.186:32812/resources/videos/minion_01.mp4"


class ViewController: UIViewController {

    @IBOutlet weak var textLab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textLab.text = "返回数据请看控制台打印, \n 详情见Github: https://github.com/CoderZhuXH/XHNetworkSwift"
        
        
        //MARK: - GET请求
        XHNetwork.shareNetwork.GET(URL_TEST, parameters: nil, success: { (response) in
            
            debugPrint(response)
            
            }) { (error) in
            
                debugPrint(error)
        }
        
        //MARK: - POST请求
        let dic = ["name":"zhang","phone":"10010"]
        XHNetwork.shareNetwork.POST(URL_TEST, parameters: dic, success: { (response) in
            
            debugPrint(response)
            
            }) { (error) in
            
                debugPrint(error)
        }
        
        
        //MARK: - 下载
       let savePathURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        XHNetwork.shareNetwork.download(URL_DOWN, savePathURL: savePathURL
            , downloadProgress: { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
                
                /**
                 *  子线程回调下载进度
                 */
                debugPrint("单次下载大小:\(bytesRead)___一共下载大小:\(totalBytesRead)___总大小:\(totalBytesExpectedToRead)")
                
                /**
                 *  如需进行UI处理,请到主线程操作
                 */
                
                /*
                dispatch_async(dispatch_get_main_queue()) {
                
                                //处理UI
                }
                */
                
            }, success: { (response) in
               
                 debugPrint(response)
                
            }) { (error) in
                
                 debugPrint(error)
        }

/*
        //MARK : - 文件上传

        XHNetwork.shareNetwork.upload(传上传URLString, fileURL: 传文件完整路径URL, uploadProgress: { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
            
            /**
             *  子线程回调上传进度
             */
            debugPrint("单次上传大小:\(bytesWritten)___一共上传大小:\(totalBytesWritten)___总大小:\(totalBytesExpectedToWrite)")
            
            /**
             *  如需进行UI处理,请到主线程操作
             */
            
            /*
             dispatch_async(dispatch_get_main_queue()) {
             
             //处理UI
             }
             */
            
            }, success: { (response) in
                
                 debugPrint(response)
                
            }) { (error) in
                
                 debugPrint(error)
        }
         
         
*/
        // Do any additional setup after loading the view, typically from a nib.
    }

 

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

