//
//  MCLrcCell.swift
//  LrcShareTool
//
//  Created by Minecode on 2017/12/5.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

class MCLrcCell: UITableViewCell {
    
    // UI控件
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var lrcLabel: UILabel!
    @IBOutlet weak var imageConstrains: NSLayoutConstraint!
    
    // 属性, 使用计算属性观察者
    var lrcSelecting = false {
        didSet {
            self.didChangeLrcSelecting()
        }
    }
    var lrcSelected = false {
        didSet {
            self.didChangedLrcSelected()
        }
    }
    var lrc: String = "" {
        didSet {
            self.lrcLabel.text = lrc
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        self.reset()
    }
    
    func reset() {
        // 重置selecting选项
        self.lrcSelecting = false;
        // 重置selected选项
        self.lrcSelected = false;
        // FIXME:
    }
    
    // MARK: - 私有方法API
    let IMG_CONSTRAIN_SELE: CGFloat = 8
    let IMG_CONSTRAIN_NONSELE: CGFloat = -28
    private func didChangeLrcSelecting() {
        // 设置约束
        if (self.lrcSelecting) {
             self.imageConstrains.constant = IMG_CONSTRAIN_SELE
        }
        else {
            self.imageConstrains.constant = IMG_CONSTRAIN_NONSELE
        }
    }
    
    private func didChangedLrcSelected() {
        self.iconImage.image = self.lrcSelected ? #imageLiteral(resourceName: "img_selected") : #imageLiteral(resourceName: "img_nonselected")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
