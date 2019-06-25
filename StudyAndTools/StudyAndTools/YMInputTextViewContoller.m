//
//  YMInputTextViewContoller.m
//  StudyAndTools
//
//  Created by SL设计 on 2019/6/25.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "YMInputTextViewContoller.h"
#import "YMInputTextView.h"

@interface YMInputTextViewContoller ()

@end

@implementation YMInputTextViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.frame = CGRectMake(50, 20, 100, 44);
    [firstBtn setTitle:@"测试按钮" forState:UIControlStateNormal];
    firstBtn.backgroundColor = [UIColor orangeColor];
    [firstBtn addTarget:self action:@selector(firstButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstBtn];
}

- (void)firstButtonClicked:(UIButton *)sender {
    
    YMInputTextView *textView = [YMInputTextView createInputTextView];
    [textView show];
}

@end
