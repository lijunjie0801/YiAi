//
//  NetworkUnitViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/16.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "NetworkUnitViewController.h"
#import "JHColumnChart.h"
@interface NetworkUnitViewController ()<JHColumnChartDelegate>


@property(nonatomic, strong) JHColumnChart *columnChart;
@property(nonatomic, strong) NSString *procode;
@property(nonatomic, strong)NSMutableArray *XArray;
@property(nonatomic, strong)NSMutableArray *YArray;
@end

@implementation NetworkUnitViewController
-(NSMutableArray *)XArray{
    if (!_XArray) {
        _XArray=[NSMutableArray array];
    }
    return  _XArray;
}
-(NSMutableArray *)YArray{
    if (!_YArray) {
        _YArray=[NSMutableArray array];
    }
    return  _YArray;
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    _procode = intentDic[@"procode"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置数目分布图";
    [self getdata];
    
    
    
}
-(void)setUI{
    self.view.backgroundColor=[UIColor whiteColor];
    self.columnChart = [[JHColumnChart alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-100)];
    
    
    self.columnChart.valueArr = _YArray;
    self.columnChart.originSize = CGPointMake([MyAdapter aDapter:50], [MyAdapter aDapter:120]);
    self.columnChart.drawFromOriginX = 20;
    self.columnChart.typeSpace = 10;
    self.columnChart.isShowYLine = NO;
    self.columnChart.columnWidth = [MyAdapter aDapter:50];
    self.columnChart.bgVewBackgoundColor = [UIColor whiteColor];
    self.columnChart.drawTextColorForX_Y = [AppAppearance sharedAppearance].title2TextColor;
    self.columnChart.colorForXYLine = [UIColor darkGrayColor];
    
    //每个数据的颜色
    self.columnChart.columnBGcolorsArr = @[[UIColor colorWithRed:72/256.0 green:200.0/256 blue:255.0/256 alpha:1],[UIColor greenColor],[UIColor orangeColor]];
    /*        Module prompt         */
    self.columnChart.xShowInfoText = _XArray;
    
    //设置x轴字体的大小
    self.columnChart.xDescTextFontSize = [MyAdapter fontDapter:12];
    self.columnChart.yDescTextFontSize = [MyAdapter fontDapter:14];
    
    self.columnChart.isShowLineChart = YES;
    
    self.columnChart.delegate = self;
    /*       Start animation        */
    [self.columnChart showAnimation];
    [self.view addSubview:self.columnChart];
    
    

}
-(void)getdata{
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode};
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLNfcTypeDistributed] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
            NSArray *array=dic[@"datas"][@"nfcTypeList"][@"nfcTypeList"];
            if (array.count==0) {
                 [_svc showMessage:@"赞无数据"];
                return ;
            }
            NSMutableArray *xmarr=[NSMutableArray array];
            NSMutableArray *yarr=[NSMutableArray array];
            for (NSDictionary *dic in array) {
                [xmarr addObject:dic[@"deviceType"]];
                
                NSInteger num = [dic[@"countNum"] integerValue];
                NSNumber * nums = @(num);
                NSArray *arr = [NSArray arrayWithObject:nums];
                [yarr addObject:arr];
            }
            _XArray=[xmarr mutableCopy];
            _YArray=[yarr mutableCopy];
            [self setUI];
        }else{
            [_svc showMessage:dic[@"msgs"]];
            [_svc hideLoadingView];
        }
  
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];
        
  
    }];

}

-(void)columnItem:(UIView *)item didClickAtIndexRow:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
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
