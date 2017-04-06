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

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.shareUrl forKey:@"shareUrl"];
    [aCoder encodeObject:self.imageSource forKey:@"imageSource"];
    [aCoder encodeObject:self.body forKey:@"body"];
    [aCoder encodeObject:self.css forKey:@"css"];
    [aCoder encodeObject:self.images forKey:@"images"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.image = [aDecoder decodeObjectForKey:@"image"];
    self.shareUrl = [aDecoder decodeObjectForKey:@"shareUrl"];
    self.imageSource = [aDecoder decodeObjectForKey:@"imageSource"];
    self.body = [aDecoder decodeObjectForKey:@"body"];
    self.css = [aDecoder decodeObjectForKey:@"css"];
    self.images = [aDecoder decodeObjectForKey:@"images"];
    self.ID = [aDecoder decodeObjectForKey:@"ID"];
    return self;
}
@end
