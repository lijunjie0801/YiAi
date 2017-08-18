//
//  TaskBookViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/12.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "TaskBookViewController.h"
#import "TaskBookIngViewController.h"
#import "TaskBookFinishViewController.h"
#import "SegmentView.h"

@interface TaskBookViewController ()

@end

@implementation TaskBookViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _publishBtn.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    _publishBtn.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"任务书";
    
    
    TaskBookIngViewController  *untreatedVC = [[TaskBookIngViewController alloc] init];
    TaskBookFinishViewController   *distorVc    = [[TaskBookFinishViewController alloc] init];
    
    NSArray *controllers = @[untreatedVC,distorVc];
    NSArray *titleArrays = @[@"进行中",@"已完成"];
    
    SegmentView *segment = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) controllers:controllers titleArray:titleArrays ParentController:self];
    
    [self.view addSubview:segment];
    
    
    _publishBtn = [[UIButton alloc] init];
    [_publishBtn setBackgroundImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    _publishBtn.frame =CGRectMake(WIDTH-[MyAdapter aDapter:30]-[MyAdapter aDapter:77], HEIGHT-[MyAdapter aDapter:160], [MyAdapter aDapter:77], [MyAdapter aDapter:77]);
    [_publishBtn addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [[UIApplication sharedApplication].keyWindow addSubview:_publishBtn];
    [self.view addSubview:_publishBtn];
    
}




//发布按钮的点击事件
-(void)publishBtnClick
{
    
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
