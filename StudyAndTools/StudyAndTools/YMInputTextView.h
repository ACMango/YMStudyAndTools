//
//  YMInputTextView.h
//  StudyAndTools
//
//  Created by SL设计 on 2019/6/25.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMInputTextView : UIView

@property (assign, nonatomic) NSUInteger maxLength; // 默认为100

+ (instancetype)createInputTextView;
- (void)show;

@end

NS_ASSUME_NONNULL_END
