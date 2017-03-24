//
//  ZYWMenuView.h
//  ZYWMenuController
//
//  Created by yearwen on 16/7/24.
//  Copyright © 2016年 yearwen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MenuButtonCallBackBlock)(NSInteger index,NSString *title,NSInteger titleCounts);


@interface ZYWMenuView : UIView

/**
 *  Convenient init method
 *
 *  @param titles Your menu options
 *
 *  @return object
 */

-(id)initWithTitles:(NSArray *)titles;


/**
 *  Custom init method
 *
 *  @param titles Your menu options
 *
 *  @return object
 */
-(id)initWithTitles:(NSArray *)titles withButtonHeight:(CGFloat)height withMenuColor:(UIColor *)menuColor withBackBlurStyle:(UIBlurEffectStyle)style;


/**
 *  Method to trigger the animation
 */
-(void)trigger;




/**
 *  The height of the menu height
 */
@property(nonatomic,assign)CGFloat menuButtonHeight;


/**
 *  The block of menu buttons cliced call back
 */
@property(nonatomic,copy)MenuButtonCallBackBlock menuClickBlock;





@end
