//
//  StoryDetailModel.m
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/27.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import "StoryDetailModel.h"

@implementation StoryDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             @"imageSource" : @"image_source",
             @"shareUrl" : @"share_url"
             };
}

@end
