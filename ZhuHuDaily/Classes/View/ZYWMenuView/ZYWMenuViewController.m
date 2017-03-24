//
//  ZYWMenuViewController.m
//  ZYWMenuController
//
//  Created by yearwen on 16/7/24.
//  Copyright © 2016年 yearwen. All rights reserved.
//

#import "ZYWMenuViewController.h"
#import "ZYWMenuView.h"


@interface ZYWMenuViewController ()
@property (nonatomic ,strong)ZYWMenuView * menuView;
@end

@implementation ZYWMenuViewController

-(instancetype)init{
    if (self = [super init]) {
        _frontViewContainer = [[UIView alloc] init];
    }
    return self;
}



-(instancetype)initWithFrontView:(UIViewController *)frontView AndButtonTitleArr:(NSArray *)titleArr{
    self = [self init];
    if (self) {
        _frontView = frontView;
        _buttonTitles = titleArr;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.frontViewContainer];
    [self creatMenuView];
    if (self.frontView) {
        [self setDefaultFrontView:self.frontView];
    }
}


-(void)setDefaultFrontView:(UIViewController *)frontView{
    self.frontViewContainer.frame = self.view.bounds;
    self.frontViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addChildViewController:self.frontView];
    self.frontView.view.frame = self.view.bounds;
    [self.frontViewContainer addSubview:self.frontView.view];
    [self.frontView didMoveToParentViewController:self];
}

-(void)changeViweControllerWithView:(UIViewController *)viewController{
    [self hideViewController:_frontView];
    _frontView = viewController;
    [self setDefaultFrontView:_frontView];
}

- (void)hideViewController:(UIViewController *)viewController
{
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}

-(void)creatMenuView{
    
    _menuView = [[ZYWMenuView alloc]initWithTitles:self.buttonTitles];
    __block typeof(self)  weakSelf = self;
    _menuView.menuClickBlock = ^(NSInteger index,NSString *title,NSInteger titleCounts){
        NSLog(@"index:%ld title:%@ titleCounts:%ld",index,title,titleCounts);
        if (weakSelf.viewControllersArr.count > 0) {
            [weakSelf changeViweControllerWithView:weakSelf.viewControllersArr[index]];
        }
    };
}


-(void)setFrontView:(UIViewController *)frontView{
    if (_frontView == frontView) {
        return;
    }
    [self setDefaultFrontView:frontView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
