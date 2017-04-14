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
import SVProgressHUD

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StoryRotateViewDelegate {

    var tableView = UITableView()
    var headView = StoryRotateView()
    
    var storyArray = [StoryModel]()
    var beforeStoryArray = [[StoryModel]]()
    var topStoryArray = [TopStoryModel]()
    var titleArray = [String]()
    
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        self.loadStory()
        self.loadMoreStory()
        
        self.setTableView()
        self.setNav()
        self.setRefresh()
        
    }

    func clickOneView(currentPage: Int) -> Void {
        
        print("点击了\(currentPage)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.beforeStoryArray.count == 0 && self.storyArray.count == 0 {
            return 2;
        }
        else {
            return self.beforeStoryArray.count + 1;
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
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
        else {
            if self.beforeStoryArray.count == 0 {
                return 0
            }
            else {
                return self.beforeStoryArray[section-1].count
            }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "storyCell"
        let cell: StoryViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! StoryViewCell
        if indexPath.section == 0 {
            if storyArray.count == 0 {
                if (CacheTool.shared.getStoryCacheBy(keyDate: Date())) != nil {
                    self.storyArray = CacheTool.shared.getStoryCacheBy(keyDate: Date())!
                }
                else {
                    cell.pictureView?.image = UIImage.init(named: "default_image")
                    cell.titleLabel.text = "知乎日报"
                    cell.mutilPicture.isHidden = true
                    return cell
                }
            }
            cell.setMessage(storyArray[indexPath.row])
        }
        else {
            cell.setMessage(self.beforeStoryArray[indexPath.section-1][indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        else {
            let headView = TitleView()
            headView.setMessage(title: self.titleArray[section - 1])
            return headView
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let edg = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        cell.separatorInset = edg
    }
}
