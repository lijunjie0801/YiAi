//
//  CustomeLineChatViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/8/8.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "CustomeLineChatViewController.h"
#import "WSLineChartView.h"
@interface CustomeLineChatViewController ()<WSLineDelegate>{
    CGFloat _ymax;
    int _pageNum;
}

@property(nonatomic,strong)NSString *procode,*histId,*macNum,*address,*portNum,*deviceType;
@property(nonatomic,strong)WSLineChartView *wsLine;
@property(nonatomic,strong)NSMutableArray *YArray;
@property(nonatomic,strong)NSMutableArray *XArray;
@property(nonatomic,assign)CGFloat limitup,limitdown;
@property(nonatomic,assign)UILabel *lb,*lb1;
@end

@implementation CustomeLineChatViewController
-(NSMutableArray *)XArray{
    if (!_XArray) {
        _XArray=[NSMutableArray array];
    }
    return _XArray;
}
-(NSMutableArray *)YArray{
    if (!_YArray) {
        _YArray=[NSMutableArray array];
    }
    return _YArray;
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    _procode=intentDic[@"procode"];
    _histId=intentDic[@"histId"];
    _macNum=intentDic[@"macNum"];
    _address=intentDic[@"address"];
    _portNum=intentDic[@"portNum"];
    _deviceType=intentDic[@"deviceType"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_deviceType;
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"zhexianBack.png"]];
    _pageNum = 0;

    [self getData];
}
-(void)getData{
    NSString *pagesize=[NSString stringWithFormat:@"%d",10*(_pageNum+1)];
    NSDictionary *param = @{@"appKey":[AppDataManager defaultManager].identifier,@"histId":_histId,@"macNum":_macNum,@"address":_address,@"portNum":_portNum,@"deviceType":_deviceType,@"page":[NSString stringWithFormat:@"%d",_pageNum],@"pageSize":pagesize,@"proCode":self.procode};
    
    [_svc showLoadingWithMessage:@"加载中..." inView:[UIApplication sharedApplication].keyWindow];
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLFireStaAnaList] withParamer:param completionHandler:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        
        if ([dic[@"status"] integerValue] ==100) {
            NSArray *array=dic[@"datas"][@"fireStaAnaList"][@"fireStaAnaList"];
            NSMutableArray *yarr=[NSMutableArray array];
            NSMutableArray *xarr=[NSMutableArray array];
            for (NSDictionary *dic in array) {
                [yarr addObject:dic[@"value"]];
                 NSString *xstr=dic[@"time"];
                [xarr addObject:xstr];
                _limitup=[dic[@"thresholdUpLimit"] floatValue];
                _limitdown=[dic[@"thresholdDownLimit"] floatValue];
            }
            _YArray=[yarr mutableCopy];
            _XArray=[xarr mutableCopy];
           NSInteger max = [[yarr valueForKeyPath:@"@max.intValue"] integerValue];
            if (max>=_limitup) {
                _ymax=(max/10+1)*10;
            }else{
                _ymax=_limitup;
            }
            
            [self setUI];
        }else{
            [_svc showMessage:dic[@"msgs"]];
            [_svc hideLoadingView];
        }
        [_svc hideLoadingView];

              
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        
    }];

}
-(void)setUI{
    
    _wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 500) xTitleArray:_XArray yValueArray:_YArray yMax:_ymax yMin:0 limitup:_limitup limitdown:_limitdown];
    _wsLine.delegate=self;
    [self.view addSubview:_wsLine];
    int num=ceilf(_limitup*1.0);
    NSString *limitStr;
    if (_limitup>=1||_limitup==0) {
        limitStr=[NSString stringWithFormat:@"上限(%d)",num];
    }else{
        limitStr=[NSString stringWithFormat:@"上限(%.2f)",_limitup];
    }
    CGFloat chartHeight = 500-15-50 ;
    CGRect rec=CGRectMake(kScreen_Width-100,chartHeight - self.limitup/_ymax * chartHeight+100-25 , 100, 20);
    UILabel *lb=[[UILabel alloc]initWithFrame:rec];
    self.lb=lb;
    lb.text=limitStr;
    lb.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:lb];
    
    CGRect recmin=CGRectMake(kScreen_Width-100,chartHeight - self.limitdown/_ymax * chartHeight+75 , 100, 20);
    NSString *limitdownStr;
     int num1=ceilf(_limitdown*1.0);
    if (_limitdown>=1||_limitdown==0) {
        limitdownStr=[NSString stringWithFormat:@"下限(%d)",num1];
    }else{
        limitdownStr=[NSString stringWithFormat:@"下限(%.2f)",_limitdown];
    }

//    int i=ceilf(_limitdown*1.0);
    UILabel *lbmin=[[UILabel alloc]initWithFrame:recmin];
    _lb1=lbmin;
    lbmin.text=limitdownStr;
    lbmin.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:lbmin];
}

-(void)GetMore{
    NSLog(@"hhhh");
    _pageNum+=1;
    [_lb1 removeFromSuperview];
    [_lb removeFromSuperview];
    [_wsLine removeFromSuperview];
    [self getData];
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
