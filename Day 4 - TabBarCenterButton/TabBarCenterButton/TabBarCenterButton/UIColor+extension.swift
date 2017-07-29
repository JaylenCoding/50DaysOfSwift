//
//  UIColor+extension.swift
//  TabBarCenterButton
//
//  Created by Minecode on 2017/7/14.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

extension  UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    class func arc_random() -> UIColor {
        
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    class func arc_random_light() -> UIColor {
        
        return UIColor(r: CGFloat(arc4random_uniform(128)+128), g: CGFloat(arc4random_uniform(128)+128), b: CGFloat(arc4random_uniform(128)+128))
    }
    
    class func arc_random_dark() -> UIColor {
        
        return UIColor(r: CGFloat(arc4random_uniform(128)), g: CGFloat(arc4random_uniform(128)), b: CGFloat(arc4random_uniform(128)))
    }
}
