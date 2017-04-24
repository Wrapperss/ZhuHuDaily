//
//  DateSectioinView.h
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/23.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateSectioinView : UIView

@property (nonatomic, retain)UILabel *DateLabel;

- (id)initWithFrame:(CGRect)frame Date:(NSString *)date;

@end
