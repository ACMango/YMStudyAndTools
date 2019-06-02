//
//  ExtendBtn.m
//  StudyAndTools
//
//  Created by 郭炎明 on 2019/6/3.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "ExtendBtn.h"

@implementation ExtendBtn

// hit test知识
// 1：扩大button的反应区间
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {

    CGFloat margin = 30.0;
    CGRect btnFrame = CGRectMake(- margin, - margin, CGRectGetWidth(self.frame)+2*margin, CGRectGetHeight(self.frame)+2*margin);
    
//    NSLog(NSStringFromCGPoint(point));
//    NSLog(NSStringFromCGRect(btnFrame));
    
    BOOL isShow = CGRectContainsPoint(btnFrame, point);
    
    return isShow;
}



@end
