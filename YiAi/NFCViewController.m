//
//  NFCViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/7/17.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "NFCViewController.h"

@interface NFCViewController ()

@end

@implementation NFCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"解析设备";
    [self setUI];
}
-(void)setUI{
    UILabel *NFClab=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreen_Width, 20)];
    NFClab.textAlignment=NSTextAlignmentCenter;
    NFClab.text=@"请将NFC标签或者贴纸靠近手机背面";
    NFClab.textColor=[UIColor grayColor];
    [self.view addSubview:NFClab];
    
    UIImageView *NFCImgView=[[UIImageView alloc]initWithFrame:CGRectMake(40, 100, kScreen_Width-80, kScreen_Width-80)];
    NFCImgView.image=[UIImage imageNamed:@"NFC"];
    [self.view addSubview:NFCImgView];
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((kScreen_Width-100)/2, kScreen_Height-100, 100, 20)];
    [btn setTitle:@"点此扫描" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"0x207edb"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(saoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)saoClick{
    
    [_svc pushViewController:_svc.hCScanQRViewController];
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
