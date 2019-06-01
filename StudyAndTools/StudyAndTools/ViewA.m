//
//  ViewA.m
//  StudyAndTools
//
//  Created by 郭炎明 on 2019/6/1.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "ViewA.h"

@implementation ViewA

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    NSLog(@"进入 %@--%@---", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"离开 %@--%@---%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), view);
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    NSLog(@"%@--- pointInside withEvent ---", NSStringFromClass([self class]));
    BOOL isInside = [super pointInside:point withEvent:event];
    NSLog(@"%@--- pointInside withEvent --- isInside:%d", NSStringFromClass([self class]), isInside);
    return isInside;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@_touchesBegan", NSStringFromClass([self class]));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"%@_touchesEnded", NSStringFromClass([self class]));
}

@end
