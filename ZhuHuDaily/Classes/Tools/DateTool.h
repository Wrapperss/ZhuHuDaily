//
//  DateTool.h
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/24.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTool : NSObject<NSCopying>

+ (instancetype)shareDateTool;

- (NSString *)transformUrlStringFromDate:(NSDate *)date;

- (NSString *)transformTitleStringFromDate:(NSDate *)date;
@end
