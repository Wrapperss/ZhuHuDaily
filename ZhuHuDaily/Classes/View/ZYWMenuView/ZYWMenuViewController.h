//
//  ZYWMenuViewController.h
//  ZYWMenuController
//
//  Created by yearwen on 16/7/24.
//  Copyright © 2016年 yearwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYWMenuViewController : UIViewController
@property (nonatomic ,strong)UIViewController * frontView;
@property (nonatomic ,strong)NSArray * buttonTitles;
@property (nonatomic ,strong)UIView * frontViewContainer;
@property (nonatomic ,strong)NSArray <UIViewController *> * viewControllersArr;



-(instancetype)initWithFrontView:(UIViewController *)frontView AndButtonTitleArr:(NSArray *)titleArr;

-(void)setFrontView:(UIViewController *)frontView;

@end
