//
//  MCShareVC.swift
//  LrcShareTool
//
//  Created by Minecode on 2017/12/5.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

class MCShareVC: UIViewController, UIScrollViewDelegate {
    
    // UI控件
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var bkgImage: UIImageView!
    // 数据
    var lrcArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupButton()
        drawLrcBackground()
        addLrcToBackground()
    }
    
    // MARK: - 初始化私有方法
    func setupView() {
        scrollView.backgroundColor = UIColor.clear
        scrollView.delegate = self
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        self.bkgImage = UIImageView()
        bkgImage.contentMode = UIViewContentMode.scaleToFill
    }
    
    func setupButton() {
        shareButton.addTarget(self, action: #selector(shareImageHandler), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveImageHandler), for: .touchUpInside)
    }
    
    
    let kItemHeight: CGFloat = 20
    let kItemMargin: CGFloat = 5
    
    // 通过图片拉伸，将背景图片适配各种屏幕
    func drawLrcBackground() {
        let kItemDefaultHeight: CGFloat = 150
        
        let imageWidth = view.frame.size.width
        let imageHeight = CGFloat(lrcArr.count) * (kItemHeight + kItemMargin)
        
        bkgImage.frame = CGRect(x: 0, y: 0, width: imageWidth, height: kItemDefaultHeight + imageHeight)
        scrollView.addSubview(bkgImage)
        
        // 获取图片
        let sourceImage = UIImage(named: "shareBkg.png")
        bkgImage.image = sourceImage
        // 设置图片拉伸参数
        let topInset = sourceImage!.size.height * 0.4
        let leftInset = sourceImage!.size.width * 0.7
        let bottomInset = sourceImage!.size.height - topInset - 1
        let rightInset = sourceImage!.size.width - leftInset - 1
        let bkgEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        // 拉伸图片
        let resizedImage = sourceImage?.resizableImage(withCapInsets: bkgEdgeInsets, resizingMode: UIImageResizingMode.stretch)
        // 设置图片和ScrollView
        bkgImage.image = resizedImage
        scrollView.contentSize = bkgImage.frame.size
    }
    
    // 向背景中添加歌词
    func addLrcToBackground() {
        let kLrcStartX: CGFloat = 40
        let kLrcStartY: CGFloat = 50
        
        let kLrcRightMargin: CGFloat = 20
        
        let xCursor = kLrcStartX
        var yCursor = kLrcStartY
        // 按顺序添加歌词到背景上
        for i in 0..<lrcArr.count {
            // 获取当前歌词
            let curLrc = lrcArr[i]
            // 创建歌词对应的label
            let lrcLabel = UILabel(frame: CGRect(x: xCursor, y: yCursor, width: view.frame.size.width-2*kLrcStartX, height: kItemHeight))
            lrcLabel.text = curLrc
            lrcLabel.textColor = UIColor.darkGray
            lrcLabel.font = UIFont.systemFont(ofSize: 15)
            bkgImage.addSubview(lrcLabel)
            // 改变指针位置
            yCursor += kItemHeight + kItemMargin
        }
        
        // 添加底部歌名
        let rightText = "——[Minecode - iOS.Dev]"
        yCursor += kLrcRightMargin
        let rightLabel = UILabel(frame: CGRect(x: xCursor, y: yCursor, width: view.frame.size.width-2*kLrcStartX, height: kItemHeight))
        rightLabel.text = rightText
        rightLabel.textColor = UIColor.darkGray
        rightLabel.textAlignment = NSTextAlignment.right
        rightLabel.font = UIFont.systemFont(ofSize: 15)
        bkgImage.addSubview(rightLabel)
    }
    
    // MARK: - 分享和保存
    // 保存到相册中
    @objc func saveImageHandler() {
        // 生成View的图片
        UIGraphicsBeginImageContextWithOptions(self.bkgImage.bounds.size, true, 0)
        bkgImage.layer.render(in: UIGraphicsGetCurrentContext()!)
        let bitmap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 保存到相册
        UIImageWriteToSavedPhotosAlbum(bitmap!, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    // 使用系统分享功能分享图片
    @objc func shareImageHandler() {
        // 生成View的图片
        UIGraphicsBeginImageContextWithOptions(self.bkgImage.bounds.size, true, 0)
        bkgImage.layer.render(in: UIGraphicsGetCurrentContext()!)
        let bitmap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let activityVc = UIActivityViewController(activityItems: [bitmap!], applicationActivities: nil)
        self.present(activityVc, animated: true, completion: nil)
    }
    
    // 保存到相册后的回调
    @objc func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject) {
        
        if error != nil {
            let alert = UIAlertController(title: "成功", message: "保存成功", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "失败", message: "保存失败", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
