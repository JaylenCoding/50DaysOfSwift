//
//  MCViewController.swift
//  MovableCollectionView
//
//  Created by Minecode on 2017/7/24.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

private let cellID: String = "CellId"

class MCViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    lazy var cells: [String] = {
        var tmpArray: [String] = []
        for i in 0..<100 {
            var text = "\(i)"
            tmpArray.append(text)
        }
        return tmpArray
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 消除顶部白条
        self.automaticallyAdjustsScrollViewInsets = false
        
        // 添加长按手势, 不使用CollectionViewController的时候需要自行设置手势
        let longPressGes = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        self.collectionView.addGestureRecognizer(longPressGes)
    }
    
    
    /// 响应长按手势(排序)
    ///
    /// - Parameter gesture: 需要传入手势检测器，因为要判断长按的位置等等属性
    func longPressAction(_ gesture: UILongPressGestureRecognizer) {
        // 判断长按的状态
        switch gesture.state {
        case .began:
            // 获取选择位置
            // indexPathForItem获取Item所处的indexPath
            // indexPath是表格或列表推算出当前row和col的属性
            // ***GestureRecognizer的location方法返回在所处view的一个CGPoint属性
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else { return }
           collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            // 移动了
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            // 结束移动
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
}

extension MCViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MCTextCollectionViewCell
        cell.textLabel.text = cells[indexPath.item]
        
        return cell
    }
    
    // 实现重排的关键
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tmpCell = cells.remove(at: sourceIndexPath.item)
        cells.insert(tmpCell, at: destinationIndexPath.item)
    }
}
