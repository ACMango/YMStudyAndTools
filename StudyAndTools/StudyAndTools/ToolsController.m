//
//  ToolsController.m
//  StudyAndTools
//
//  Created by SL设计 on 2019/6/13.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "ToolsController.h"

@interface ToolsController ()

@end

@implementation ToolsController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"工具列表";
    
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObject:@"SB_TFAccessoryController"];
    
    [self.tableView reloadData];
}


@end
