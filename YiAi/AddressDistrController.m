//
//  AddressDistrController.m
//  YiAi
//
//  Created by lijunjie on 2017/8/8.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "AddressDistrController.h"
#import "WSPieChart.h"

@interface AddressDistrController ()
@property(nonatomic,strong)NSString *procode;
@property(nonatomic, strong)NSMutableArray *XArray;
@property(nonatomic, strong)NSMutableArray *YArray;
@end

@implementation AddressDistrController
-(void)setIntentDic:(NSDictionary *)intentDic{
    _procode=intentDic[@"procode"];
}
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设备位置分布图";
    [self getdata];
   }
-(void)setUI{
    self.view.backgroundColor=[UIColor whiteColor];
    WSPieChart *pie = [[WSPieChart alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width, self.view.frame.size.width)];
    pie.valueArr = _YArray;//@[@50,@20,@33,@22,@32,@33,@66,@10];
    pie.descArr =_XArray; //@[@"1月份",@"2月份",@"3月份",@"4月份",@"5月份",@"6月份",@"7月份",@"8月份",];
    pie.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pie];
    pie.positionChangeLengthWhenClick = 20;
    pie.showDescripotion = YES;
    [pie showAnimation];

}
-(void)getdata{
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode};
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLNfcAdressDistributed] withParamer:param completionHandler:^(id responseObject) {
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
                [xmarr addObject:dic[@"position"]];
                
                NSInteger num = [dic[@"countNum"] integerValue];
                NSNumber * nums = @(num);
                [yarr addObject:nums];
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
