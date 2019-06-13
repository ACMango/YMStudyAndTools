//
//  StudyController.m
//  StudyAndTools
//
//  Created by SL设计 on 2019/6/13.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "StudyController.h"

@interface StudyController ()

@end

@implementation StudyController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"学习列表";
    
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObject:@"YMToolsVC"]; // 工具展示类
    [self.dataArray addObject:@"HitTestVC"]; // 事件响应链
    [self.dataArray addObject:@"XibViewController"]; // Xib
    
    [self.tableView reloadData];
}

@end
