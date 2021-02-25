//
//  UIImage+Extension.swift
//  MVVMRx_SampleProject
//
//  Created by 宋璞 on 2019/7/10.
//  Copyright © 2019 宋璞. All rights reserved.
//

import UIKit

extension UIImage {
    
    
    /// 根据坐标获取图片中的像素颜色值
    ///
    /// - Parameters:
    ///   - x:
    ///   - y:
    subscript (x: Int, y: Int) -> UIColor? {
        
        if x < 0 || x > Int(size.width) || y < 0 || y > Int(size.height) {
            return nil
        }
        
        let provider = self.cgImage!.dataProvider
        let providerData = provider!.data
        let data = CFDataGetBytePtr(providerData)
        
        let numberOfCommponents = 4
        let pixelData = ((Int(size.width) * y) + x) * numberOfCommponents
        
        let r = CGFloat(data![pixelData]) / 255.0
        let g = CGFloat(data![pixelData + 1]) / 255.0
        let b = CGFloat(data![pixelData + 2]) / 255.0
        let a = CGFloat(data![pixelData + 3]) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    func test() {
        // 获取图片
        let image = UIImage(named: "img")!
        let width = Int(image.size.width)
        let height = Int(image.size.height)
        print("图片尺寸：", "\(width) * \(height)")
        
        // 获取指定像素颜色
        if let hexString = image[0, 0]?.hexString {
            print("左上角颜色：", hexString)
        }
        if let hexString = image[width, 0]?.hexString {
            print("右上角颜色：", hexString)
        }
        if let hexString = image[width/2, height/2]?.hexString {
            print("中间点颜色：", hexString)
        }
    }
}
