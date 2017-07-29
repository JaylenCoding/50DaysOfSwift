//
//  AppDelegate.swift
//  TabBarCenterButton
//
//  Created by Minecode on 2017/7/14.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow()
        window?.backgroundColor = UIColor.red
        
        window?.rootViewController = MCMainViewController()
        window?.makeKeyAndVisible()
        
        
        return true
    }


}

