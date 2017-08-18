//
//  XFSSViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/7/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "XFSSViewController.h"
#import "QidongViewController.h"
#import "DaiJiViewController.h"
#import "GuZhangViewController.h"
#import "SegmentView.h"
@interface XFSSViewController ()
@property(nonatomic,strong)NSString *mytitle;
@property(nonatomic,strong)NSString *procode;
@end

@implementation XFSSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_mytitle;
    QidongViewController *untreatedVC = [[QidongViewController alloc] init];
    untreatedVC.procode=self.procode;
    untreatedVC.myTitle=self.mytitle;
    DaiJiViewController   *distorVc    = [[DaiJiViewController alloc] init];
    distorVc.procode=self.procode;
    distorVc.myTitle=self.mytitle;
    GuZhangViewController  *trueVc      = [[GuZhangViewController alloc] init];
    trueVc.procode=self.procode;
    trueVc.myTitle=self.mytitle;
    NSArray *controllers = @[untreatedVC,distorVc,trueVc];
    NSArray *titleArrays = @[@"启动",@"待机",@"故障"];
    
    SegmentView *segment = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) controllers:controllers titleArray:titleArrays ParentController:self];
    
    [self.view addSubview:segment];

}
-(void)setIntentDic:(NSDictionary *)intentDic{
    self.mytitle=intentDic[@"title"];
    self.procode=intentDic[@"procode"];
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
