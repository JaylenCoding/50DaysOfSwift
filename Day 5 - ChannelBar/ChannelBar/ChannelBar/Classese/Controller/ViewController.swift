//
//  ViewController.swift
//  ChannelBar
//
//  Created by Minecode on 2017/7/18.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var channelView: MCChannelView!
    
    lazy var channels: Array<String> = ["推荐", "资讯", "重庆", "社会", "军事", "娱乐", "明星", "动漫", "音乐", "影视", "政治", "历史", "二次元", "中国足球", "科技", "NBA"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.channelView.channels = channels
    }


}

