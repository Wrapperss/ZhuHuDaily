//
//  StoryViewController.h
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/24.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryDetailModel.h"
#import <WebKit/WebKit.h>

@interface StoryViewController : UIViewController

@property (nonatomic, copy)NSString *storyId;

@property (nonatomic, retain)UIWebView *storyWebView;

@property (nonatomic, retain)UIView *fakeNavigationBar;

@property (nonatomic, retain)StoryDetailModel *storyDetail;

- (instancetype)initWithStoryId:(NSString *)storyId;
@end
