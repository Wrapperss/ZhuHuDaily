//
//  MainViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/6.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import MJRefresh
import MJExtension
import YYCache

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StoryRotateViewDelegate {

    var tableView = UITableView()
    var headView = StoryRotateView()
    
    var storyArray = [StoryModel]()
    var topStoryArray = [TopStoryModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.loadStory()
        self.setTableView()
        self.setNav()
        self.setRefresh()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UI
    func setNav() -> Void {
        let dic = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = dic
    }
    
    func setTableView() -> Void {
        self.tableView.frame = CGRect.init(x: 0, y: -22, width: APP_WIDTH, height: APP_HEIGHT + 22)
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
    
    func clickOneView(currentPage: Int) -> Void {
        
        print("点击了\(currentPage)")
    }
    
    // MARK: - Refresh
    func setRefresh() -> Void {
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.loadStory()
            self.tableView.mj_header.endRefreshing()
        })
    }
    
    // MARK: - LoadStory
    func loadStory() -> Void {
        NetworkTool.shared.loadDateInfo(urlString: LATEST_STORY_API, params: ["":""], success: { (responseObject) in
            
            //最新故事
            var currentStoryArray = [StoryModel]()
            for story in responseObject["stories"] as! Array<Any> {
                let storyModel: StoryModel = StoryModel.mj_object(withKeyValues: story)
                if !self.storyArray.contains(storyModel) {
                    //UI
                    self.storyArray.append(storyModel)
                    //Cache
                    currentStoryArray.append(storyModel)
                }
            }
            CacheTool.shared.setStoryCacheBy(ketDate: Date(), AndObject: currentStoryArray)
            
            //封面故事
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
            print("失败")
        }
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.storyArray.count == 0 {
            if (YYCache.init(name: "stotriesCache")?.containsObject(forKey: String(describing: Date.init())))! {
                storyArray = (YYCache.init(name: "stotriesCache")?.object(forKey: String(describing: Date.init())))! as! [StoryModel]
            }
            if self.storyArray.count == 0 {
                return 10
            }
        }
        return self.storyArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "storyCell"
        let cell: StoryViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! StoryViewCell
//        if storyArray.count == 0 {
//            if (YYCache.init(name: "stotriesCache")?.containsObject(forKey: String(describing: NSDate())))! {
//                storyArray = (YYCache.init(name: "stotriesCache")?.object(forKey: String(describing: Date.init())))! as! [StoryModel]
//            }
//            if storyArray.count == 0 {
//                cell.pictureView?.image = UIImage.init(named: "default_image")
//                cell.titleLabel.text = "知乎日报"
//                cell.mutilPicture.isHidden = true
//            }
//        }
//        else {
//            cell.setMessage(self.storyArray[indexPath.row])
//        }
        cell.pictureView?.image = UIImage.init(named: "default_image")
        cell.titleLabel.text = "知乎日报"
        cell.mutilPicture.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let edg = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        cell.separatorInset = edg
    }
}
