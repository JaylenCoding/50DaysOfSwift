//
//  ViewController.swift
//  ControlledButton
//
//  Created by Minecode on 2017/6/19.
//  Copyright © 2017年 org.minecode. All rights reserved.
//

import UIKit

fileprivate let kButtonH: CGFloat = 200


class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // 控件
    @IBOutlet weak var segmentBar: UISegmentedControl!
    var mainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        NSLog("Segment Selected")
        switch sender.selectedSegmentIndex {
        case 0:
            self.mainButton.backgroundColor = UIColor.red
        case 1:
            self.mainButton.backgroundColor = UIColor.green
        case 2:
            self.mainButton.backgroundColor = UIColor.blue
        case 3:
            self.mainButton.backgroundColor = UIColor.randomColor()
        default:
            self.mainButton.backgroundColor = UIColor.yellow
        }
    }
    
}

extension ViewController {
    
    func setupUI() {
        //  设置界面背景
        let backgroundLayer = CAGradientLayer()
        backgroundLayer.colors = [UIColor.yellow.cgColor, UIColor.white.cgColor]
        backgroundLayer.startPoint = CGPoint(x: 0.5, y: 0)
        backgroundLayer.endPoint = CGPoint(x: 0.5, y: 1)
        backgroundLayer.frame = self.view.bounds
        self.view.layer.addSublayer(backgroundLayer)
        
        // 避免渐变背景遮挡选项卡
        self.view.bringSubview(toFront: segmentBar)
        
        // 添加交互按钮
        self.mainButton = UIButton()
        mainButton.frame.size = CGSize(width: kButtonH, height: kButtonH)
        mainButton.layer.cornerRadius = kButtonH/2
        mainButton.backgroundColor = UIColor.red
        mainButton.center = self.view.center
        mainButton.setTitle("Minecode", for: .normal)
        mainButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        mainButton.titleLabel?.textColor = UIColor.white
        self.view.addSubview(mainButton)
        
        addGesture()
    }
    
    func addGesture() {
        
        let singleTapGes = UITapGestureRecognizer(target: self, action: #selector(signleTapAction(_:)))
        singleTapGes.numberOfTapsRequired = 1
        self.mainButton.addGestureRecognizer(singleTapGes)
        
        let longPressGes = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        longPressGes.allowableMovement = 10
        longPressGes.minimumPressDuration = 1
        self.mainButton.addGestureRecognizer(longPressGes)
        
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        panGes.minimumNumberOfTouches = 1
        panGes.maximumNumberOfTouches = 1
        self.mainButton.addGestureRecognizer(panGes)
        
        let pinchGes = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(_:)))
        pinchGes.delegate = self
        self.mainButton.addGestureRecognizer(pinchGes)
    }
    
}

// 手势实现
extension ViewController {
    
    func signleTapAction(_ signleTapGes: UITapGestureRecognizer) {
        NSLog("Signle Tap")
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        // 周期
        animation.duration = 0.08
        animation.repeatCount = 4
        // 抖动角度
        animation.fromValue = (-M_1_PI)
        animation.toValue = (M_1_PI)
        // 恢复原样
        animation.autoreverses = true
        // 设置抖动中心
        self.mainButton.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.mainButton.layer.add(animation, forKey: "rotation.z")
        
    }
    
    func longPressAction(_ longPressGes: UILongPressGestureRecognizer) {
        NSLog("Long Press")
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        // 周期
        animation.duration = 0.08
        animation.repeatCount = 2
        // 抖动幅度
        animation.values = [0, -self.mainButton.frame.width/4, self.mainButton.frame.width/4, 0]
        // 恢复原样
        animation.autoreverses = true
        // 设置抖动中心
        self.mainButton.layer.add(animation, forKey: "rotation.x")
    }
    
    func panAction(_ panGes: UIPanGestureRecognizer) {
        NSLog("Drag")
        
        // 获取坐标并修改
        let movePoint = panGes.translation(in: self.view)
        var curPoint = self.mainButton.center
        curPoint.x += movePoint.x
        curPoint.y += movePoint.y
        self.mainButton.center = curPoint
        
        // 清空一下，防止坐标叠加
        panGes.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func pinchAction(_ pinchGes: UIPinchGestureRecognizer) {
        NSLog("Pinch Action")
        
        let pinchScale = pinchGes.scale
        self.mainButton.transform = self.mainButton.transform.scaledBy(x: pinchScale, y: pinchScale);
        
        // 清空一下，防止比例叠加
        pinchGes.scale = 1.0
    }
    
}

extension UIColor {
    
    // 子类使用convenience初始化方法，必须调用父类的designated方法
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
}
