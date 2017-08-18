//
//  FireAlarmViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/12.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "FireAlarmViewController.h"
#import "SegmentView.h"
#import "UntreatedFireViewController.h"
#import "DistortFireViewController.h"
#import "TrueFireViewController.h"

@interface FireAlarmViewController ()
@property(nonatomic,strong)NSString *procode;
@end

@implementation FireAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.myTitle;
    
    
    UntreatedFireViewController *untreatedVC = [[UntreatedFireViewController alloc] init];
    untreatedVC.myTitle=self.myTitle;
    untreatedVC.procode=self.procode;
    DistortFireViewController   *distorVc    = [[DistortFireViewController alloc] init];
    distorVc.myTitle=self.myTitle;
    distorVc.procode=self.procode;
    TrueFireViewController      *trueVc      = [[TrueFireViewController alloc] init];
    trueVc.myTitle=self.myTitle;
    trueVc.procode=self.procode;
    NSArray *controllers = @[untreatedVC,distorVc,trueVc];
    NSArray *titleArrays = @[@"未处理",@"误报",@"真实火警"];
    
    SegmentView *segment = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) controllers:controllers titleArray:titleArrays ParentController:self];
    
    [self.view addSubview:segment];
    
    
}
-(void)setIntentDic:(NSDictionary *)intentDic
{
    self.myTitle = intentDic[@"title"];
    self.procode = intentDic[@"procode"];
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
