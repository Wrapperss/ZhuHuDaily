//
//  UI-MainViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/14.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

extension MainViewController {
    
    // MARK: - UI
    func setNav() -> Void {
//        let topBar = UIView.init(frame: CGRect.init(x: 0, y: 0, width: APP_WIDTH, height: 20))
//        topBar.backgroundColor = ZHI_HU_COLOR
//        self.view.addSubview(topBar)
    }
    
    func setTableView() -> Void {
        self.tableView.frame = CGRect.init(x: 0, y: -20, width: APP_WIDTH, height: APP_HEIGHT + 20)
        self.tableView.register(UINib.init(nibName: "StoryViewCell", bundle: nil), forCellReuseIdentifier: "storyCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setHeadView()
        self.view.addSubview(tableView)
    }
    
    func setHeadView() -> Void {
        if (CacheTool.shared.getTopStory()) != nil {
            self.topStoryArray = CacheTool.shared.getTopStory()!
        }
        headView.setStoryRotateView(topStoryArray: self.topStoryArray, heigit: APP_HEIGHT * 0.3)
        headView.delegate = self
        self.tableView.tableHeaderView = headView
    }
}
