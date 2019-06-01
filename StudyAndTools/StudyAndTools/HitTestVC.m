//
//  HitTestVC.m
//  StudyAndTools
//
//  Created by SL设计 on 2019/5/28.
//  Copyright © 2019 SL设计. All rights reserved.
//

#import "HitTestVC.h"
#import "ViewA.h"
#import "ViewB.h"
#import "ViewC.h"
#import "ViewD.h"

@interface HitTestVC ()
@property (weak, nonatomic) IBOutlet ViewA *viewA;
@property (weak, nonatomic) IBOutlet ViewB *viewB;
@property (weak, nonatomic) IBOutlet ViewC *viewV;
@property (weak, nonatomic) IBOutlet ViewD *viewD;

@end

@implementation HitTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    _viewB.userInteractionEnabled = NO;
    
    UITapGestureRecognizer *tapA = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapA:)];
    [_viewA addGestureRecognizer:tapA];
    
    UITapGestureRecognizer *tapB = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapB:)];
    [_viewB addGestureRecognizer:tapB];
    
    UITapGestureRecognizer *tapD = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapD:)];
    [_viewD addGestureRecognizer:tapD];
    
}

- (void)tapA:(UITapGestureRecognizer *)gesture {
    NSLog(@"点击了A视图");
}

- (void)tapB:(UITapGestureRecognizer *)gesture {
    NSLog(@"点击了B视图");
}

- (void)tapD:(UITapGestureRecognizer *)gesture {
    NSLog(@"点击D视图");
    
}

/* 点击ViewD 时的log（所有view的userInteraction = yes）
 
 2019-06-01 16:05:22.478839+0800 StudyAndTools[2432:90795] 进入 ViewA--hitTest:withEvent:---
 2019-06-01 16:05:22.479226+0800 StudyAndTools[2432:90795] ViewA--- pointInside withEvent ---
 2019-06-01 16:05:22.479417+0800 StudyAndTools[2432:90795] ViewA--- pointInside withEvent --- isInside:1
 2019-06-01 16:05:22.479649+0800 StudyAndTools[2432:90795] 进入 ViewB--hitTest:withEvent:---
 2019-06-01 16:05:22.479852+0800 StudyAndTools[2432:90795] ViewB--- pointInside withEvent ---
 2019-06-01 16:05:22.480038+0800 StudyAndTools[2432:90795] ViewB--- pointInside withEvent --- isInside:1
 2019-06-01 16:05:22.480286+0800 StudyAndTools[2432:90795] 进入 ViewD--hitTest:withEvent:---
 2019-06-01 16:05:22.480494+0800 StudyAndTools[2432:90795] ViewD--- pointInside withEvent ---
 2019-06-01 16:05:22.480727+0800 StudyAndTools[2432:90795] ViewD--- pointInside withEvent --- isInside:1
 2019-06-01 16:05:22.482167+0800 StudyAndTools[2432:90795] 离开 ViewD--hitTest:withEvent:---<ViewD: 0x7fdbf0726710; frame = (260 15; 100 157.667); autoresize = RM+BM; gestureRecognizers = <NSArray: 0x600000bf31e0>; layer = <CALayer: 0x6000005ed940>>
 2019-06-01 16:05:22.483244+0800 StudyAndTools[2432:90795] 离开 ViewB--hitTest:withEvent:---<ViewD: 0x7fdbf0726710; frame = (260 15; 100 157.667); autoresize = RM+BM; gestureRecognizers = <NSArray: 0x600000bf31e0>; layer = <CALayer: 0x6000005ed940>>
 2019-06-01 16:05:22.483804+0800 StudyAndTools[2432:90795] 离开 ViewA--hitTest:withEvent:---<ViewD: 0x7fdbf0726710; frame = (260 15; 100 157.667); autoresize = RM+BM; gestureRecognizers = <NSArray: 0x600000bf31e0>; layer = <CALayer: 0x6000005ed940>>
 2019-06-01 16:05:22.489916+0800 StudyAndTools[2432:90795] 进入 ViewA--hitTest:withEvent:---
 2019-06-01 16:05:22.490063+0800 StudyAndTools[2432:90795] ViewA--- pointInside withEvent ---
 2019-06-01 16:05:22.490181+0800 StudyAndTools[2432:90795] ViewA--- pointInside withEvent --- isInside:1
 2019-06-01 16:05:22.490298+0800 StudyAndTools[2432:90795] 进入 ViewB--hitTest:withEvent:---
 2019-06-01 16:05:22.490431+0800 StudyAndTools[2432:90795] ViewB--- pointInside withEvent ---
 2019-06-01 16:05:22.490553+0800 StudyAndTools[2432:90795] ViewB--- pointInside withEvent --- isInside:1
 2019-06-01 16:05:22.490671+0800 StudyAndTools[2432:90795] 进入 ViewD--hitTest:withEvent:---
 2019-06-01 16:05:22.490775+0800 StudyAndTools[2432:90795] ViewD--- pointInside withEvent ---
 2019-06-01 16:05:22.490974+0800 StudyAndTools[2432:90795] ViewD--- pointInside withEvent --- isInside:1
 2019-06-01 16:05:22.491280+0800 StudyAndTools[2432:90795] 离开 ViewD--hitTest:withEvent:---<ViewD: 0x7fdbf0726710; frame = (260 15; 100 157.667); autoresize = RM+BM; gestureRecognizers = <NSArray: 0x600000bf31e0>; layer = <CALayer: 0x6000005ed940>>
 2019-06-01 16:05:22.491543+0800 StudyAndTools[2432:90795] 离开 ViewB--hitTest:withEvent:---<ViewD: 0x7fdbf0726710; frame = (260 15; 100 157.667); autoresize = RM+BM; gestureRecognizers = <NSArray: 0x600000bf31e0>; layer = <CALayer: 0x6000005ed940>>
 2019-06-01 16:05:22.491848+0800 StudyAndTools[2432:90795] 离开 ViewA--hitTest:withEvent:---<ViewD: 0x7fdbf0726710; frame = (260 15; 100 157.667); autoresize = RM+BM; gestureRecognizers = <NSArray: 0x600000bf31e0>; layer = <CALayer: 0x6000005ed940>>
 2019-06-01 16:05:22.492960+0800 StudyAndTools[2432:90795] ViewD_touchesBegan
 2019-06-01 16:05:22.581827+0800 StudyAndTools[2432:90795] 点击了D视图


*/

/* 点击ViewD ,然后 viewB的userIneraction = NO;
 
 2019-06-01 15:58:23.430353+0800 StudyAndTools[2346:86416] 进入 ViewA--hitTest:withEvent:---
 2019-06-01 15:58:23.430749+0800 StudyAndTools[2346:86416] ViewA--- pointInside withEvent ---
 2019-06-01 15:58:23.430964+0800 StudyAndTools[2346:86416] ViewA--- pointInside withEvent --- isInside:1
 2019-06-01 15:58:23.431182+0800 StudyAndTools[2346:86416] 进入 ViewB--hitTest:withEvent:---
 2019-06-01 15:58:23.431439+0800 StudyAndTools[2346:86416] 离开 ViewB--hitTest:withEvent:---(null)
 2019-06-01 15:58:23.432732+0800 StudyAndTools[2346:86416] 离开 ViewA--hitTest:withEvent:---<ViewA: 0x7fc61ac15d20; frame = (0 218.667; 375 375); autoresize = RM+BM; gestureRecognizers = <NSArray: 0x600001bb6580>; layer = <CALayer: 0x6000015cf420>>
 2019-06-01 15:58:23.433212+0800 StudyAndTools[2346:86416] 进入 ViewA--hitTest:withEvent:---
 2019-06-01 15:58:23.433378+0800 StudyAndTools[2346:86416] ViewA--- pointInside withEvent ---
 2019-06-01 15:58:23.433516+0800 StudyAndTools[2346:86416] ViewA--- pointInside withEvent --- isInside:1
 2019-06-01 15:58:23.433992+0800 StudyAndTools[2346:86416] 进入 ViewB--hitTest:withEvent:---
 2019-06-01 15:58:23.434450+0800 StudyAndTools[2346:86416] 离开 ViewB--hitTest:withEvent:---(null)
 2019-06-01 15:58:23.434999+0800 StudyAndTools[2346:86416] 离开 ViewA--hitTest:withEvent:---<ViewA: 0x7fc61ac15d20; frame = (0 218.667; 375 375); autoresize = RM+BM; gestureRecognizers = <NSArray: 0x600001bb6580>; layer = <CALayer: 0x6000015cf420>>
 2019-06-01 15:58:23.441521+0800 StudyAndTools[2346:86416] ViewA_touchesBegan
 2019-06-01 15:58:23.502199+0800 StudyAndTools[2346:86416] 点击了A视图

 */

@end
