//
//  MyWorkViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/12.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "MyWorkViewController.h"
#import "FireAlarmViewController.h"
#import "TaskBookViewController.h"
#import "ServiceViewController.h"
#import "TaskBookIngViewController.h"

@interface MyWorkViewController ()


@property(nonatomic, strong) UISegmentedControl *segment;

//火警
@property(nonatomic, strong) FireAlarmViewController *fireVc;

//任务书
@property(nonatomic, strong) TaskBookViewController *taskBookVc;

//维修
@property(nonatomic, strong) ServiceViewController *serviceVc;


@end

@implementation MyWorkViewController




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    
    if ( _segment.selectedSegmentIndex == 0) {
        
//        _fireVc.view.hidden = NO;
//        _taskBookVc.view.hidden = YES;
//        _serviceVc.view.hidden = YES;
        
        
        
        _taskBookVc.publishBtn.hidden = YES;
        _serviceVc.serviceBtn.hidden = YES;
        
    }else if (_segment.selectedSegmentIndex ==1){
        
//        _taskBookVc.view.hidden = NO;
//        _fireVc.view.hidden = YES;
//        _serviceVc.view.hidden = YES;
        
        _taskBookVc.publishBtn.hidden = NO;
        _serviceVc.serviceBtn.hidden = YES;
        
        
    }else{
        
//        _serviceVc.view.hidden = NO;
//        _fireVc.view.hidden = YES;
//        _taskBookVc.view.hidden = YES;
        
        _taskBookVc.publishBtn.hidden = YES;
        _serviceVc.serviceBtn.hidden = NO;
        
    }
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNavigation];
    
}




-(void)createNavigation
{
    UIView *navigatonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
        navigatonView.backgroundColor = [AppAppearance sharedAppearance].mainColor;
    [self.view addSubview:navigatonView];
    
    
    //左右导航按钮与searchbar
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(10, 22+(42-30)/2, [MyAdapter aDapter:50], 30);
    [leftbtn setImage:[UIImage imageNamed:@"item_back"] forState:UIControlStateNormal];
    [leftbtn setImage:[UIImage imageNamed:@"item_back"] forState:UIControlStateHighlighted];
    leftbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
//    leftbtn.imageEdgeInsets = UIEdgeInsetsMake(0, [MyAdapter aDapter:32], 0, -[MyAdapter aDapter:10]);
    [leftbtn setTitle:@"返回" forState:UIControlStateNormal];
    leftbtn.titleLabel.font = [MyAdapter fontADapter:16];
    [leftbtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [navigatonView addSubview:leftbtn];
    
    
    
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"火警",@"任务书",@"维修"]];
    _segment.frame = CGRectMake((WIDTH - [MyAdapter aDapter:180])/2,22+(42-[MyAdapter aDapter:32])/2,[MyAdapter aDapter:180],[MyAdapter aDapter:32]);
    //    segment.backgroundColor = [AppAppearance sharedAppearance].redColor;
        _segment.tintColor = [AppAppearance sharedAppearance].whiteColor;
    _segment.selectedSegmentIndex = 0;
    [_segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [navigatonView addSubview:_segment];
    
    UIFont *font = [MyAdapter fontADapter:14];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    [_segment setTitleTextAttributes:attributes
                               forState:UIControlStateNormal];
    
    
    
    _fireVc = [[FireAlarmViewController alloc] init];
    _fireVc.view.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    [self.view addSubview:_fireVc.view];
    
    
    _taskBookVc = [[TaskBookViewController alloc] init];
    _taskBookVc.view.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    [self.view addSubview:_taskBookVc.view];
    _taskBookVc.view.hidden = YES;
    
    
    _serviceVc = [[ServiceViewController alloc] init];
    _serviceVc.view.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    [self.view addSubview:_serviceVc.view];
    _serviceVc.view.hidden = YES;
    
    
    
    
    
    
}

-(void)segmentAction:(UISegmentedControl *)segmentControl
{
    
    if ( segmentControl.selectedSegmentIndex == 0) {
        
        _fireVc.view.hidden = NO;
        _taskBookVc.view.hidden = YES;
        _serviceVc.view.hidden = YES;
        

        _taskBookVc.publishBtn.hidden = YES;
        _serviceVc.serviceBtn.hidden = YES;
        
    }else if (segmentControl.selectedSegmentIndex ==1){
        
        _taskBookVc.view.hidden = NO;
        _fireVc.view.hidden = YES;
        _serviceVc.view.hidden = YES;
        
        _taskBookVc.publishBtn.hidden = NO;
        _serviceVc.serviceBtn.hidden = YES;

        
    }else{
        
        _serviceVc.view.hidden = NO;
        _fireVc.view.hidden = YES;
        _taskBookVc.view.hidden = YES;
        
        _taskBookVc.publishBtn.hidden = YES;
        _serviceVc.serviceBtn.hidden = NO;

    }
}


-(void)leftBtnClick
{
    [_svc popViewController];
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
