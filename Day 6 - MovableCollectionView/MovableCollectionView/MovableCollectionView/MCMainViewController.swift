//
//  MCMainViewController.swift
//  MovableCollectionView
//
//  Created by Minecode on 2017/7/24.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

// 枚举
enum VC: String {
    case ViewController
    case CollectionViewController
    
    func segueIdentifier() -> String {
        switch self {
        case .ViewController:
            return "VCSegueIdentifier"
        case .CollectionViewController:
            return "CVCSegueIdentifier"
        }
    }
}


private let cellID: String = "CellId"

class MCMainViewController: UITableViewController {
    
    lazy var vc: [VC] = {
        var tmpArray: [VC] = [.ViewController, .CollectionViewController]
        return tmpArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
}

extension MCMainViewController {
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vc.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = vc[indexPath.item].rawValue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: vc[indexPath.item].segueIdentifier(), sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        for iter in 0..<vc.count {
            if segue.identifier == vc[iter].segueIdentifier() {
                segue.destination.title = vc[iter].rawValue
                break
            }
        }
        
    }
}
