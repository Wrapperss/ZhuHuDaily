//
//  StoryCoverView.m
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/28.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import "StoryCoverView.h"

@implementation StoryCoverView

- (instancetype)initWithFrame:(CGRect)frame StoryDetail:(StoryDetailModel *)storyDetailModel {
    self = [super initWithFrame:frame];
    if (self) {
        self.storyDetailModel = storyDetailModel;
        [self setUI];
    }
    return self;
}

- (void)setMessage:(StoryDetailModel *)storyDetailModel {
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:self.storyDetailModel.image] placeholderImage:[UIImage imageNamed:@"default_image"]];
}
#pragma mark - UI
- (void)setUI {
    //titleLabel
    self.backgroundColor = [UIColor redColor];
    self.titleLabel.text = self.storyDetailModel.title;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _titleLabel.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(20.0)];
    _titleLabel.numberOfLines = 2;
    _titleLabel.shadowColor = [UIColor colorWithWhite:0.1f alpha:0.8f];
    _titleLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).with.inset(10);
        make.left.mas_equalTo(self.mas_left).with.inset(10);
    }];
    
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:self.storyDetailModel.image] placeholderImage:[UIImage imageNamed:@"default_image"]];
    [self addSubview:self.coverImage];
}

#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UILabel *)imageSourcelabel {
    if (!_imageSourcelabel) {
        _imageSourcelabel = [[UILabel alloc] init];
    }
    return _imageSourcelabel;
}

- (UIImageView *)coverImage{
    if (!_coverImage) {
        _coverImage = [[UIImageView alloc] init];
        _coverImage.frame = self.bounds;
    }
    return _coverImage;
}
@end
