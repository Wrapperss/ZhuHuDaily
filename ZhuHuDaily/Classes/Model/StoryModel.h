//
//  StoryModel.h
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/22.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSArray *images;
@property (nonatomic, copy) NSString *ID;
+ (NSDictionary *)mj_replacedKeyFromPropertyName;
@end
