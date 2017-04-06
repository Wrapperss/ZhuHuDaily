//
//  ZhuHuNavigationController.m
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/24.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import "ZhuHuNavigationController.h"

@interface ZhuHuNavigationController ()

@end

@implementation ZhuHuNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count == 0) {
        [super pushViewController:viewController animated:animated];
        self.navigationBar.hidden = NO;
        //self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
        return;
    }
    [super pushViewController:viewController animated:animated];
    self.navigationBar.hidden = YES;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if (self.viewControllers.count == 2) {
        self.navigationBar.hidden = NO;
    }
    return [super popViewControllerAnimated:animated];
}


@end
