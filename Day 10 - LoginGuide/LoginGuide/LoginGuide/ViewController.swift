//
//  ViewController.swift
//  LoginGuide
//
//  Created by Minecode on 2017/10/2.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
    }
    
    fileprivate func registerCell() {
        collectionView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: cellId)
    }

}
