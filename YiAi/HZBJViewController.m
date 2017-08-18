//
//  HZBJViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/7/29.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "HZBJViewController.h"
#import "ThirdCustomeView.h"
@interface HZBJViewController ()
@property(nonatomic,strong)NSArray *titles,*procode;
@end

@implementation HZBJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"火灾报警系统";
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUI];
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    _procode=intentDic[@"procode"];
}
-(void)setUI{
   _titles=@[@"火警",@"动作反馈",@"屏蔽",@"通讯故障",@"故障"];
    NSArray *icons=@[@"bj0",@"bj5",@"bj4",@"bj3",@"bj1"];
    for (int i=0; i<5; i++) {
     ThirdCustomeView *cusView=[[ThirdCustomeView alloc]initWithFrame:CGRectMake(i%4*(kScreen_Width/4), i/4*125, kScreen_Width/4, 125)];
        cusView.imageview.image=[UIImage imageNamed:icons[i]];
        cusView.tag=i;
        cusView.imageview.contentMode = UIViewContentModeScaleAspectFill;
        cusView.label.text=_titles[i];
        [self.view addSubview:cusView];
        cusView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)];
        [cusView addGestureRecognizer:tag];
    }
}
-(void)itemClick:(UITapGestureRecognizer *)tap{
    NSLog(@"%ld",[tap view].tag);
    NSInteger index=[tap view].tag;
    if (index!=0) {
        [_svc pushViewController:_svc.lineChartController withObjects:@{@"myTitle":_titles[index],@"procode":_procode}];
    }else{
        [_svc pushViewController:_svc.FireLineChartViewController withObjects:@{@"myTitle":_titles[index],@"procode":_procode}];
    }
  }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
