//
//  titelView.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/14.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

class titelView: UIView {
    
    var titleLabel = UILabel()
    
    func setTitleView(title: String) -> Void {
        self.frame = CGRect.init(x: 0, y: 0, width: APP_WIDTH, height: 44)
        self.ad
    }
    
    func addTitleLabel(title: String) -> Void {
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(titleLabel)
        titleLabel.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(self.mas_centerX)
            make?.centerY.equalTo()(self.mas_centerY)
        }
    }
}
