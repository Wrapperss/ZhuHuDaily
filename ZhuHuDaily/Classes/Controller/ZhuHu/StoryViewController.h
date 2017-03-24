//
//  StoryViewController.h
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/24.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryViewController : UIViewController

@property (nonatomic, copy)NSString *storyId;

@property (nonatomic, retain)UIWebView *storyWebView;

- (instancetype)initWithStoryId:(NSString *)storyId;
@end
