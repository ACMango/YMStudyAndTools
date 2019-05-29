//
//  ViewController.m
//  StudyAndTools
//
//  Created by SL设计 on 2019/5/28.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - tableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"ViewControllerId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id nextController = [[NSClassFromString(_dataArray[indexPath.row]) alloc] init];
    if ([nextController isKindOfClass:[UIViewController class]]) {
        
        UIViewController *nextPushVC = (UIViewController *)nextController;
        nextPushVC.title = self.dataArray[indexPath.row];
        nextPushVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:nextController animated:YES];
    }
}

#pragma mark - getter
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:@"YMToolsVC"]; // 工具展示类
        [_dataArray addObject:@"HitTestVC"]; // 事件响应链
    }
    return _dataArray;
}

@end
