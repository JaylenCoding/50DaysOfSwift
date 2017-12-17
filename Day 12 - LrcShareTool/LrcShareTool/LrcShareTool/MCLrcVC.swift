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
    var decoder: MCLrcDecoder = MCLrcDecoder()
    var fileName: String?
    var cellSelecting: Bool?
    
    // 存储cell的选择状态
    var cellDict = [String:Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fileName = "song";
        setupTableView()
        setupButton()
        loadLrc()
    }
    
    // MARK: - 私有API
    fileprivate func setupTableView() {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.black
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        cellSelecting = false
        // 添加长按手势
        let longPressGes = UILongPressGestureRecognizer(target: self, action: #selector(tableViewLongPressAction(_:)))
        tableView.addGestureRecognizer(longPressGes)
        
        self.view.addSubview(tableView)
        self.tableview = tableView
        
        // 注册所用的cell
        registeCell()
    }
    
    fileprivate func setupButton() {
        createButton.isEnabled = false
        createButton.tintColor = UIColor.clear
        createButton.target = self
        createButton.action = #selector(createShareImage)
    }
    
    fileprivate func registeCell() {
        tableview.register(UINib(nibName: "MCLrcCell", bundle: Bundle.main), forCellReuseIdentifier: "cellId")
    }
    
    fileprivate func loadLrc() {
        let filePath = self.decoder.loadLrc(fileName: self.fileName!)
        self.decoder.decodeLrc(lrcString: filePath)
        self.tableview.reloadData()
    }
    
    @objc fileprivate func createShareImage() {
        if cellSelecting==false {
            return
        }
        
        // 生成歌词数组
        var lrcArr = [String]()
        for i in 0..<decoder.lrcArray.count {
            // 生成Key，通过Key访问字典
            let isLrcSelected = cellDict["0-\(i)"]
            if isLrcSelected != nil && isLrcSelected == true {
                lrcArr.append(self.decoder.lrcArray[i])
            }
        }
        
        // 如果没有选择歌词，则提示
        if lrcArr.count <= 0 {
            let alert = UIAlertController(title: "提示", message: "请至少选择一句歌词", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // 显示歌词分享界面
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LrcShareVC") as! MCShareVC
        vc.lrcArr = lrcArr
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func tableViewLongPressAction(_ longPresas: UILongPressGestureRecognizer) {
        if longPresas.state != UIGestureRecognizerState.began {
            return
        }
        
        // 切换选择模式
        cellSelecting = cellSelecting==true ? false: true
        if cellSelecting == true {
            // 清空映射字典
            cellDict.removeAll()
            // 显示按钮
            createButton.isEnabled = true
            createButton.tintColor = UIColor.red
        }
        else {
            // 隐藏按钮
            createButton.isEnabled = false
            createButton.tintColor = UIColor.clear
        }
        
        // 更新tableview
        self.tableview.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! MCLrcCell
        
        cell.reset()
        cell.lrc = self.decoder.lrcArray[indexPath.row]
        cell.lrcSelecting = cellSelecting!
        // 判断cell是否正处于选择状态
        let isCellSelected = cellDict["\(indexPath.section)-\(indexPath.row)"]
        if let isCellSelected = isCellSelected {
            cell.lrcSelected = isCellSelected
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        
        // 如果没有在选择状态，则退出
        if cellSelecting == false {
            return
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! MCLrcCell
        cell.lrcSelected = cell.lrcSelected==true ? false : true
        self.cellDict["\(indexPath.section)-\(indexPath.row)"] = cell.lrcSelected
    }
    
}
