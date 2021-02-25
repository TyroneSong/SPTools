//
//  String+Extension.swift
//  MVVMRx_SampleProject
//
//  Created by 宋璞 on 2019/8/2.
//  Copyright © 2019 宋璞. All rights reserved.
//

import UIKit

extension String {
    
    
    /// 从index开始截取， 到最后
    func startOf(_ index: Int) -> String {
        guard index < self.count else {
            return ""
        }
        
        return String(self.suffix(self.count - index))
    }
    
    /// 从头开始截取， index结束
    func endOf(_ index: Int) -> String {
        
        guard index > -1 else {
            return self
        }
        
        guard index < self.count else {
            return self
        }
        
        return String(self.prefix(index + 1))
    }
    
    /// 截取字符串
    func rangeOf(start: Int, end: Int) -> String {
        
        guard start < end else {
            return ""
        }
        
        var newStart = start
        var newEnd = end
        
        if start < 0 { newStart = 0 }
        if end > self.count { newEnd = self.count }
        
        let indexS = self.index(self.startIndex, offsetBy: newStart)
        let indexE = self.index(self.startIndex, offsetBy: newEnd)
        let str = self[indexS..<indexE]
        return String(str)
    }
    
}
