//
//  ZYWMenuView.m
//  ZYWMenuController
//
//  Created by yearwen on 16/7/24.
//  Copyright © 2016年 yearwen. All rights reserved.
//

#import "ZYWMenuView.h"
#import "ZYWMenuButton.h"


#define SPACE 30 //按钮间距
#define EXTRAAREA 0
#define BUTTONHEIGHT 40 //按钮高度



#define SYS_DEVICE_WIDTH    ([[UIScreen mainScreen] bounds].size.width)                  // 屏幕宽度
#define SYS_DEVICE_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)                 // 屏幕长度


@interface ZYWMenuView()

@property (nonatomic,strong) CADisplayLink *displayLink;
@property  NSInteger animationCount; // 动画的数量

@property (nonatomic, assign) CGFloat curveX;               //做动画标记的view的X坐标
@property (nonatomic, assign) CGFloat curveY;              //做动画标记的view的Y坐标
@property (nonatomic, strong) UIView *curveView;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign)BOOL isOpeningMenu;



@end



@implementation ZYWMenuView{
    
    UIView *helperCenterView;
    UIView *helperSideView;
    UIVisualEffectView *blurView;
    UIWindow *keyWindow;
    BOOL triggered;
    CGFloat diff;
    UIColor *_menuColor;
}


static NSString *kX = @"curveX";
static NSString *kY = @"curveY";

-(id)initWithTitles:(NSArray *)titles{
    
    return [self initWithTitles:titles withButtonHeight:40.0f withMenuColor: [UIColor colorWithRed:57/255.0 green:67/255.0 blue:89/255.0 alpha:1.0] withBackBlurStyle:UIBlurEffectStyleDark];
}


-(id)initWithTitles:(NSArray *)titles withButtonHeight:(CGFloat)height withMenuColor:(UIColor *)menuColor withBackBlurStyle:(UIBlurEffectStyle)style{
    
    self = [super init];
    if (self) {
        
        keyWindow = [[UIApplication sharedApplication].windows lastObject];
        
        [self addObserver:self forKeyPath:kX options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:kY options:NSKeyValueObservingOptionNew context:nil];
        [self configShapeLayer];
        [self configCurveView];
        [self configAction];
        
        
        blurView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:style]];
        blurView.frame = keyWindow.frame;
        blurView.alpha = 0.0f;
        
        helperSideView = [[UIView alloc]initWithFrame:CGRectMake(-40, 0, 40, 40)];
        helperSideView.backgroundColor = [UIColor redColor];
        helperSideView.hidden = YES;
        [keyWindow addSubview:helperSideView];
        
        helperCenterView = [[UIView alloc]initWithFrame:CGRectMake(-40, CGRectGetHeight(keyWindow.frame)/2 - 20, 40, 40)];
        helperCenterView.backgroundColor = [UIColor yellowColor];
        helperCenterView.hidden = YES;
        [keyWindow addSubview:helperCenterView];
        
        
        self.frame = CGRectMake(- keyWindow.frame.size.width/2 - EXTRAAREA, 0, keyWindow.frame.size.width/2+EXTRAAREA, keyWindow.frame.size.height);
        self.backgroundColor = [UIColor clearColor];
        [keyWindow insertSubview:self belowSubview:helperSideView];
        
        _menuColor = menuColor;
        self.menuButtonHeight = height;
        [self addButtons:titles];
        
        
        
    }
    
    return self;
}


- (void)dealloc {
    [self removeObserver:self forKeyPath:kX];
    [self removeObserver:self forKeyPath:kY];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kX] || [keyPath isEqualToString:kY]) {
        
        [self updateShapeLayerPath];
    }
}



- (void)configAction
{
    _isAnimating = NO;                    // 是否处于动效状态
    _isOpeningMenu = NO;            //是否处于菜单栏打开过程状态
    
    
    // 手势
    UIScreenEdgePanGestureRecognizer * span = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanAction:)];
    span.edges = UIRectEdgeLeft;
    [keyWindow addGestureRecognizer:span];
}

- (void)configShapeLayer
{
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = [UIColor colorWithRed:57/255.0 green:67/255.0 blue:89/255.0 alpha:1.0].CGColor;
    [keyWindow.layer addSublayer:_shapeLayer];
}

- (void)configCurveView
{
    _curveView = [[UIView alloc] initWithFrame:CGRectMake(0 , SYS_DEVICE_HEIGHT/2, 3, 3)];
    _curveView.backgroundColor = [UIColor clearColor];
    [keyWindow addSubview:_curveView];
}

#pragma mark -
#pragma mark - Action

- (void)handlePanAction:(UIPanGestureRecognizer *)pan
{
    
    if(!_isAnimating)
    {
        if(pan.state == UIGestureRecognizerStateChanged)
        {
            // 手势移动时，_shapeLayer跟着手势向下扩大区域
            CGPoint point = [pan translationInView:self];
            // 这部分代码使r5红点跟着手势走
            self.curveX = point.x;
            self.curveY =SYS_DEVICE_HEIGHT/2;
            _curveView.frame = CGRectMake(_curveX,
                                          _curveY,
                                          _curveView.frame.size.width,
                                          _curveView.frame.size.height);
            
            if (point.x > 150.0f && !_isOpeningMenu) {
                [self trigger];
                _isOpeningMenu = YES;
            }
            
        }else if (pan.state == UIGestureRecognizerStateCancelled ||
                  pan.state == UIGestureRecognizerStateEnded ||
                  pan.state == UIGestureRecognizerStateFailed)
        {
            // 手势结束时,_shapeLayer返回原状并产生弹簧动效
            _isAnimating = YES;
            [self showAnimation];
        }
    }
}


-(void)showAnimation{
    // 弹簧动效
    [self beganAimation];
    [UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         // 曲线点(r5点)是一个view.所以在block中有弹簧效果.然后根据他的动效路径,在calculatePath中计算弹性图形的形状
                         _curveView.frame = CGRectMake(0, SYS_DEVICE_HEIGHT/2, 3, 3);
                     } completion:^(BOOL finished) {
                         
                         if(finished)
                         {
                             _isAnimating = NO;
                             _isOpeningMenu = NO;
                             [self endAnimation];
                         }
                     }];
}



-(void)beganAimation{
    
    // CADisplayLink默认每秒运行60次calculatePath是算出在运行期间_curveView的坐标，从而确定_shapeLayer的形状
    if ( self.displayLink == nil) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculatePath)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    self.animationCount ++;
}

-(void)endAnimation{
    self.animationCount --;
    if (self.animationCount ==0) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}


- (void)updateShapeLayerPath
{
    // 更新_shapeLayer形状
    UIBezierPath *tPath = [UIBezierPath bezierPath];

    [tPath moveToPoint:CGPointMake(0, 0)];                             
    [tPath addLineToPoint:CGPointMake(0, SYS_DEVICE_HEIGHT)];
    [tPath addQuadCurveToPoint:CGPointMake(0, 0)
                  controlPoint:CGPointMake(_curveX, _curveY)]; // r3,r4,r5确定的一个弧线
    [tPath closePath];
    _shapeLayer.path = tPath.CGPath;
}


- (void)calculatePath
{
    // 由于手势结束时,r5执行了一个UIView的弹簧动画,把这个过程的坐标记录下来,并相应的画出_shapeLayer形状
    CALayer *layer = _curveView.layer.presentationLayer;
    self.curveX = layer.position.x;
    self.curveY = layer.position.y;
}


-(void)addButtons:(NSArray *)titles{
    
    
    
    if (titles.count % 2 == 0) {
        
        NSInteger index_down = titles.count/2;
        NSInteger index_up = -1;
        for (NSInteger i = 0; i < titles.count; i++) {
            
            
            NSString *title = titles[i];
            ZYWMenuButton *home_button = [[ZYWMenuButton alloc]initWithTitle:title];
            if (i >= titles.count / 2) {
                
                index_up ++;
                home_button.center = CGPointMake(keyWindow.frame.size.width/4, keyWindow.frame.size.height/2 + self.menuButtonHeight*index_up + SPACE*index_up + SPACE/2 + self.menuButtonHeight/2);
            }else{
                
                index_down --;
                home_button.center = CGPointMake(keyWindow.frame.size.width/4, keyWindow.frame.size.height/2 - self.menuButtonHeight*index_down - SPACE*index_down - SPACE/2 - self.menuButtonHeight/2);
            }
            
            home_button.bounds = CGRectMake(0, 0, keyWindow.frame.size.width/2 - 20*2, self.menuButtonHeight);
            home_button.buttonColor = _menuColor;
            [self addSubview:home_button];
            
            __weak typeof(self) WeakSelf = self;
            
            home_button.buttonClickBlock = ^(){
                
                [WeakSelf tapToUntrigger:nil];
                WeakSelf.menuClickBlock(i,title,titles.count);
            };
            
        }
    }else{
        
        NSInteger index = (titles.count - 1) /2 +1;
        for (NSInteger i = 0; i < titles.count; i++) {
            
            index --;
            NSString *title = titles[i];
            ZYWMenuButton *home_button = [[ZYWMenuButton alloc]initWithTitle:title];
            home_button.center = CGPointMake(keyWindow.frame.size.width/4, keyWindow.frame.size.height/2 - self.menuButtonHeight*index - 20*index);
            home_button.bounds = CGRectMake(0, 0, keyWindow.frame.size.width/2 - 20*2, self.menuButtonHeight);
            home_button.buttonColor = _menuColor;
            [self addSubview:home_button];
            
            __weak typeof(self) WeakSelf = self;
            home_button.buttonClickBlock = ^(){
                
                [WeakSelf tapToUntrigger:nil];
                WeakSelf.menuClickBlock(i,title,titles.count);
            };
            
        }
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width-EXTRAAREA, 0)];
    
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width-EXTRAAREA, self.frame.size.height) controlPoint:CGPointMake(keyWindow.frame.size.width/2+diff, keyWindow.frame.size.height/2)];
    
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path closePath];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [_menuColor set];
    CGContextFillPath(context);
    

    [self updateShapeLayerPath];
    [self calculatePath];
    
}



-(void)trigger{
    
    if (!triggered) {
        
        [keyWindow insertSubview:blurView belowSubview:self];
        [UIView animateWithDuration:0.3 animations:^{
            
            self.frame = self.bounds;
            
        }];
        
        [self beforeAnimation];
        [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:0.9f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
            
            helperSideView.center = CGPointMake(keyWindow.center.x, helperSideView.frame.size.height/2);
            
        } completion:^(BOOL finished) {
            [self finishAnimation];
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            blurView.alpha = 0.6f;
            
        }];
        
        
        [self beforeAnimation];
        [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.8f initialSpringVelocity:2.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
            
            helperCenterView.center = keyWindow.center;
            
        } completion:^(BOOL finished) {
            if (finished) {
                UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToUntrigger:)];
                [blurView addGestureRecognizer:tapGes];
                
                [self finishAnimation];
            }
        }];
        
        [self animateButtons];
        
        triggered = YES;
        
    }else{
        [self tapToUntrigger:nil];
    }
    
}


-(void)animateButtons{
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        
        UIView *menuButton = self.subviews[i];
        menuButton.transform = CGAffineTransformMakeTranslation(-90, 0);
        
        [UIView animateWithDuration:0.7 delay:i*(0.3/self.subviews.count) usingSpringWithDamping:0.6f initialSpringVelocity:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
            
            menuButton.transform =  CGAffineTransformIdentity;
            _isOpeningMenu = NO;
        } completion:^(BOOL finished) {
        }];
        
    }
}


-(void)tapToUntrigger:(UIButton *)sender{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame = CGRectMake(-keyWindow.frame.size.width/2-EXTRAAREA, 0, keyWindow.frame.size.width/2+EXTRAAREA, keyWindow.frame.size.height);
    }];
    
    [self beforeAnimation];
    [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:0.9f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        
        helperSideView.center = CGPointMake(-helperSideView.frame.size.height/2, helperSideView.frame.size.height/2);
        
    } completion:^(BOOL finished) {
        [self finishAnimation];
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        blurView.alpha = 0.0f;
        
    }];
    
    [self beforeAnimation];
    [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:2.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        
        helperCenterView.center = CGPointMake(-helperSideView.frame.size.height/2, CGRectGetHeight(keyWindow.frame)/2);
        
    } completion:^(BOOL finished) {
        [self finishAnimation];
    }];
    //    [self showAnimation];
    _curveView.frame = CGRectMake(0, SYS_DEVICE_HEIGHT/2, 3, 3);
    [self updateShapeLayerPath];
    [self calculatePath];
    triggered = NO;
    
}



//动画之前调用
-(void)beforeAnimation{
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    self.animationCount ++;
}

//动画完成之后调用
-(void)finishAnimation{
    self.animationCount --;
    if (self.animationCount == 0) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

-(void)displayLinkAction:(CADisplayLink *)dis{
    
    CALayer *sideHelperPresentationLayer   =  (CALayer *)[helperSideView.layer presentationLayer];
    CALayer *centerHelperPresentationLayer =  (CALayer *)[helperCenterView.layer presentationLayer];
    
    CGRect centerRect = [[centerHelperPresentationLayer valueForKeyPath:@"frame"]CGRectValue];
    CGRect sideRect = [[sideHelperPresentationLayer valueForKeyPath:@"frame"]CGRectValue];
    diff = sideRect.origin.x - centerRect.origin.x;
    [self setNeedsDisplay];
    
}


@end
