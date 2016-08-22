//
//  ViewController.swift
//  XHNetworkSwiftExample
//
//  Created by xiaohui on 16/8/21.
//  Copyright © 2016年 returnoc.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHNetworkSwift

import UIKit

let SERVE = "http://aotuyuan.qinto.com/wl/Api.php/"
//测试URL
let URL_TEST = SERVE + "Api/indexInformation"

//下载URL
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
        XHNetwork.shareNetwork.download1(URL_DOWN, downloadProgress: { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
            
             debugPrint("单次下载大小:\(bytesRead)___一共下载大小:\(totalBytesRead)___总大小:\(totalBytesExpectedToRead)")
            
            }, success: { (response) in
               
                debugPrint(response)
                
            }) { (error) in
                
                debugPrint(error)
        }
        
        //            let fileManager = NSFileManager.defaultManager()
        //            let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        //            let pathComponent = response.suggestedFilename
        //
        //            let pathURL = directoryURL.URLByAppendingPathComponent(pathComponent!)
        //
        //            print(pathURL)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

