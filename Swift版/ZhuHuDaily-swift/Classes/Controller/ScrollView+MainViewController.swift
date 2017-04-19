//
//  ScrollView+MainViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/19.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit


extension MainViewController {
    
    // scrollView 已经滑动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = tableView.contentOffset.y / ( CGFloat.init(self.storyArray.count) * CGFloat.init(80) )
        
        self.fakeNav.backgroundColor = UIColor.init(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: alpha)
        
        if tableView.contentOffset.y > ( CGFloat.init(self.storyArray.count) * CGFloat.init(80) + HEAD_VIEW_HEIGHT ) {
            
        }
    }
    
//    // scrollView 开始拖动
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print("scrollViewWillBeginDragging")
//    }
//    
//    
//    // scrollView 结束拖动
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        print("scrollViewDidEndDragging")
//    }
//    
//    // scrollView 开始减速（以下两个方法注意与以上两个方法加以区别）
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        print("scrollViewWillBeginDecelerating")
//    }
//    
//    // scrollview 减速停止
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("scrollViewDidEndDecelerating")
//    }
    
}
