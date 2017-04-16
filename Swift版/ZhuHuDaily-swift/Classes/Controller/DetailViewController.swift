//
//  DetailViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/15.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMsgForDetail(_ id: String) -> Void {
        self.loadStoryDetail(id)
    }

    
    // MARK - UI
    func setUl() -> Void {
        
    }
    
    // MARK - LoadStory
    private func loadStoryDetail(_ id: String) -> Void {
        
        NetworkTool.shared.loadDateInfo(urlString: STORY_DETAIL_API.appending(id), params: ["":""], success: { (responseObject) in
            let detailStoryModel = StoryDetailModel.mj_object(withKeyValues: responseObject)
            print(detailStoryModel!.title)
        }) { (error) in
            
        }
    }
}
