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
        return NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)!
    }
    
    func decodeLrc(lrcString: NSString) {
        var sepArray = lrcString.components(separatedBy: "[")
        var lineArray = [String]()
        for i in 0..<sepArray.count {
            if sepArray[i].count > 0 {
                lineArray = sepArray[i].components(separatedBy: "]");
                if (lineArray[0] != "\n") {
                    self.timeArray.append(lineArray[0])
                    self.lrcArray.append(lineArray.count>1 ? lineArray[1] : "")
                }
            }
        }
    }
    
}
