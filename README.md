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
##  安装
### 手动添加:<br>
*   1.将 XHNetworkSwift 文件夹添加到工程目录中即可<br>

##  系统要求
*   该项目最低支持 iOS 8.0 和 Xcode 7.3

##  许可证
    XHNetworkSwift 使用 MIT 许可证，详情见 LICENSE 文件