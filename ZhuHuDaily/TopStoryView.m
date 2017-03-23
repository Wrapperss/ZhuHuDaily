//
//  TopStoryView.m
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/23.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import "TopStoryView.h"

@interface TopStoryView ()<UIScrollViewDelegate>

@end

@implementation TopStoryView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setScrollview];
        [self setPageControl];
        [self startTimer];
    }
    return self;
}

- (void)setScrollview {
    self.topScrollView.frame = self.bounds;
    _topScrollView.delegate = self;
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * _topScrollView.frame.size.width, 0, _topScrollView.frame.size.width, _topScrollView.frame.size.height)];
        imageView.image = [UIImage imageNamed:@"SliderTest"];
        [_topScrollView addSubview:imageView];
    }
    _topScrollView.contentSize = CGSizeMake(5 * _topScrollView.frame.size.width, 0);
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.pagingEnabled = YES;
    [self addSubview:_topScrollView];
}

- (void)setPageControl {
    self.topPageControl.numberOfPages = 5;
    _topPageControl.currentPage = 0;
    _topPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _topPageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _topPageControl.userInteractionEnabled = NO;
    [self addSubview:_topPageControl];
    [_topPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).with.inset(-5);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

- (void)startTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changePage) userInfo:nil repeats:YES];
    NSRunLoop *mainLoop = [NSRunLoop mainRunLoop];
    [mainLoop addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)changePage {
    NSInteger currentPage = _topPageControl.currentPage;
    CGPoint offset = _topScrollView.contentOffset;
    if (currentPage >= _topPageControl.numberOfPages - 1) {
        
        currentPage = 0;
        offset = CGPointZero;
    } else {
        currentPage++;
        offset.x += _topScrollView.frame.size.width;
    }
    
    _topPageControl.currentPage = currentPage;
    
    [_topScrollView setContentOffset:offset animated:YES];
}
#pragma mark - LazyLoad
- (UIScrollView *)topScrollView {
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc] init];
    }
    return _topScrollView;
}

- (UIPageControl *)topPageControl {
    if (!_topPageControl) {
        _topPageControl = [[UIPageControl alloc] init];
    }
    return _topPageControl;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    _topPageControl.currentPage = currentPage;
}
@end
