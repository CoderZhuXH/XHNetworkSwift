# XHNetworkSwift
### swift,基于Alamofire数据请求封装

###技术交流群(群号:537476189)

##API
```swift

    /**
     GET 请求
     
     - parameter urlString:  请求URL
     - parameter parameters: 请求参数
     - parameter success:    成功回调
     - parameter failure:    失败回调
     */
    func GET(urlString: String ,parameters: [String : AnyObject]? ,success: NetworkSuccess, failure: NetworkFailure)


    /**
     POST请求
     
     - parameter urlString:  请求URL
     - parameter parameters: 请求参数
     - parameter success:    成功回调
     - parameter failure:    失败回调
     */
    func POST(urlString: String ,parameters: [String : AnyObject]? ,success: NetworkSuccess, failure: NetworkFailure) 


    /**
     文件上传
     
     - parameter urlString:      URL
     - parameter fileURL:        要上传文件路径URL(包含文件名)
     - parameter uploadProgress: 上传进度回调(子线程)
     - parameter success:        成功回调
     - parameter failure:        失败回调
     */
    func upload(urlString: String ,fileURL:NSURL ,uploadProgress:UploadProgress, success: XHNetworkSuccess, failure: XHNetworkFailure)


     /**
     文件下载
     
     - parameter urlString: 下载URL
     - parameter downloadProgress: 下载进度回调(子线程)
     - parameter fileSavePathURL: 文件存储路径URL(不含文件名)
     - parameter success:   成功回调
     - parameter failure:   失败回调
     */
    func download(urlString: String ,savePathURL:NSURL ,downloadProgress: DownloadProgress, success: XHNetworkSuccess, failure: XHNetworkFailure)


```
## 使用方法:
### 1.GET请求
```swift

        //MARK: - GET请求
        XHNetwork.shareNetwork.GET(URL_TEST, parameters: nil, success: { (response) in
            
            debugPrint(response)
            
            }) { (error) in
            
                debugPrint(error)
        }

```
### 2.POST请求
```swift

        //MARK: - POST请求
        let dic = ["name":"zhang","phone":"10010"]
        XHNetwork.shareNetwork.POST(URL_TEST, parameters: dic, success: { (response) in
            
            debugPrint(response)
            
            }) { (error) in
            
                debugPrint(error)
        }
        
```

### 3.文件下载
```swift

        //MARK: - 文件下载
       //文件保存路径
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
                dispatch_async(dispatch_get_main_queue()) {
                
                     //处理UI
                }

            }, success: { (response) in
                
                /*
                成功(回调文件存储路劲)
                */

                 debugPrint(response)
                
            }) { (error) in
                
                 /*
                 失败
                 */

                 debugPrint(error)
        }

     
```

### 4.文件上传
```swift

        //MARK : - 文件上传
        XHNetwork.shareNetwork.upload(上传URLString , fileURL: 文件完整路径URL, uploadProgress: { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite)  in
            
            /**
             *  子线程回调上传进度
             */
            debugPrint("单次上传大小:\(bytesWritten)___一共上传大小:\(totalBytesWritten)___总大小:\(totalBytesExpectedToWrite)")
            
            /**
             *  如需进行UI处理,请到主线程操作
             */
             dispatch_async(dispatch_get_main_queue()) {
             
                 //处理UI
             }

            }, success: { (response) in
                
                /*
                成功
                */
                 debugPrint(response)
                
            }) { (error) in
                
                /*
                失败
                */
                
                debugPrint(error)
        }
        
```

##  安装
### 手动添加:<br>
*   1.将 XHNetworkSwift 文件夹添加到工程目录中即可<br>

##  系统要求
*   该项目最低支持 iOS 8.0 和 Xcode 7.3

##  许可证
    XHNetworkSwift 使用 MIT 许可证，详情见 LICENSE 文件
##  传送门:
[Swift网络编程(一)数据请求](http://www.jianshu.com/p/f8643477e690)
[Swift网络编程(二)文件上传/下载](http://www.jianshu.com/p/13e2dbc07481)