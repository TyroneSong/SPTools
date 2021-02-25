//
//  UIColor+Extension.swift
//  MVVMRx_SampleProject
//
//  Created by 宋璞 on 2019/7/10.
//  Copyright © 2019 宋璞. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red     = CGFloat(r) / 255.0
        let green   = CGFloat(g) / 255.0
        let blue    = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    
    public convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    
    var hexString: String? {
        var red:    CGFloat = 0
        var green:  CGFloat = 0
        var blue:   CGFloat = 0
        var alpha:  CGFloat = 0
        
        let multiplier = CGFloat(255.99999)
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        } else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
    
    func test(){
        // 16进制颜色 -> UIColor
        let color = UIColor(hexString: "#C0C0C0")
        print("UIColor：", color)
        
        // UIColor -> 16进制颜色
        let hexString = color.hexString
        print("16进制颜色值：", hexString ?? "")
    }
}

extension UIColor {
    
    // 返回HSBA模式颜色值
    public var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h * 360, s, b, a)
    }
    
    func testHSB() {
        print("--- 橙色HSB值 ---")
        print("色相:", UIColor.orange.hsba.hue)
        print("饱和度:", UIColor.orange.hsba.saturation)
        print("亮度:", UIColor.orange.hsba.brightness)
        print("透明度:", UIColor.orange.hsba.alpha)
        
        print("--- 自定义颜色HSB值 ---")
        let color = UIColor(red: 0x37/255, green: 0xba/255, blue: 0x46/255, alpha: 0.5)
        print("色相:", color.hsba.hue)
        print("饱和度:", color.hsba.saturation)
        print("亮度:", color.hsba.brightness)
        print("透明度:", color.hsba.alpha)
    }
}

// MARK: - UIColor转UIImage
extension UIColor {
    /// UIColor转UIImage
    class func creatIamgeWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return colorImage!
    }
}
