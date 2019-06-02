//
//  XibBottomView.m
//  StudyAndTools
//
//  Created by 郭炎明 on 2019/6/2.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "XibBottomView.h"

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
}

@end
