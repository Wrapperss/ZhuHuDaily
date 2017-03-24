//
//  ZYWMenuButton.h
//  ZYWMenuController
//
//  Created by yearwen on 16/7/24.
//  Copyright © 2016年 yearwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYWMenuButton : UIView

/**
 *  onvenient init method
 *
 *  @param title title
 *
 *  @return object
 */
-(id)initWithTitle:(NSString *)title;


/**
 *  The button color
 */
@property(nonatomic,strong)UIColor *buttonColor;



/**
 *  button clicked block
 */
@property(nonatomic,copy)void(^buttonClickBlock)(void);

@property (nonatomic,assign)CGFloat titleFontSize;


@end
