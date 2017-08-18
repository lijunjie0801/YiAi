//
//  ServiceViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/13.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "ServiceViewController.h"
#import "ServiceIngViewController.h"
#import "ServiceFinshViewController.h"
#import "SegmentView.h"

@interface ServiceViewController ()

@end

@implementation ServiceViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _serviceBtn.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    _serviceBtn.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"任务书";
    
    
    ServiceIngViewController *untreatedVC = [[ServiceIngViewController alloc] init];
    ServiceFinshViewController   *distorVc    = [[ServiceFinshViewController alloc] init];
    
    NSArray *controllers = @[untreatedVC,distorVc];
    NSArray *titleArrays = @[@"进行中",@"已完成"];
    
    SegmentView *segment = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) controllers:controllers titleArray:titleArrays ParentController:self];
    
    [self.view addSubview:segment];
    
    
    _serviceBtn = [[UIButton alloc] init];
    [_serviceBtn setBackgroundImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    _serviceBtn.frame =CGRectMake(WIDTH-[MyAdapter aDapter:30]-[MyAdapter aDapter:77], HEIGHT-[MyAdapter aDapter:160], [MyAdapter aDapter:77], [MyAdapter aDapter:77]);
    [_serviceBtn addTarget:self action:@selector(serviceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [[UIApplication sharedApplication].keyWindow addSubview:_publishBtn];
    [self.view addSubview:_serviceBtn];
    
    
}



//维修点击事件
-(void)serviceBtnClick
{
    [_svc pushViewController:_svc.pushServiceViewController];
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
