//
//  PageItem.swift
//  LoginGuide
//
//  Created by Minecode on 2017/11/5.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

@objcMembers class PageItem: NSObject {
    
    var imageName: String?
    var title: String?
    var detail: String?
    
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        // Do nothing
    }
    
}
