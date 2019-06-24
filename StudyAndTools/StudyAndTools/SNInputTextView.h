//
//  SNInputTextView.h
//  SonyApp
//
//  Created by SL设计 on 2019/6/24.
//  Copyright © 2019 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PublishBlock)(NSString *text);

@interface SNInputTextView : UIView

@property (assign, nonatomic) NSInteger maxLength;
@property (copy, nonatomic) PublishBlock publishBlock;


-(void)show;

@end

NS_ASSUME_NONNULL_END
