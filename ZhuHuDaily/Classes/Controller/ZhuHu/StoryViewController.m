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
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBackAction:)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.storyWebView addGestureRecognizer:swipeGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - loadMessage
- (void)loadStoryMessage {
    YYCache *storyDetailCache = [YYCache cacheWithName:@"storyDetail"];
    NSString *OneStoryDeltailUrl = [OneStoryDeltailApi stringByAppendingString:self.storyId];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"加载中～"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    if ([storyDetailCache containsObjectForKey:self.storyId]) {
        self.storyDetail = (StoryDetailModel *)[storyDetailCache objectForKey:self.storyId];
        [self.storyWebView loadHTMLString:[NSString stringWithFormat:@"%@<link rel=\"stylesheet\" type=\"text/css\" href=\"%@\">", _storyDetail.body, _storyDetail.css[0]] baseURL:[NSURL URLWithString:_storyDetail.css[0]]];
        
        StoryCoverView *storyCover = [[StoryCoverView alloc] initWithFrame:CGRectMake(0, -25, AppWidth, 0.35 * AppHeight) StoryDetail:self.storyDetail];
        [self.storyWebView.scrollView addSubview:storyCover];
        [SVProgressHUD dismiss];
    }
    else {
        [[NetworkTool sharedNetworkTool] loadDataInfo:OneStoryDeltailUrl parameters:nil success:^(id  _Nullable responseObject) {
            self.storyDetail = [StoryDetailModel mj_objectWithKeyValues:responseObject];
            [self.storyWebView loadHTMLString:[NSString stringWithFormat:@"%@<link rel=\"stylesheet\" type=\"text/css\" href=\"%@\">", _storyDetail.body, _storyDetail.css[0]] baseURL:[NSURL URLWithString:_storyDetail.css[0]]];
            
            StoryCoverView *storyCover = [[StoryCoverView alloc] initWithFrame:CGRectMake(0, -25, AppWidth, 0.35 * AppHeight) StoryDetail:self.storyDetail];
            [self.storyWebView.scrollView addSubview:storyCover];
            [storyDetailCache setObject:self.storyDetail forKey:self.storyId];
            [SVProgressHUD dismiss];
        } failure:^(NSError * _Nullable error) {
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }];
    }
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
- (void)swipeBackAction:(UISwipeGestureRecognizer *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setUpStoryWebView {
    self.storyWebView.scalesPageToFit = NO;
    [self.view addSubview:self.storyWebView];
}


@end
