//
//  SPCalendarView.swift
//  SPCalendar
//
//  Created by 宋璞 on 2020/2/25.
//  Copyright © 2020 宋璞. All rights reserved.
//

import UIKit

class SPCalendarView: UIView {

    //签到的数据
    var SigninList = [Int](){
        didSet{
            let firstDay = SPCalendarTool.DayinWeek(Date())
            for i in 0..<contentWrapperView.subviews.count{
                for j in 0..<SigninList.count{
                    if i == (SigninList[j] + firstDay - 1){
                        let btn =  contentWrapperView.subviews[i] as! UIButton
                        logDate(btn: btn)
                    }
                }
            }
        }
    }
    
    // MARK: - 星期标题的颜色 ⚡️
    //周一到周五的颜色
    var weekdayHeaderTextColor = UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1) {
        didSet{
            for i in 0..<weekHeaderView.subviews.count{
                let label = weekHeaderView.subviews[i] as! UILabel
                label.textColor = (i == 0 || i == 6) ? weekdayHeaderWeekendTextColor : weekdayHeaderTextColor
            }
        }
    }
    
    //周六和周日的颜色
    var weekdayHeaderWeekendTextColor = UIColor(red: 0.75, green: 0.25, blue: 0.25, alpha: 1){
        didSet{
            for i in 0..<weekHeaderView.subviews.count{
                let label = weekHeaderView.subviews[i] as! UILabel
                label.textColor = (i == 0 || i == 6) ? weekdayHeaderWeekendTextColor : weekdayHeaderTextColor
            }
        }
    }
    // MARK: - 日历具体的颜色 ⚡️
    //月份字体的颜色
    var componentTextColor =  UIColor(red: CGFloat(110.0 / 255.0), green: CGFloat(110.0 / 255.0), blue: CGFloat(110.0 / 255.0), alpha: CGFloat(1.0)){
        didSet{
            for btn in contentWrapperView.subviews{
                let bt = btn as! UIButton
                bt.setTitleColor(componentTextColor, for: .normal)
            }
        }
    }
    //今日的背景色
    var todayIndicatorColor =  UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        {
        didSet{
            for btn in contentWrapperView.subviews{
                let bt = btn as! UIButton
                if bt.titleLabel?.text == "\(SPCalendarTool.Day(Date()))"{
//                    bt.backgroundColor = todayIndicatorColor
                }
            }
        }
    }
    
    var todayIndicatorImage =  UIImage(named: "home-pop-icon1")
        {
        didSet{
            for btn in contentWrapperView.subviews{
                let bt = btn as! UIButton
                if bt.titleLabel?.text == "\(SPCalendarTool.Day(Date()))"{
                    bt.setTitleColor(.white, for: .normal)
                    bt.setBackgroundImage(todayIndicatorImage, for: .normal)
                }
            }
        }
    }
    
    //点击之后前景颜色
    var highlightedComponentTextColor = UIColor.white
    var highlightedComponentBackImage = UIImage(named: "home-pop-icon2")
    //点击的背景色
    var selectedIndicatorColor = UIColor(red: 0.74, green: 0.18, blue: 0.06, alpha: 1)
    
    // MARK: - 日历三大块 ⚡️
    private let navigationBar = UIView()  //主要标题栏
    private var textLabel = UILabel()   //标题栏文字
    private let weekHeaderView = UIView()   //星期标题栏
    private let contentWrapperView = UIView()    //日历内容栏
    private var Nowdate = Date()  //全局更改的时间
    
    // MARK: - 创建日历 ⚡️
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 布局三大控件
    private func commonInit() {
        //添加导航栏
        navigationBar.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 40)
        self.addSubview(navigationBar)
        createNavigationBar()
        
        
        
        //添加星期标题栏
        weekHeaderView.frame = CGRect(x: 10, y: navigationBar.frame.maxY, width: self.frame.width - 20, height: 20)
        self.addSubview(weekHeaderView)
        createWeekHeaderView()
        
        
        //添加日历内容栏
        contentWrapperView.frame = CGRect(x: 10, y: weekHeaderView.frame.maxY, width: self.frame.width - 20, height: self.frame.height - weekHeaderView.frame.maxY)
        self.addSubview(contentWrapperView)
        createcontentWrapperView(date: Nowdate)
    }

}

// MARK: - 创建日历主要标题栏 ⚡️
extension SPCalendarView {
    
    /// 创建主要标题栏
    private func createNavigationBar() {
        let textLabel = UILabel()           //中间标题
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        textLabel.font = UIFont.systemFont(ofSize: 16)
        navigationBar.addSubview(textLabel)
        
        //布局
        self.addConstraint(NSLayoutConstraint(item: textLabel,
                                              attribute: NSLayoutConstraint.Attribute.centerX,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: navigationBar,
            attribute: NSLayoutConstraint.Attribute.centerX,
            multiplier: 1.0,
            constant: 0))
        self.addConstraint(NSLayoutConstraint(item: textLabel,
                                              attribute: NSLayoutConstraint.Attribute.centerY,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: navigationBar,
            attribute: NSLayoutConstraint.Attribute.centerY,
            multiplier: 1.0,
            constant: 0))
        textLabel.text = "\(SPCalendarTool.Year(Nowdate))年\(SPCalendarTool.Month(Nowdate))月"
        self.textLabel = textLabel
    }
}
// MARK: - 创建日历星期标题栏 ⚡️
extension SPCalendarView {
    
    private func createWeekHeaderView() {
        let array = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
        let itemW = weekHeaderView.frame.width / 7
        
        for i in 0..<7{
            let x = itemW * CGFloat(i)
            let label = UILabel(frame: CGRect(x: x, y: 0, width: itemW, height: weekHeaderView.frame.height))
                
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = (i == 0 || i == 6) ? weekdayHeaderWeekendTextColor : weekdayHeaderTextColor
            label.text = array[i]
            weekHeaderView.addSubview(label)
        }
    }
}

// MARK: - 创建日历内容栏 ⚡️

extension SPCalendarView {
    
    private func createcontentWrapperView(date: Date) {
        let wid: CGFloat = 5
        let itemWH = (contentWrapperView.frame.width - 8 * wid) / 7
        
        
        let UpMonthdays = SPCalendarTool.DaysInMonth( SPCalendarTool.UpMonth(date))        //上个月有多少天
        let monthDays   = SPCalendarTool.DaysInMonth(date)        //这个月的总天数
        let Weekday     = SPCalendarTool.DayinWeek(date)          //第一天为周几
        var day         = 0
        
        
        
        for i in 0..<42{
            let x  = CGFloat(i % 7) * itemWH
            let y  = CGFloat(i / 7) * itemWH
            let spacew = CGFloat(i % 7) * wid + wid
            
            let btn = UIButton(frame: CGRect(x: x + spacew, y: y, width: itemWH, height: itemWH))
                
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(componentTextColor, for: .normal)
            btn.layer.cornerRadius = itemWH / 2
            
            if (i < Weekday) {
                day = UpMonthdays - Weekday + i + 1
                btn.alpha = 0.2
            }else if (i > Weekday + monthDays - 1){
                day = i + 1 - Weekday - monthDays;
                btn.alpha = 0.2
            }else{
                day = i - Weekday + 1;
                btn.alpha = 1.0
                if day == SPCalendarTool.Day(date) && SPCalendarTool.Month(Nowdate) == SPCalendarTool.Month(Date()) && SPCalendarTool.Year(Nowdate) == SPCalendarTool.Year(Date()){
                    btn.setTitleColor(.white, for: .normal)
                    btn.setBackgroundImage(todayIndicatorImage, for: .normal)
//                    btn.backgroundColor = todayIndicatorColor
                }
                //按钮点击   签到到这里我是用不上的   所以这里并没有添加
                //                    btn.addTarget(self, action: Selector("logDate:"), forControlEvents: .TouchUpInside)
            }
            contentWrapperView.addSubview(btn)
            btn.setTitle("\(day)", for: .normal)
        }
    }
    
    @objc private func logDate(btn: UIButton) {
        btn.isSelected = true
        btn.backgroundColor = btn.isSelected ? nil : nil
        btn.setBackgroundImage(highlightedComponentBackImage, for: .selected)
        btn.setTitleColor(highlightedComponentTextColor, for: .selected)
    }
}
