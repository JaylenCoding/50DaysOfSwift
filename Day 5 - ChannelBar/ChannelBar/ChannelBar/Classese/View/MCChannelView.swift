//
//  MCChannelView.swift
//  ChannelBar
//
//  Created by Minecode on 2017/7/18.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

let kChannelMargin: CGFloat = 10

protocol MCChannelViewDelegate {
    func channelView(_ channelView: MCChannelView, forItemAt index: Int)
}

class MCChannelView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var delegate: MCChannelViewDelegate?
    
    // 外界设置channel时，就会调用这个方法
    var channels: Array<String> = Array<String>() {
        didSet {
            setChannels(channels: channels)
        }
    }
    
    func setChannels(channels: Array<String>) {
        
        var offsetX: CGFloat = kChannelMargin
        
        for model in channels {
            // 创建label
            let label = UILabel()
            
            label.text = model
            label.font = UIFont.systemFont(ofSize: 18)
            label.textColor = UIColor.black
            
            label.sizeToFit()
            label.font = UIFont.systemFont(ofSize: 14)
            
            var frame = label.frame
            frame.origin.x = offsetX
            frame.size.height = 35
            label.frame = frame
            
            // 给label添加点击手势
            // 注意，要开启label的用户交互
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelClicked(withGesture:)))
            label.addGestureRecognizer(tapGesture)
            label.isUserInteractionEnabled = true
            
            // 添加到视图
            self.scrollView.addSubview(label)
            
            offsetX += label.frame.size.width + kChannelMargin
            
        }
        
        // 设置滚动视图的滚动距离
        scrollView.contentSize = CGSize(width: offsetX, height: 35)
        
        // 设置初始label索引值
        self.setScale(withScale: 1, forIndex: 0)
    }
    
    func labelClicked(withGesture gesture: UITapGestureRecognizer) {
        
        // 由于点击了按钮是想让页面变化，故在此应该将点击事件抛给控制器
        
        // 使用守护语句保证操作安全
        // 获取点击的索引值
        guard let view = gesture.view,
            let index: Int = self.scrollView.subviews.index(of: view)
        else { return }
        
        // 传值给控制器
        /*
         * 视图传值给控制器主要有以下方法：
         * 1) 通过闭包
         * 2) 通过协议
         * 3) 通过消息
         */
        
        // 使用守护语法判断是否遵守了协议以及是否实现协议
        guard let delegate = self.delegate else { return }
        // 传给控制器
        delegate.channelView(self, forItemAt: index)
        
        // 点击时，让点击的放大，其他缩小
        for i in 0..<self.scrollView.subviews.count {
            let label = self.scrollView.subviews[i]
            if label == gesture.view {
                self.setScale(withScale: 1, forIndex: i)
            } else {
                self.setScale(withScale: 0, forIndex: i)
            }
        }
    }
    
    
    /// 响应设置label比例的方法
    ///
    /// - Parameters:
    ///   - scale: 变换的比例
    ///   - index: 当前页面索引
    func setScale(withScale scale: CGFloat, forIndex index: Int) {
        
        let label = self.scrollView.subviews[index] as! UILabel
        
        label.textColor = UIColor.init(red: scale, green: 0, blue: 0, alpha: 1)
        
        // 根据比例设置在14-18区间的字号
        let fontSize = 14 + (18-14) * scale
        label.transform = CGAffineTransform(scaleX: fontSize / 14, y: fontSize / 14)
    }

}
