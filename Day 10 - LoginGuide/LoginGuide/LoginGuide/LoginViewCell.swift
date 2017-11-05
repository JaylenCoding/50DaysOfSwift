//
//  LoginViewCell.swift
//  LoginGuide
//
//  Created by Minecode on 2017/11/5.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

class LoginViewCell: UICollectionViewCell {

    @IBOutlet weak var loginButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        loginButton.addTarget(self, action: #selector(loginHandler), for: .touchUpInside)
    }
    
    @objc fileprivate func loginHandler() {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else {return}
        
        mainNavigationController.finishShowGuideController()
    }

}
