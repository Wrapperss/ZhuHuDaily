//
//  StoryViewController.m
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/24.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import "StoryViewController.h"
#import "StoryCoverView.h"

@interface StoryViewController ()

@end

@implementation StoryViewController


- (instancetype)initWithStoryId:(NSString *)storyId {
    self = [super init];
    self.storyId = storyId;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self loadStoryMessage];
    [self setUpStoryWebView];
    //[self setFakeNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - loadMessage
- (void)loadStoryMessage {
    NSString *OneStoryDeltailUrl = [OneStoryDeltailApi stringByAppendingString:self.storyId];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"加载中～"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [[NetworkTool sharedNetworkTool] loadDataInfo:OneStoryDeltailUrl parameters:nil success:^(id  _Nullable responseObject) {
        self.storyDetail = [StoryDetailModel mj_objectWithKeyValues:responseObject];
        [self.storyWebView loadHTMLString:[NSString stringWithFormat:@"%@<link rel=\"stylesheet\" type=\"text/css\" href=\"%@\">", _storyDetail.body, _storyDetail.css[0]] baseURL:[NSURL URLWithString:_storyDetail.css[0]]];
        
        StoryCoverView *storyCover = [[StoryCoverView alloc] initWithFrame:CGRectMake(0, -25, AppWidth, 0.35 * AppHeight) StoryDetail:self.storyDetail];
        [self.storyWebView.scrollView addSubview:storyCover];
        [SVProgressHUD dismiss];
    } failure:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}
#pragma mark - Lazy 
- (UIWebView *)storyWebView {
    if (!_storyWebView) {
        _storyWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -25, AppWidth, AppHeight + 25)];
        _storyWebView.backgroundColor = [UIColor whiteColor];
    }
    return _storyWebView;
}

- (UIView *)fakeNavigationBar {
    if (!_fakeNavigationBar) {
        _fakeNavigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, 64)];
    }
    return _fakeNavigationBar;
}
#pragma mark - UI
- (void)setFakeNavigationBar {
    self.fakeNavigationBar.backgroundColor = ZhuHuColor;
    [self.view addSubview:_fakeNavigationBar];
    [self setBackButton];
}
- (void)setBackButton {
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 50, 30)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.tintColor = [UIColor whiteColor];
    [self.fakeNavigationBar addSubview:backButton];
}
- (void)backButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpStoryWebView {
    self.storyWebView.scalesPageToFit = NO;
    [self.view addSubview:self.storyWebView];
}


@end
