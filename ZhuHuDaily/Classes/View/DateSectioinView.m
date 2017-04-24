//
//  DateSectioinView.m
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/23.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import "DateSectioinView.h"

@implementation DateSectioinView

- (id)initWithFrame:(CGRect)frame Date:(NSString *)dateString {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI:dateString];
    }
    return self;
}
- (void)setUpUI:(NSString *)dateString {
    self.backgroundColor = ZhuHuColor;
    self.DateLabel.frame = self.bounds;
    _DateLabel.text = dateString;
    _DateLabel.textColor = [UIColor whiteColor];
    _DateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_DateLabel];
}

#pragma mark - Lazy
- (UILabel *)DateLabel {
    if (!_DateLabel) {
        _DateLabel = [[UILabel alloc] init];
    }
    return _DateLabel;
}
@end
