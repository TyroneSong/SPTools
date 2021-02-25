//
//  SPCalendarTool.swift
//  SPCalendar
//
//  Created by 宋璞 on 2020/2/25.
//  Copyright © 2020 宋璞. All rights reserved.
//

import UIKit

class SPCalendarTool: NSObject {
    /**
     返回年
     - parameter date: 数据
     - returns: 年
     */
    public class func Year(_ date: Date)->Int{
        let components = Calendar.current.dateComponents([.year], from: date)
        return components.year!
    }
    
    /**
     返回月
     - parameter date: 数据
     - returns: 月
     */
    public class func Month(_ date:Date)->Int{
        let components = Calendar.current.dateComponents([.month], from: date)
        return components.month!
    }

    /**
     返回日
     - parameter date: 数据
     - returns: 日
     */
    public class func Day(_ date:Date)->Int{
        let components = Calendar.current.dateComponents([.day], from: date)
        return components.day!
    }



    /**
     返回这个月的天数
     - parameter date:数据
     - returns: 天
     */
    public class func DaysInMonth(_ date:Date)->Int{
        let days = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: date)
        return days!.count
    }
    
    
    /**
     这个月的第一天是星期几
     - parameter date: 数据
     - returns: 周几
     */
    public class func DayinWeek(_ date:Date)->Int{

        let interval = date.timeIntervalSince1970;
        var days = Int(interval / 86400);
        days =  days - Day(date) + 1
        return (days - 3) % 7;
    }


    /**
     获取上一个月
     - parameter date: 数据
     - returns: 上一月
     */
    public class func UpMonth(_ date:Date)->Date{
        var dateComponents = DateComponents()
        dateComponents.month  = -1
        let newDate = Calendar.current.date(byAdding: dateComponents, to: date, wrappingComponents: true)
        return newDate!
    }


    /**
     获取下一个月
     - parameter date: 数据
     - returns: 下一月
     */
    public class func NextMonth(_ date:Date)->Date{
        
        var dateComponents = DateComponents()
        dateComponents.month  = +1
        let newDate = Calendar.current.date(byAdding: dateComponents, to: date, wrappingComponents: true)
        return newDate!
    }

    /**
     获取上一个年
     - parameter date: 数据
     - returns: 上一年
     */
    public class func UpYear(_ date:Date)->Date{
        
        var dateComponents = DateComponents()
        dateComponents.year  = -1
        let newDate = Calendar.current.date(byAdding: dateComponents, to: date, wrappingComponents: true)
        return newDate!
    }
    /**
     获取下一个年
     - parameter date: 数据
     - returns: 下一年
     */
    public class func NextYear(_ date:Date)->Date{
        
        var dateComponents = DateComponents()
        dateComponents.year  = +1
        let newDate = Calendar.current.date(byAdding: dateComponents, to: date, wrappingComponents: true)
        return newDate!
    }
}
