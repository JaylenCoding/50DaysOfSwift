//
//  ViewController.swift
//  PopUp&FadeOut
//
//  Created by Minecode on 2017/7/25.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

class ViewController: UIViewController {
    
    var bkgView: UIView!
    var popupView: UIView!
    var popupLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.cyan
        
        let popupButton: UIButton = UIButton()
        popupButton.frame.size = CGSize(width: 100, height: 100)
        popupButton.center = self.view.center
        popupButton.layer.cornerRadius = 50
        popupButton.backgroundColor = UIColor.magenta
        popupButton.setTitle("Pop-Up", for: .normal)
        
        popupButton.addTarget(self, action: #selector(showView), for: .touchUpInside)
        
        self.view.addSubview(popupButton)
    }
}

extension ViewController {
    
    func showView() {
        // 添加带透明度的背景视图，从而实现下方视图变暗
        guard let window = UIApplication.shared.keyWindow else { return }
        bkgView = UIView()
        bkgView.frame = window.bounds
        bkgView.backgroundColor = UIColor(white: 0.1, alpha: 0.6)
        window.addSubview(bkgView)
        
        // 添加弹出控件，添加到window而不是bkgView
        popupView = UIView()
        popupView.frame = CGRect(x: 30, y: kScreenHeight, width: kScreenWidth-60, height: 60)
        popupView.backgroundColor = UIColor.orange
        popupView.layer.cornerRadius = 15
        window.addSubview(popupView)
        
        // 添加一个弹出动画
        UIView.animate(withDuration: 0.3) {
            // 尾随闭包播放弹出动画
            self.popupView.frame = CGRect(x: 30, y: (kScreenHeight-60)/2, width: kScreenWidth-60, height: 60)
        }
        
        // 添加一个移除手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideView))
        bkgView.addGestureRecognizer(tapGesture)
    }
    
    func hideView() {
        // 收回动画
        UIView.animate(withDuration: 0.3) {
            // 尾随闭包播放弹出动画
            self.popupView.frame = CGRect(x: 30, y: kScreenHeight, width: kScreenWidth-60, height: 60)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.popupView.removeFromSuperview()
                self.bkgView.removeFromSuperview()
            }
        }
    }
    
}
