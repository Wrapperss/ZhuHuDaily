//
//  Extension-MainViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/13.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

extension MainViewController {
    
    // MARK: - Refresh
    func setRefresh() -> Void {
//        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
//            self.loadStory()
//            self.tableView.mj_header.endRefreshing()
//        })
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.loadMoreStory()
            self.tableView.mj_footer.endRefreshing()
        })
    }
    
    // MARK: - LoadStory
    func loadStory() -> Void {
        NetworkTool.shared.loadDateInfo(urlString: LATEST_STORY_API, params: ["":""], success: { (responseObject) in
            
            //最新故事
            var currentStoryArray = [StoryModel]()
            self.storyArray.removeAll()
            for story in responseObject["stories"] as! Array<Any> {
                let storyModel: StoryModel = StoryModel.mj_object(withKeyValues: story)
                //UI
                self.storyArray.append(storyModel)
                //Cache
                currentStoryArray.append(storyModel)
                
            }
            CacheTool.shared.setStoryCacheBy(ketDate: Date(), AndObject: currentStoryArray)
            
            //封面故事
            self.topStoryArray.removeAll()
            for topStory in responseObject["top_stories"] as! Array<Any> {
                let topStoryModel: TopStoryModel = TopStoryModel.mj_object(withKeyValues: topStory)
                if !self.topStoryArray.contains(topStoryModel) {
                    //UI
                    //Cache
                    self.topStoryArray.append(topStoryModel)
                }
            }
            CacheTool.shared.setTopStory(self.topStoryArray)
            self.headView.upDateView(self.topStoryArray)
            self.tableView.reloadData()
        }) { (error) in
            if CacheTool.shared.getStoryCacheBy(keyDate: Date()) != nil {
                SVProgressHUD.showError(withStatus: "刷新失败!")
                self.storyArray = CacheTool.shared.getStoryCacheBy(keyDate: Date())!
                self.topStoryArray = CacheTool.shared.getTopStory()!
            }
            else {
                SVProgressHUD.showError(withStatus: "加载失败!")
            }
        }
    }
    
    // MARK - 加载更多消息
    func loadMoreStory() -> Void {
        if CacheTool.shared.getStoryCacheBy(keyDate: self.date) != nil {
            self.beforeStoryArray.append(CacheTool.shared.getStoryCacheBy(keyDate: self.date)!)
            self.setDate()
            self.tableView.reloadData()
        }
        else {
            NetworkTool.shared.loadDateInfo(urlString: BeEFORE_STORY_API.appending(DateTool.shared.transfromDateToApi(self.date)), params: ["":""], success: { (responseObject) in
                
                var storyArray = [StoryModel]()
                for story in responseObject["stories"]  as! Array<Any>{
                    let storyModel: StoryModel = StoryModel.mj_object(withKeyValues: story)
                    storyArray.append(storyModel)
                }
                
                self.beforeStoryArray.append(storyArray)
                CacheTool.shared.setStoryCacheBy(ketDate: self.date, AndObject: storyArray)
                self.setDate()
                self.tableView.reloadData()
            }) { (error) in
                SVProgressHUD.showError(withStatus: "加载失败")
            }
        }
    }
    
    // MARK -  时间前置一天
    func setDate() -> Void {
        self.date = Date.init(timeInterval: -24*60*60, since: date)
        self.titleArray.append(DateTool.shared.transfromDate(self.date))
    }

}
