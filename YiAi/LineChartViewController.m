//
//  LineChartViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/8/7.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "LineChartViewController.h"
#import "WSLineChartView.h"
#import "HCGDatePickerAppearance.h"
@interface LineChartViewController (){
    NSInteger _ymax;
}
@property(nonatomic,strong)NSString *myTitle,*queryYear,*queryMonth,*queryDay,*procode;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSArray *searchTypeArray;
@property(nonatomic,strong)NSMutableArray *XArray;
@property(nonatomic,strong)UIButton *bigBtn;
@property(nonatomic,strong)WSLineChartView *wsLine;
@end

@implementation LineChartViewController
-(NSMutableArray *)XArray{
    if (!_XArray) {
        _XArray=[NSMutableArray array];
    }
    return _XArray;
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    _myTitle=intentDic[@"myTitle"];
    _procode=intentDic[@"procode"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _queryYear=@"2017";
    _queryMonth=@"";
    _queryDay=@"";
    self.title=_myTitle;
    _searchTypeArray=@[@"按月查询",@"按日查询"];
    [self getData];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"zhexianBack.png"]];//[UIColor colorWithRed:85.0f/255.0f green:85.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"按年查询" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    
}
-(void)rightAction:(UIBarButtonItem *)sender{
    //sender.title=@"哈哈";
    _bigBtn=[[UIButton alloc]initWithFrame:self.view.bounds];
    [_bigBtn addTarget:self action:@selector(empty) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bigBtn];
    for (int i=0; i<_searchTypeArray.count; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-100, i*44, 100, 44)];
        btn.tag=i;
        btn.titleLabel.font=[UIFont systemFontOfSize:17];
        [btn setTitle:self.searchTypeArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectMieName:) forControlEvents:UIControlEventTouchUpInside];
        [_bigBtn addSubview:btn];
        
    }

}
-(void)empty{
    [_bigBtn removeFromSuperview];
}
-(void)selectMieName:(UIButton *)sender{
    NSMutableArray *newArray = [_searchTypeArray mutableCopy];
    [newArray replaceObjectAtIndex:sender.tag withObject:self.navigationItem.rightBarButtonItem.title];
    NSLog(@"%@",self.searchTypeArray[sender.tag]);
    NSString *selName=self.searchTypeArray[sender.tag];
    if ([selName isEqualToString:@"按年查询"]) {
        HCGDatePickerAppearance *picker = [[HCGDatePickerAppearance alloc]initWithDatePickerMode:DatePickerYearMode completeBlock:^(NSDate *date) {
            NSString *formatStr = @"yyyy";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:formatStr];
            NSLog(@"%@",[dateFormatter stringFromDate:date]);
            _queryYear=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
            _queryMonth=@"";
            _queryDay=@"";
            [_wsLine removeFromSuperview];
            [self getData];
            self.navigationItem.rightBarButtonItem.title=self.searchTypeArray[sender.tag];
            _searchTypeArray = newArray;
            
            [_bigBtn removeFromSuperview];
            
        }];
        [picker show];

    }else if([selName isEqualToString:@"按月查询"]){
        HCGDatePickerAppearance *picker = [[HCGDatePickerAppearance alloc]initWithDatePickerMode:DatePickerYearMonthMode completeBlock:^(NSDate *date) {
            NSString *formatStr = @"yyyy-MM";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:formatStr];
            _queryYear=@"";
            _queryMonth=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
            _queryDay=@"";
            [_wsLine removeFromSuperview];
            [self getData];
            NSLog(@"%@",[dateFormatter stringFromDate:date]);
            self.navigationItem.rightBarButtonItem.title=self.searchTypeArray[sender.tag];
            _searchTypeArray = newArray;
            
            [_bigBtn removeFromSuperview];
        }];
        [picker show];
    }else if([selName isEqualToString:@"按日查询"]){
        HCGDatePickerAppearance *picker = [[HCGDatePickerAppearance alloc]initWithDatePickerMode:DatePickerDateMode completeBlock:^(NSDate *date) {
            NSString *formatStr = @"yyyy-MM-dd";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:formatStr];
            NSLog(@"%@",[dateFormatter stringFromDate:date]);
            _queryYear=@"";
            _queryMonth=@"";
            _queryDay=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
            [_wsLine removeFromSuperview];
            [self getData];
            self.navigationItem.rightBarButtonItem.title=self.searchTypeArray[sender.tag];
            _searchTypeArray = newArray;
            
            [_bigBtn removeFromSuperview];
            
        }];
        [picker show];
    }

    
}
-(void)getData{
       [_svc showLoadingWithMessage:@"加载中..." inView:[UIApplication sharedApplication].keyWindow];
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":_procode,@"alarmType":_myTitle,@"handleType":@"",@"queryYear":_queryYear,@"queryMonth":_queryMonth,@"queryDay":_queryDay};
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLAlarmStatisticalAnalysis] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
            _dataArray=dic[@"datas"][@"alarmStaAnaList"][@"alarmStaAnaList"];
              NSInteger max = [[_dataArray valueForKeyPath:@"@max.intValue"] integerValue];
              _ymax=(max/10+1)*10;
            NSMutableArray *marr=[NSMutableArray array];
            NSString *s;
            if (_queryYear.length!=0) {
                s=@"月";
            }else if(_queryMonth.length!=0){
                 s=@"日";
            }else if(_queryDay.length!=0){
                 s=@"时";
            }
            for (int i=1; i<=_dataArray.count; i++) {
                [marr addObject:[NSString stringWithFormat:@"%d%@",i,s]];
            }
            _XArray=[marr mutableCopy];
            [self setUI];
        }else{
            [_svc showMessage:dic[@"msgs"]];
            [_svc hideLoadingView];
        }
         [_svc hideLoadingView];
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];
        
        
    }];

}
-(void)setUI{

    _wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 500) xTitleArray:_XArray yValueArray:_dataArray yMax:_ymax yMin:0 limitup:1000000000 limitdown:1000000000];
    
    [self.view addSubview:_wsLine];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
