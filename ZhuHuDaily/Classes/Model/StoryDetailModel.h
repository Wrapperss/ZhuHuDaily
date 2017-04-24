//
//  StoryDetailModel.h
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/27.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryDetailModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *imageSource;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, retain) NSArray *css;
@property (nonatomic, retain) NSArray *images;
@property (nonatomic, copy) NSString *ID;
+ (NSDictionary *)mj_replacedKeyFromPropertyName;


@end
