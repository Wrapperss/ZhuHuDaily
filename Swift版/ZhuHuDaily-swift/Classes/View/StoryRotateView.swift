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
    
    // MARK - UI
    func setStoryRotateView(topStoryArray: [TopStoryModel], heigit: CGFloat) -> Void {
        self.frame = CGRect.init(x: 0, y: 0, width: APP_WIDTH, height: heigit)
        self.setUpScrollView(topStoryArray, height: heigit)
        self.setUpPageControl(topStoryArray)
        self.creatTimer()
    }
    
    
    // MARK - ScrollView
    private func setUpScrollView(_ topStoryArray: [TopStoryModel], height: CGFloat) -> Void {
        if topStoryArray.count == 0 {
            for i in 0...pageCount-1 {
                
                //imageView
                let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(i) * APP_WIDTH, y: 0, width: APP_WIDTH, height: height))
                imageView.image = UIImage.init(named: "default_image")
                scrollView.addSubview(imageView)
                
                //label
                let titleLabel = UILabel.init()
                titleLabel.text = ""
                titleLabel.font = UIFont.systemFont(ofSize: 20)
                titleLabel.numberOfLines = 2
                titleLabel.textColor = UIColor.white
                imageView.addSubview(titleLabel)
                titleLabel.mas_makeConstraints({ (make) in
                    make?.left.equalTo()(imageView.mas_left)?.with().insets()(UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0))
                    make?.right.equalTo()(imageView.mas_right)?.with().insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -10))
                    make?.bottom.equalTo()(imageView.mas_bottom)?.insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: -10, right: 0))
                })
            }
            //imageView
            let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(pageCount) * APP_WIDTH, y: 0, width: APP_WIDTH, height: height))
            imageView.image = UIImage.init(named: "default_image")
            self.scrollView.addSubview(imageView)
            
            //label
            let titleLabel = UILabel.init()
            titleLabel.text = ""
            titleLabel.font = UIFont.systemFont(ofSize: 20)
            titleLabel.numberOfLines = 2
            titleLabel.textColor = UIColor.white
            imageView.addSubview(titleLabel)
            titleLabel.mas_makeConstraints({ (make) in
                make?.left.equalTo()(imageView.mas_left)?.with().insets()(UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0))
                make?.right.equalTo()(imageView.mas_right)?.with().insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -10))
                make?.bottom.equalTo()(imageView.mas_bottom)?.insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: -10, right: 0))
            })
        }
        else {
            for i in 0...pageCount-1 {
                //imageView
                let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(i) * APP_WIDTH, y: 0, width: APP_WIDTH, height: height))
                
                imageView.sd_setImage(with: URL.init(string: topStoryArray[i].image), placeholderImage: UIImage.init(named: "default_image"))
                scrollView.addSubview(imageView)
                
                //Label
                let titleLabel = UILabel.init()
                titleLabel.text = topStoryArray[i].title
                titleLabel.font = UIFont.systemFont(ofSize: 20)
                titleLabel.numberOfLines = 2
                titleLabel.textColor = UIColor.white
                imageView.addSubview(titleLabel)
                titleLabel.mas_makeConstraints({ (make) in
                    make?.left.equalTo()(imageView.mas_left)?.with().insets()(UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0))
                    make?.right.equalTo()(imageView.mas_right)?.with().insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -10))
                    make?.bottom.equalTo()(imageView.mas_bottom)?.insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: -10, right: 0))
                })

             }
            //imageView
            let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(pageCount) * APP_WIDTH, y: 0, width: APP_WIDTH, height: height))
            imageView.sd_setImage(with: URL.init(string: topStoryArray[0].image), placeholderImage: UIImage.init(named: "default_image"))
            self.scrollView.addSubview(imageView)
            
            //label
            let titleLabel = UILabel.init()
            titleLabel.text = ""
            titleLabel.font = UIFont.systemFont(ofSize: 20)
            titleLabel.numberOfLines = 2
            titleLabel.textColor = UIColor.white
            imageView.addSubview(titleLabel)
            titleLabel.mas_makeConstraints({ (make) in
                make?.left.equalTo()(imageView.mas_left)?.with().insets()(UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0))
                make?.right.equalTo()(imageView.mas_right)?.with().insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -10))
                make?.bottom.equalTo()(imageView.mas_bottom)?.insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: -10, right: 0))
            })
            
        }
        
        scrollView.frame = self.bounds
        scrollView.contentSize = CGSize.init(width: CGFloat(pageCount + 1) * APP_WIDTH, height: height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        self.addSubview(scrollView)
    }
    
    // MARK - pageControl
    private func setUpPageControl(_ topStoryArray: [TopStoryModel]) -> Void {
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
    
    // MARK - 创建时间控制器
    private func creatTimer() -> Void {
        self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.nextTopStory), userInfo: nil, repeats: true)
        
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    // MARK - 翻页操作
    func nextTopStory() -> Void {
        currentPage += 1
        if currentPage == 6 {
            scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
            currentPage = 0
            pageControl.currentPage = currentPage
        }
        if currentPage == 5 {
            pageControl.currentPage = 0
            scrollView.setContentOffset(CGPoint.init(x: CGFloat(pageCount) * APP_WIDTH, y: 0), animated: true)
        }
        else {
            scrollView.setContentOffset(CGPoint.init(x: CGFloat(currentPage) * APP_WIDTH, y: 0), animated: true)
            pageControl.currentPage = currentPage
        }
    }
    
    // MARK - 更新信息
    func upDateView(_ topStoryArray: [TopStoryModel]) -> Void {
        for item in self.scrollView.subviews {
            item.removeFromSuperview()
        }
        for i in 0...pageCount-1 {
            //imageView
            let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(i) * APP_WIDTH, y: 0, width: APP_WIDTH, height: self.scrollView.bounds.height))
            
            imageView.sd_setImage(with: URL.init(string: topStoryArray[i].image), placeholderImage: UIImage.init(named: "default_image"))
            scrollView.addSubview(imageView)
            
            //label
            let titleLabel = UILabel.init()
            titleLabel.text = topStoryArray[i].title
            titleLabel.font = UIFont.systemFont(ofSize: 20)
            titleLabel.numberOfLines = 2
            titleLabel.textColor = UIColor.white
            imageView.addSubview(titleLabel)
            titleLabel.mas_makeConstraints({ (make) in
                make?.left.equalTo()(imageView.mas_left)?.with().insets()(UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0))
                make?.right.equalTo()(imageView.mas_right)?.with().insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -10))
                make?.bottom.equalTo()(imageView.mas_bottom)?.insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: -10, right: 0))
            })
        }
        //imageView
        let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(pageCount) * APP_WIDTH, y: 0, width: APP_WIDTH, height: self.scrollView.bounds.height))
        imageView.sd_setImage(with: URL.init(string: topStoryArray[0].image), placeholderImage: UIImage.init(named: "default_image"))
        self.scrollView.addSubview(imageView)
        
        //label
        let titleLabel = UILabel.init()
        titleLabel.text = topStoryArray[0].title
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = UIColor.white
        imageView.addSubview(titleLabel)
        titleLabel.mas_makeConstraints({ (make) in
            make?.left.equalTo()(imageView.mas_left)?.with().insets()(UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0))
            make?.right.equalTo()(imageView.mas_right)?.with().insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -10))
            make?.bottom.equalTo()(imageView.mas_bottom)?.insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: -10, right: 0))
        })
    }
    
    // MARK - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.currentPage = Int(self.scrollView.contentOffset.x / APP_WIDTH)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.timer?.invalidate()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.creatTimer()
    }
    
}
