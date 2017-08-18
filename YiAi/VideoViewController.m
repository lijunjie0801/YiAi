//
//  VideoViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/14.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoControlViewController.h"
#import "VideoEscapeRouteViewController.h"
#import "VideoFireLaneViewController.h"
#import "SegmentView.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"视频";
    
    
    VideoControlViewController *untreatedVC = [[VideoControlViewController alloc] init];
    VideoEscapeRouteViewController   *distorVc    = [[VideoEscapeRouteViewController alloc] init];
    VideoFireLaneViewController      *trueVc      = [[VideoFireLaneViewController alloc] init];
    
    NSArray *controllers = @[untreatedVC,distorVc,trueVc];
    NSArray *titleArrays = @[@"控制器",@"疏散通道",@"消防车道"];
    
    SegmentView *segment = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) controllers:controllers titleArray:titleArrays ParentController:self];
    
    [self.view addSubview:segment];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
