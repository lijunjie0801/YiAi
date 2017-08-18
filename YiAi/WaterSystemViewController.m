//
//  WaterSystemViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/12.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "WaterSystemViewController.h"
#import "WaterGageViewController.h"
#import "WaterLevelViewController.h"
#import "SegmentView.h"

@interface WaterSystemViewController ()
@property(nonatomic,strong)NSString *procode;
@end

@implementation WaterSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.myTitle;
    
  
    WaterGageViewController   *gageVc    = [[WaterGageViewController alloc] init];
    gageVc.myTitle=self.myTitle;
    gageVc.procode=self.procode;
    WaterLevelViewController  *levelVc = [[WaterLevelViewController alloc] init];
    levelVc.myTitle=self.myTitle;
    levelVc.procode=self.procode;
    NSArray *controllers = @[gageVc,levelVc];
    NSArray *titleArrays = @[@"采集数据",@"报警数据"];
    
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
