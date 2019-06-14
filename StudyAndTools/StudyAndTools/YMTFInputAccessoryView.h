//
//  YMTFInputAccessoryView.h
//  StudyAndTools
//
//  Created by SL设计 on 2019/6/13.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DoneBlock)(void);

@interface YMTFInputAccessoryView : UIView

@property (strong, nonatomic) UILabel *labCenter; // 中间的提示文字
@property (copy, nonatomic) DoneBlock doneBlock;

@end

NS_ASSUME_NONNULL_END
