//
//  QTTJViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/7/29.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "QTTJViewController.h"
#import "ThirdCustomeView.h"
@interface QTTJViewController ()

@end

@implementation QTTJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"其他统计";
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUI];
}
-(void)setUI{
    NSArray *titles=@[@"联网单位",@"查岗",@"研判",@"主机厂商",@"误报统计"];
    NSArray *icons=@[@"lwdw",@"cg_1",@"yp_1",@"zjcs",@"wbtj"];
    for (int i=0; i<5; i++) {
        ThirdCustomeView *cusView=[[ThirdCustomeView alloc]initWithFrame:CGRectMake(i%4*(kScreen_Width/4), i/4*125, kScreen_Width/4, 125)];
        cusView.imageview.image=[UIImage imageNamed:icons[i]];
        cusView.imageview.contentMode = UIViewContentModeScaleAspectFill;
        cusView.label.text=titles[i];
        [self.view addSubview:cusView];
    }
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
