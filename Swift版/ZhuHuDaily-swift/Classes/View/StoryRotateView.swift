//
//  StoryRotateView.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/11.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import Masonry

class StoryRotateView: UIView, UIScrollViewDelegate{
    var scrollView = UIScrollView()
    var pageControl = UIPageControl()
    let pageCount = 5
    var timer: Timer?
    var currentPage = Int()
    
    func setStoryRotateView(topStoryArray: [TopStoryModel], heigit: CGFloat) -> Void {
        self.frame = CGRect.init(x: 0, y: 0, width: APP_WIDTH, height: heigit)
        self.setUpScrollView(topStoryArray, height: heigit)
        self.setUpPageControl(topStoryArray)
        self.creatTimer()
    }
    
    
    func setUpScrollView(_ topStoryArray: [TopStoryModel], height: CGFloat) -> Void {
        if topStoryArray.count == 0 {
            for i in 0...pageCount-1 {
                let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(i) * APP_WIDTH, y: 0, width: APP_WIDTH, height: height))
                imageView.image = UIImage.init(named: "default_image")
                scrollView.addSubview(imageView)
            }
            let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(pageCount) * APP_WIDTH, y: 0, width: APP_WIDTH, height: height))
            imageView.image = UIImage.init(named: "default_image")
            self.scrollView.addSubview(imageView)
        }
        else {
            for i in 0...pageCount-1 {
                let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(i) * APP_WIDTH, y: 0, width: APP_WIDTH, height: height))
                
                imageView.sd_setImage(with: URL.init(string: topStoryArray[i].image), placeholderImage: UIImage.init(named: "default_image"))
                scrollView.addSubview(imageView)
            }
            let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(pageCount) * APP_WIDTH, y: 0, width: APP_WIDTH, height: height))
            imageView.sd_setImage(with: URL.init(string: topStoryArray[0].image), placeholderImage: UIImage.init(named: "default_image"))
            self.scrollView.addSubview(imageView)
            
        }
        
        scrollView.frame = self.bounds
        scrollView.contentSize = CGSize.init(width: CGFloat(pageCount + 1) * APP_WIDTH, height: height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        self.addSubview(scrollView)
    }
    func setUpPageControl(_ topStoryArray: [TopStoryModel]) -> Void {
        pageControl.numberOfPages = pageCount
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        self.addSubview(pageControl)
        pageControl.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(self.mas_centerX)
            make?.bottom.equalTo()(self.mas_bottom)?.with().insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: 3, right: 0))
        }
    }
    
    func creatTimer() -> Void {
        self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.nextTopStory), userInfo: nil, repeats: true)
        
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    func nextTopStory() -> Void {
        self.scrollView.setContentOffset(CGPoint.init(x: self.scrollView.contentOffset.x + APP_WIDTH, y: 0), animated: true)
        currentPage = Int(self.scrollView.contentOffset.x / APP_WIDTH + 1)
        if currentPage == 6 {
            currentPage = 1
        }
        self.pageControl.currentPage = currentPage
        if self.scrollView.contentOffset.x == CGFloat(pageCount) * APP_WIDTH {
            self.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
        }
    }
    
    func upDateView(_ topStoryArray: [TopStoryModel]) -> Void {
        for item in self.scrollView.subviews {
            item.removeFromSuperview()
        }
        for i in 0...pageCount-1 {
            let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(i) * APP_WIDTH, y: 0, width: APP_WIDTH, height: self.scrollView.bounds.height))
            
            imageView.sd_setImage(with: URL.init(string: topStoryArray[i].image), placeholderImage: UIImage.init(named: "default_image"))
            scrollView.addSubview(imageView)
        }
        let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(pageCount) * APP_WIDTH, y: 0, width: APP_WIDTH, height: self.scrollView.bounds.height))
        imageView.sd_setImage(with: URL.init(string: topStoryArray[0].image), placeholderImage: UIImage.init(named: "default_image"))
        self.scrollView.addSubview(imageView)
    }
    
    // MARK - UIScrollViewDelegate
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.creatTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(self.scrollView.contentOffset.x / APP_WIDTH + 1)
        self.currentPage = Int(self.scrollView.contentOffset.x / APP_WIDTH + 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.timer?.invalidate()
    }
}
