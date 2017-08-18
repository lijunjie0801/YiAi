//
//  MHQListViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/7/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "MHQListViewController.h"

@interface MHQListViewController ()

@end

@implementation MHQListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    lb.text=self.MHQType;
    [self.view addSubview:lb];
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
