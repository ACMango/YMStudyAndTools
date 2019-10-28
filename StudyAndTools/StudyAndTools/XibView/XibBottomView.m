//
//  XibBottomView.m
//  StudyAndTools
//
//  Created by 郭炎明 on 2019/6/2.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "XibBottomView.h"
#import "AButton.h"
#import "UIButton+YMExtend.h"

@implementation XibBottomView

/*
 1：xib 的size改为freedom
 2：使用下面的代码
 
 */

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        NSString *className = NSStringFromClass([self class]);
        self = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil].lastObject;
        self.frame = frame;
    }
    return self;
}
- (IBAction)centerBtnClicked:(UIButton *)sender {
    
    NSLog(@"CenterBtn Clicked");
    [sender enableDelayTime:1.2]; // y
}

- (IBAction)aViewClicked:(UIButton *)sender {
    
    NSLog(@"A_ViewClicked");
}

#pragma mark - events 传递
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
//    NSLog(@"self point:%@", NSStringFromCGPoint(point));
    CGPoint aBtnPoint = [self convertPoint:point toView:self.aBtn];
//    NSLog(@"AButton Point%@", NSStringFromCGPoint(aBtnPoint));
    
    if ([self.aBtn pointInside:aBtnPoint withEvent:event]) {
        return self.aBtn;
    }
    
    // Others
    UIView *hitView = [super hitTest:point withEvent:event];
//    NSLog(@"%@__%@", NSStringFromClass([self class]), hitView);
    return hitView;
}


@end
