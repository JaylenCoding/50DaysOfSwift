//
//  MCLrcVC.swift
//  LrcShareTool
//
//  Created by Minecode on 2017/12/5.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

class MCLrcVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // UI控件
    var tableview: UITableView!
    @IBOutlet weak var createButton: UIBarButtonItem!
    
    // 属性列表
    var decoder: MCLrcDecoder!
    var fileName: String?
    var cellSelecting: Bool?
    
    // 存储cell的选择状态
    var cellDict: Dictionary<String, Bool>
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

// MARK: - 代理方法实现
extension MCLrcVC {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.decoder.lrcArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // FIXME: -
    }
    
}
