//
//  StoryCoverView.h
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/28.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryDetailModel.h"
@interface StoryCoverView : UIView
@property (nonatomic, retain)StoryDetailModel *storyDetailModel;
@property (nonatomic, retain)UIImageView *coverImage;
@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UILabel *imageSourcelabel;
- (instancetype)initWithFrame:(CGRect)frame StoryDetail:(StoryDetailModel *)storyDetailModel;
- (void)setMessage:(StoryDetailModel *)storyDetailModel;

@end
