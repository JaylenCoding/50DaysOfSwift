//
//  MCCollectionViewController.swift
//  MovableCollectionView
//
//  Created by Minecode on 2017/7/24.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

private let cellID: String = "CellId"

class MCCollectionViewController: UICollectionViewController {
    
    lazy var cells: [String] = {
        var tmpArray: [String] = []
        for i in 0..<100 {
            var text = "\(i)"
            tmpArray.append(text)
        }
        return tmpArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension MCCollectionViewController {
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MCTextCollectionViewCell
        cell.textLabel.text = cells[indexPath.item]
        
        return cell
    }
    
    // 实现重排的关键
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tmpCell = cells.remove(at: sourceIndexPath.item)
        cells.insert(tmpCell, at: destinationIndexPath.item)
    }
}
