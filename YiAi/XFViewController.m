//
//  XFViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/7/29.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "XFViewController.h"
#import "ThirdCustomeView.h"
@interface XFViewController ()
@property(nonatomic,strong)NSString *procode;
@property(nonatomic,strong)NSArray *array;
@end

@implementation XFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"消防设施";
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUI];
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    self.procode=intentDic[@"procode"];
}
-(void)setUI{
    NSArray *titles=@[@"联网单位",@"查岗",@"研判",@"主机厂商",@"误报统计"];
    NSArray *icons=@[@"bj0",@"bj5",@"bj4",@"bj3",@"bj1"];
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode};
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLXFTypeList] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
            _array=dic[@"datas"][@"transforAllList"][@"transforAllList"];
            for (int i=0; i<_array.count; i++) {
                ThirdCustomeView *cusView=[[ThirdCustomeView alloc]initWithFrame:CGRectMake(i%4*(kScreen_Width/4), i/4*125, kScreen_Width/4, 125)];
                cusView.tag=i;
                NSString *staName=_array[i];
                NSString *imgName;
                if ([staName containsString:@"电流"]) {
                    imgName=@"dl_1";
                }else if([staName containsString:@"电压"]){
                    imgName=@"dy_1";
                }else if([staName containsString:@"风速"]){
                    imgName=@"fs_1";
                }else if([staName containsString:@"光照强度"]){
                    imgName=@"gzqd";
                }else if([staName containsString:@"湿度"]){
                    imgName=@"sd_1";
                }else if([staName containsString:@"输出"]){
                    imgName=@"sc_1";
                }else if([staName containsString:@"水位"]){
                    imgName=@"sw_1";
                }else if([staName containsString:@"温度"]){
                    imgName=@"wd_1";
                }else if([staName containsString:@"压力"]){
                    imgName=@"yl_1";
                }
                

                cusView.imageview.image=[UIImage imageNamed:imgName];
                cusView.imageview.contentMode = UIViewContentModeScaleAspectFill;
                cusView.label.text=_array[i];
                [self.view addSubview:cusView];
                cusView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)];
                [cusView addGestureRecognizer:tag];

            }

        }else{
            [_svc showMessage:dic[@"msgs"]];
            [_svc hideLoadingView];
        }
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];
        
        
    }];

   }
-(void)itemClick:(UITapGestureRecognizer *)tap{
    NSLog(@"%ld",[tap view].tag);
    NSInteger index=[tap view].tag;
    [_svc pushViewController:_svc.XFListViewController withObjects:@{@"myTitle":_array[index],@"procode":_procode}];
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
