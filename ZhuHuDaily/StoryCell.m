//
//  StoryCell.m
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/21.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import "StoryCell.h"

@implementation StoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *) tableview {
    static NSString *identifer = @"storyCell";
    StoryCell *storyCell = [tableview dequeueReusableCellWithIdentifier:identifer];
    if (storyCell == nil) {
        storyCell = [[[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:nil options:nil] firstObject];
    }
    return storyCell;
}

- (void)setCellMsg:(StoryModel *)storyModel {
    self.titleLabel.text = storyModel.title;
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:storyModel.images[0]] placeholderImage:[UIImage imageNamed:@"default_image"]];
    if (storyModel.images.count == 1) {
        self.mutilPicture.hidden = YES;
    }
}

@end
