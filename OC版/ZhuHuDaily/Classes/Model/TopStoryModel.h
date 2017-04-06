//
//  TopStoryModel.h
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/27.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopStoryModel : NSObject <NSCoding>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *ID;
+ (NSDictionary *)mj_replacedKeyFromPropertyName;
@end
