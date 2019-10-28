//
//  UIButton+YMExtend.m
//  StudyAndTools
//
//  Created by SL设计 on 2019/10/28.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "UIButton+YMExtend.h"

@implementation UIButton (YMExtend)

- (void)enableDelayTime:(CGFloat)delayTime {
    
    __weak typeof(self) weakSelf = self;
    self.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.enabled = YES;
    });
}

@end
