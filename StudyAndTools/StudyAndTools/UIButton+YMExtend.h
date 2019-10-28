//
//  UIButton+YMExtend.h
//  StudyAndTools
//
//  Created by SL设计 on 2019/10/28.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (YMExtend)

// 防止按钮在同一时间段重复点击，设置一个延迟时间
- (void)enableDelayTime:(CGFloat)delayTime;

@end

NS_ASSUME_NONNULL_END
