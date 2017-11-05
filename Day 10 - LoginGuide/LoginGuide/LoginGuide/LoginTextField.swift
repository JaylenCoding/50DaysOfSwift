//
//  LoginTextField.swift
//  LoginGuide
//
//  Created by Minecode on 2017/11/5.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {

    // 设置文字框的大小
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+10, y: bounds.origin.y, width: bounds.width-10, height: bounds.height)
    }

    // 设置编辑时文字框的大小
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+10, y: bounds.origin.y, width: bounds.width-10, height: bounds.height)
    }
    
}
