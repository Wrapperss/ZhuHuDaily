//
//  ZhuHuViewController.h
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/22.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryModel.h"
#import "TopStoryModel.h"
@interface ZhuHuViewController : UITableViewController
@property (nonatomic, retain) NSMutableArray<StoryModel *> *storiesArray;
@property (nonatomic, retain) NSMutableArray<TopStoryModel *> *topStoriesArray;
@property (nonatomic, retain) NSMutableArray<NSMutableArray<StoryModel *> *> *beforeStoriesArray;
@property (nonatomic, retain) NSDate *date;
@end
