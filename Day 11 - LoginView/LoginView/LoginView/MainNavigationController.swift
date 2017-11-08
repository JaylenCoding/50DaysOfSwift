//
//  MainNavigationController.swift
//  LoginGuide
//
//  Created by Minecode on 2017/11/5.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.cyan
        
        // 添加delay时间，放置在window初始化之前显示
        if isFirstRun() {
            perform(#selector(showGuideController), with: nil, afterDelay: 0.01)
        }
        else if isLoggedIn() {
            // show
        }
        else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    func isFirstRun() -> Bool {
        return !UserDefaults.standard.bool(forKey: "hasFirstRun")
    }
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    @objc func showGuideController() {
        let storyboard = UIStoryboard(name: "Guide", bundle: nil)
        let guideVC = storyboard.instantiateInitialViewController() as! GuideViewController
        
        present(guideVC, animated: false) {
            // do something
        }
    }
    
    func finishShowGuideController() {
        UserDefaults.standard.set(true, forKey: "hasFirstRun")
        UserDefaults.standard.synchronize()
        
        dismiss(animated: false, completion: nil)
        showLoginController()
    }
    
    @objc func showLoginController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginVC = storyboard.instantiateInitialViewController() as! LoginViewController
        
        present(loginVC, animated: false) {
            // do something
        }
    }
    
    func finishLoginHandler() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        
        // FIXME: <Do something to handle login>
    }

}
