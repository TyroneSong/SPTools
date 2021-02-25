//
//  ViewController.swift
//  SPCalendar
//
//  Created by 宋璞 on 2020/2/25.
//  Copyright © 2020 宋璞. All rights reserved.
//

import UIKit

var signList = [10,15,22]

class ViewController: UIViewController {

    var calendar: SPCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        calendar = SPCalendarView(frame: CGRect(x: 20, y: 80, width: 300, height: 500))
        calendar.SigninList = signList
        view.addSubview(calendar)
    }


}

