//
//  DLog.swift
//  MVVMRx_SampleProject
//
//  Created by 宋璞 on 2019/8/2.
//  Copyright © 2019 宋璞. All rights reserved.
//

import Foundation

//MARK: - DeLog ⚡️
func DLog<T>(_ message:T,
             file:String = #file,
             funcName:String = #function,
             lineNum:Int = #line
    ) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent;
    
    let cutLine = "============"
    
    let printString = "[文件名:\(fileName)]:[行数:\(lineNum)]:[方法:\(funcName)]-打印内容:"
    
    print("\(cutLine)\n\(printString)\n\(message)\n\(cutLine)");
    #endif
}
