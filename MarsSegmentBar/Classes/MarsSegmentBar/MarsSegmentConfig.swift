//
//  MarsSegmentConfig.swift
//  MarsSegmentBar
//
//  Created by sunxin on 2019/10/28.
//

import UIKit

class MarsSegmentConfig: NSObject {
    
    var barBackgroundColor: UIColor = .clear
    var itemNormalColor: UIColor = .lightGray
    var itemSelectColor: UIColor = .red
    var itemFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    var indicatorColor: UIColor = .red
    var indicatorHeight: CGFloat = 2
    var indicatorExtraW: CGFloat = 10
    
    
    static let defaultConfig: MarsSegmentConfig = {
        let defaultConfig = MarsSegmentConfig()
        return defaultConfig
    }()
    
}
