//
//  ViewController.swift
//  LoginGuide
//
//  Created by Minecode on 2017/10/2.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Widget
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    // Constrains
    @IBOutlet weak var pageControlBottom: NSLayoutConstraint!
    @IBOutlet weak var skipButtonTop: NSLayoutConstraint!
    @IBOutlet weak var continueButtonTop: NSLayoutConstraint!
    
    // Data
    let guideCell = "guideCellId"
    let loginCell = "loginCellId"
    lazy var pages: [PageItem] = [
        PageItem(dict: ["imageName":"moreInfo", "title":"Do more you want", "detail":"Do more of what you always wanted.\nExplore and discover groups in your area that are all about the things you love."]),
        PageItem(dict: ["imageName":"moreInspir", "title":"Get inspired, stay inspired", "detail":"Meetup with people who love what you love\nand keep the conversation going."]),
        PageItem(dict: ["imageName":"moreSimpler", "title":"Simpler than ever", "detail":"Simpler than ever to start your own.\nCreate the perfect Meetup for you. Meetup gets you members and makes it easy."])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setButton()
        
        pageControl.numberOfPages = pages.count + 1
    }
    
    fileprivate func registerCell() {
        collectionView.register(UINib.init(nibName: "PageViewCell", bundle: nil), forCellWithReuseIdentifier: guideCell)
        collectionView.register(UINib.init(nibName: "LoginViewCell", bundle: nil), forCellWithReuseIdentifier: loginCell)
    }
    
    fileprivate func setButton() {
        continueButton.addTarget(self, action: #selector(pageSkipHandler(sender:)), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(pageSkipHandler(sender:)), for: .touchUpInside)
    }
    
    @objc func pageSkipHandler(sender: UIButton) {
        let indexPath: IndexPath!
        if sender.tag == 100 {
            // continue button
            indexPath = IndexPath(row: pageControl.currentPage+1, section: 0)
            pageControl.currentPage += 1
        }
        else {
            // skip button
            indexPath = IndexPath(row: pages.count, section: 0)
            pageControl.currentPage = pages.count
        }
        if pageControl.currentPage == pages.count {
            moveItemRelativeToScreen(off: true)
        }
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNum: Int = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNum
        
        if pageNum == pages.count {
            moveItemRelativeToScreen(off: true)
        } else {
            moveItemRelativeToScreen(off: false)
        }
        
    }
    
    // 重构，代码复用
    func moveItemRelativeToScreen(off: Bool) {
        if off {
            pageControlBottom.constant = -20
            skipButtonTop.constant = -50
            continueButtonTop.constant = -50
            // disable button to avoid crash
            skipButton.isEnabled = false
            continueButton.isEnabled = false
        } else {
            pageControlBottom.constant = 10
            skipButtonTop.constant = 0
            continueButtonTop.constant = 0
            skipButton.isEnabled = true
            continueButton.isEnabled = true
        }
        
        // layout subviews
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
}

// MARK: - UICollectionViewDelegate and UICollectionViewDatasource impeletation
extension ViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == pages.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCell, for: indexPath)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: guideCell, for: indexPath) as! PageViewCell
        
        cell.imageView.image = nil
        
        let page = pages[indexPath.row]
        cell.titleLabel.text = page.title
        cell.detailLabel.text = page.detail
        cell.imageView.image = UIImage(named: page.imageName!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
}
