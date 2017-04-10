//
//  NetworkTool.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/6.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

class NetworkTool {
    
    //单例
    static let shared = NetworkTool()
    private init(){}
    
    
    //GET
//    func loadDateInfo(URLString: String, parameters: AnyObject?, success: @escaping (_ responseObject: AnyObject?) -> Void, failure: @escaping (_ errer: Error) -> Void )-> Void {
//        
//        AFHTTPSessionManager().get(URLString, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
//            
//            success(responseObject as AnyObject)
//            
//        }) { (task: URLSessionDataTask?, error: Error) in
//            
//            failure(error)
//            
//        }
//    }
}

