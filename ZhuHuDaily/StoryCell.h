//
//  StoryCell.h
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/21.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryModel.h"

@interface StoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *mutilPicture;


+ (instancetype)cellWithTableView:(UITableView *) tableview;

- (void)setCellMsg:(StoryModel *)storyModel;
@end
