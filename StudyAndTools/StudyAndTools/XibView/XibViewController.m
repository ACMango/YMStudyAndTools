//
//  XibViewController.m
//  StudyAndTools
//
//  Created by 郭炎明 on 2019/6/2.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "XibViewController.h"
#import "XibBottomView.h"

@interface XibViewController ()

@end

@implementation XibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XibBottomView *bottomView = [[XibBottomView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 300)];
    [self.view addSubview:bottomView];
}


@end
