//
//  ZYWMenuButton.m
//  ZYWMenuController
//
//  Created by yearwen on 16/7/24.
//  Copyright © 2016年 yearwen. All rights reserved.
//

#import "ZYWMenuButton.h"

@interface ZYWMenuButton()

@property(nonatomic,strong)NSString *buttonTitle;

@end



@implementation ZYWMenuButton


-(id)initWithTitle:(NSString *)title{
    
    self = [super init];
    if (self) {
        
        self.buttonTitle = title;
        
    }
    return self;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, rect);
    [self.buttonColor set];
    CGContextFillPath(context);
    
    
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 1, 1) cornerRadius: rect.size.height/2];
    [self.buttonColor setFill];
    [roundedRectanglePath fill];
    [[UIColor whiteColor] setStroke];
    roundedRectanglePath.lineWidth = 1;
    [roundedRectanglePath stroke];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    
    
    NSDictionary *attr = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:_titleFontSize ? _titleFontSize : 18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    CGSize size = [self.buttonTitle sizeWithAttributes:attr];
    
    CGRect r = CGRectMake(rect.origin.x,
                          rect.origin.y + (rect.size.height - size.height)/2.0,
                          rect.size.width,
                          size.height);
    
    [self.buttonTitle drawInRect:r withAttributes:attr];
    
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSUInteger tapCount = touch.tapCount;
    
    
    switch (tapCount) {
        case 1:
            self.buttonClickBlock();
            break;
            
        default:
            break;
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
