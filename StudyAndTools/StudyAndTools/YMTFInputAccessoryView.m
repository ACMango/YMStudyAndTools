//
//  YMTFInputAccessoryView.m
//  StudyAndTools
//
//  Created by SL设计 on 2019/6/13.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "YMTFInputAccessoryView.h"

static CGFloat const kAccessoryViewHeight = 44.0;

@implementation YMTFInputAccessoryView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        CGFloat btnWidth = 55.0;
        CGFloat margin = 10.0 + btnWidth;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, screenWidth, kAccessoryViewHeight);
        
        UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
        btnDone.frame = CGRectMake(screenWidth - margin, 0, btnWidth, kAccessoryViewHeight);
        [btnDone setTitle:@"完成" forState:UIControlStateNormal];
        btnDone.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [btnDone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnDone addTarget:self action:@selector(doneMethod:) forControlEvents:UIControlEventTouchUpInside];
        btnDone.backgroundColor = [UIColor whiteColor];
        [self addSubview:btnDone];
        
        UILabel *labInput = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, screenWidth-2*margin, kAccessoryViewHeight)];
        labInput.font = [UIFont systemFontOfSize:15.0];
        labInput.textColor = [UIColor blackColor];
        labInput.lineBreakMode = NSLineBreakByTruncatingHead;
        [self addSubview:labInput];
        labInput.textAlignment = NSTextAlignmentCenter;
        self.labCenter = labInput;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:(198.0/255.0) green:(201.0/255.0) blue:(208.0/255.0) alpha:1.0];
        [self addSubview:lineView];
    }
    return self;
}


- (void)doneMethod:(UIButton *)sender {
    
    if (_doneBlock) {
        _doneBlock();
    }
}

@end
