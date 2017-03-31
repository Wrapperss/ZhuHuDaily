//
//  TopStoryModel.m
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/27.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import "TopStoryModel.h"

@implementation TopStoryModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.image = [aDecoder decodeObjectForKey:@"image"];
    self.ID = [aDecoder decodeObjectForKey:@"ID"];
    return self;
}
@end
