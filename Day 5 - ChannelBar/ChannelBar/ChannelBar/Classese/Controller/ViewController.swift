//
//  ViewController.swift
//  ChannelBar
//
//  Created by Minecode on 2017/7/18.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

let cellId = "cellId"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MCChannelViewDelegate {
    
    @IBOutlet weak var channelView: MCChannelView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var channels: Array<String> = ["推荐", "资讯", "重庆", "社会", "军事", "娱乐", "明星", "动漫", "音乐", "影视", "政治", "历史", "二次元", "中国足球", "科技", "NBA"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.channelView.channels = channels
        self.automaticallyAdjustsScrollViewInsets = false
        
        // 设置频道条的代理
        self.channelView.delegate = self
    }


}

// 实现表格方法
extension ViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.channels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.arc_random_light()
        
        let label:UILabel = cell.viewWithTag(100) as! UILabel
        label.text = self.channels[indexPath.item]
        
        return cell
    }
}

// 实现滑动条方法(以实现视图对控制器操作)
extension ViewController {
    
    /// 实现频道条操作时collocationView同步切换的方法
    ///
    /// - Parameters:
    ///   - channelView: 操作对应的channelView
    ///   - index: 切换到的view的索引值
    func channelView(_ channelView: MCChannelView, forItemAt index: Int) {
        
        // 构造要滚动到的位置对应的indexPath
        let indexPath = IndexPath(item: index, section: 0)
        
        self.collectionView.scrollToItem(at: indexPath, at: .init(rawValue: 0), animated: false)
    }
}
