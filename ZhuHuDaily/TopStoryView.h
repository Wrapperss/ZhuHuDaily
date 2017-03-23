//
//  TopStoryView.h
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/23.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopStoryView : UIView

@property (nonatomic, retain) UIScrollView *topScrollView;
@property (nonatomic, retain) UIPageControl *topPageControl;

@property (nonatomic, strong) NSTimer *timer;
@end
