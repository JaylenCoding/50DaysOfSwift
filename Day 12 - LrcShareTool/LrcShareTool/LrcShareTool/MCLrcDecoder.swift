//
//  MCLrcDecoder.swift
//  LrcShareTool
//
//  Created by Minecode on 2017/12/5.
//  Copyright © 2017年 Minecode. All rights reserved.
//

import UIKit

class MCLrcDecoder: NSObject {

    // 存储歌词的数组
    lazy var lrcArray = [String]()
    // 存储歌词时间的数组
    lazy var timeArray = [String]()
    // 歌词文件名
    var fileName = ""
    
    public func loadLrc(fileName: String) -> NSString {
        let filePath = Bundle.main.path(forResource: fileName, ofType: "lrc")
        let data = NSData.init(contentsOfFile: filePath!)
        return NSString.init(data: data! as Data, encoding: String.Encoding.utf8.rawValue)!
    }
    
    private func decodeLrc(lrcString: String) {
        var sepArray = lrcString.components(separatedBy: "[");
        var lineArray = [String]()
        for i in 0..<sepArray.count {
            
        }
    }
    
}
