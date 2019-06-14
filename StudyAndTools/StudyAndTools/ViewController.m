//
//  ViewController.m
//  StudyAndTools
//
//  Created by SL设计 on 2019/5/28.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 55.0;
    [self.view addSubview:_tableView];
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
    
    NSString *controllerName = _dataArray[indexPath.row];
    id nextController = nil;
    
    if ([controllerName hasPrefix:@"SB"]) {
        
        NSArray *componentsArr = [controllerName componentsSeparatedByString:@"_"];
        if (componentsArr.count == 2) {
            controllerName = componentsArr[1];
            UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            nextController = [mainSB instantiateViewControllerWithIdentifier:controllerName];
        }
    } else { // 普通ViewController
        
        nextController = [[NSClassFromString(controllerName) alloc] init];
    }
    
    if ([nextController isKindOfClass:[UIViewController class]]) {
        
        UIViewController *nextPushVC = (UIViewController *)nextController;
        nextPushVC.title = controllerName;
        nextPushVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:nextController animated:YES];
    }
}

@end
