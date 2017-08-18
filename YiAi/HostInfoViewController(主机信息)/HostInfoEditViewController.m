//
//  HostInfoEditViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/7/25.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "HostInfoEditViewController.h"
#import "WSDatePickerView.h"
@interface HostInfoEditViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _count;
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSString *procode;
@property(nonatomic,strong)NSString *hostId;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSArray *statuNameArray;
@property(nonatomic,strong)NSMutableArray *detailArray;
@property(nonatomic, strong) NSArray *mieArray;
@property(nonatomic,strong)NSMutableArray *statuArray;
@property(nonatomic,strong)NSString *descrStr,*ID,*hostName;
@property(nonatomic,strong)UITextField *installTf,*dueTf,*proNameLab,*proClassify,*proAddress,*SuperiorNodeLab,*MachineNoLab,*MachineModelLab,*LoopNumLab,*softVersionLab,*CommuniModeLab,*CommuniNumLab;
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic, strong)UIButton *bigBtn;
@property(nonatomic,strong)UITextView *deslabel;
@property(retain,nonatomic) UISwitch * mySwitch;
@property(nonatomic,strong)UIView *midView;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIButton *statubtn,*btn1,*btn2,*btn3,*btn4,*btn5,*btn6,*btn7,*btn8;
@property(nonatomic,strong)UIView *mieView;
@end

@implementation HostInfoEditViewController
-(NSMutableArray *)detailArray{
    if (!_detailArray) {
        _detailArray=[NSMutableArray array];
    }
    return _detailArray;
}
-(NSMutableArray *)statuArray{
    if (!_statuArray) {
        _statuArray=[NSMutableArray array];
    }
    return _statuArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"主机信息修改";
    _dataArray=@[@"工程名称",@"工程分类",@"工程地址",@"上级节点",@"控制器机号",@"控制器型号",@"控制器回路数",@"控制器软件版本",@"通讯方式",@"通讯号码",@"安装时间",@"到期时间",@"是否维保模式",@"维保模式结束时间"];
    _statuNameArray=@[@"有效",@"存在泵房状态",@"有视频监控",@"两点联动",@"内部工程",@"采集",@"巡检",@"加密"];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.tableHeaderView=[self setview];
    _tableview.tableFooterView=[self setfooter];
    self.view =_tableview;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];

//    [self setfooter];
}

-(void)rightAction{
    NSString *param1=_proNameLab.text;
    NSString *param2=_proClassify.text;
    NSString *param3=_proAddress.text;
    NSString *param4=_SuperiorNodeLab.text;
    NSString *param5=_MachineNoLab.text;
    NSString *param6=_MachineModelLab.text;
    NSString *param7=_LoopNumLab.text;
    NSString *param8=_softVersionLab.text;
    NSString *param9=_CommuniModeLab.text;
    NSString *param10=_CommuniNumLab.text;
    NSString *param11=_installTf.text;
    NSString *param12=_dueTf.text;
    NSString *param13=_lab.text;
    NSString *param14=[NSString stringWithFormat:@"%ld",(long)_btn1.selected];
    NSString *param15=[NSString stringWithFormat:@"%ld",(long)_btn2.selected];
    NSString *param16=[NSString stringWithFormat:@"%ld",(long)_btn3.selected];
    NSString *param17=[NSString stringWithFormat:@"%ld",(long)_btn4.selected];
    NSString *param18=[NSString stringWithFormat:@"%ld",(long)_btn5.selected];
    NSString *param19=[NSString stringWithFormat:@"%ld",(long)_btn6.selected];
    NSString *param20=[NSString stringWithFormat:@"%ld",(long)_btn7.selected];
    NSString *param21=[NSString stringWithFormat:@"%ld",(long)_btn8.selected];
    NSString *param22=_deslabel.text;
    NSString *param23=[NSString stringWithFormat:@"%ld",(long)[_mySwitch isOn]];
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"ID":self.ID,@"procode":_procode,@"hostName":param1,@"hostAddress":param3,@"superiorNode":param4,@"controllerNum":param5,@"controllerClssify":param6,@"controllerBackCount":param7,@"controllerVersion":param8,@"reportType":param9,@"reportPhone":param10,@"installTime":param11,@"hostWbEndTime":param12,@"p_protectModel":param23,@"p_auto_time":param13,@"Enabled":param14,@"IsPumpStates":param15,@"IsSurveillance":param16,@"p_twoToStartup":param17,@"IsInnerProject":param18,@"p_gather":param19,@"p_patrol":param20,@"p_secret":param21,@"Description":param22};
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLHostChange] withParamer:param completionHandler:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"status"] integerValue] ==100) {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];

        }else{
            
            [_svc showMessage:dic[@"msgs"]];
            
            [_svc hideLoadingView];
            
        }
        
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        
        [_svc showMessage:error.domain];
        
       
        
    }];

}
-(void)setIntentDic:(NSDictionary *)intentDic{
    self.detailArray=intentDic[@"detailArray"];
    NSString *st=self.detailArray[8];
    if ([st isEqualToString:@"ADSL"]) {
        self.mieArray=@[@"CDMA",@"GPRS"];
    }else if ([st isEqualToString:@"CDMA"]){
        self.mieArray=@[@"ADSL",@"GPRS"];
    }else{
        self.mieArray=@[@"ADSL",@"CDMA"];
    }
    self.statuArray=intentDic[@"statuArray"];
    self.descrStr=intentDic[@"descrStr"];
    self.procode=intentDic[@"procode"];
    self.ID=intentDic[@"ID"];
    self.hostName=intentDic[@"hostName"];
}

-(UIView *)setfooter{
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 300)];
    CGFloat labWidth=(kScreen_Width-20)/3;
    UILabel *toplabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 100, 40)];
    toplabel.text=@"有效";
    toplabel.textColor=[UIColor colorWithHexString:@"0x999999"];
    [footer addSubview:toplabel];
    for (int i=0; i<8; i++) {
        
        UIImageView *selView=[[UIImageView alloc]initWithFrame:CGRectMake(10+labWidth*(i%3), 42.5+30*(i/3), 15, 15)];
        selView.tag=200+i;
        UIImage *image;

        [footer addSubview:selView];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30+labWidth*(i%3), 40+30*(i/3), labWidth, 20)];
        label.tag=100+i;
         UIButton *statubtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width/3*(i%3), 40+30*(i/3), kScreen_Width/3, 20)];
        statubtn.tag=i;
        [statubtn addTarget:self action:@selector(changeStatu:) forControlEvents:UIControlEventTouchUpInside];
        if ([_statuArray[i] integerValue]==1) {
            statubtn.selected=YES;
            image=[UIImage imageNamed:@"sel"];
            label.textColor=[UIColor colorWithHexString:@"0x207edb"];
        }else{
            statubtn.selected=NO;
             image=[UIImage imageNamed:@"unsel"];
            label.textColor=[UIColor colorWithHexString:@"0x999999"];
        }
        selView.image=image;
        label.text=_statuNameArray[i];
        label.font=[UIFont systemFontOfSize:15];
        [footer addSubview:label];
        [footer addSubview:statubtn];
        switch (i) {
            case 0:
                _btn1=statubtn;
                break;
            case 1:
                _btn2=statubtn;
                break;
            case 2:
                _btn3=statubtn;
                break;
            case 3:
                _btn4=statubtn;
                break;
            case 4:
                _btn5=statubtn;
                break;
            case 5:
                _btn6=statubtn;
                break;
            case 6:
                _btn7=statubtn;
                break;
            case 7:
                _btn8=statubtn;
                break;
                
            default:
                break;
        }
    }
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,135,kScreen_Width,1)];
    v.backgroundColor=[UIColor colorWithHexString:@"0xeeeeee"];
    [footer addSubview:v];
    UILabel *botlabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 150, 100, 30)];
    botlabel.text=@"说明";
    botlabel.textColor=[UIColor colorWithHexString:@"0x999999"];
    [footer addSubview:botlabel];
    
    _deslabel=[[UITextView alloc]initWithFrame:CGRectMake(5, 180, kScreen_Width-10, 100)];
    
    _deslabel.font=[UIFont systemFontOfSize:17];
    _deslabel.text=self.descrStr;
    // deslabel.textColor=[UIColor colorWithHexString:@"0x999999"];
    [footer addSubview:_deslabel];
    
    return footer;
    
}
-(void)changeStatu:(UIButton *)sender{
    UILabel *lb=[self.view viewWithTag:100+sender.tag];
    UIImageView *img=[self.view viewWithTag:200+sender.tag];
    if (sender.selected==YES) {
        lb.textColor=[UIColor colorWithHexString:@"0x999999"];
        img.image=[UIImage imageNamed:@"unsel"];
    }else{
         lb.textColor=[UIColor colorWithHexString:@"0x207edb"];
        img.image=[UIImage imageNamed:@"sel"];
    }
    sender.selected=!sender.selected;
    NSLog(@"%ld",(long)sender.selected);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}
-(void)haha:(UITapGestureRecognizer*)tap{
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSLog(@"时间： %@",date);
        _lab.text=date;
    }];
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


-(UIView *)setview{
    _backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 44*20)];
    _midView=[[UIView alloc]initWithFrame:CGRectMake(0, 44*13, kScreen_Width, 44)];
    [_backView addSubview:_midView];
    UILabel *leftLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 44)];
    leftLab.text=_dataArray[_dataArray.count-1];
    [_midView addSubview:leftLab];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,44,kScreen_Width,1)];
    v.backgroundColor=[UIColor colorWithHexString:@"0xeeeeee"];
    [_midView addSubview:v];
    _lab=[[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width-200, 0, 190, 44)];
    _lab.text=_detailArray[_detailArray.count-1];
    _lab.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(haha:)];
    [_lab addGestureRecognizer:tapGestureRecognizer];
    _lab.textAlignment=NSTextAlignmentRight;
    [_midView addSubview:_lab];
    for (int i=0; i<13; i++) {
       
            UILabel *leftLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 44*i, 150, 44)];
            leftLab.text=_dataArray[i];
            [_backView addSubview:leftLab];
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,(i+1)*44,kScreen_Width,1)];
            v.backgroundColor=[UIColor colorWithHexString:@"0xeeeeee"];
            [_backView addSubview:v];
        if (i!=12) {
            UITextField *tf=[[UITextField alloc]initWithFrame:CGRectMake(kScreen_Width-200, 44*i, 190, 44)];
            tf.textAlignment=NSTextAlignmentRight;
            tf.text=_detailArray[i];
            [_backView addSubview:tf];
            if (i==1) {
                tf.userInteractionEnabled=YES;
            }else{
                tf.userInteractionEnabled=NO;
            }
            switch (i) {
                case 0:
                    _proNameLab=tf;
                    break;
                case 1:
                    _proClassify=tf;
                    break;
                case 2:
                    _proAddress=tf;
                    break;
                case 3:
                    _SuperiorNodeLab=tf;
                    break;
                case 4:
                    _MachineNoLab=tf;
                    break;
                case 5:
                    _MachineModelLab=tf;
                    break;
                case 6:
                    _LoopNumLab=tf;
                    break;
                case 7:
                    _softVersionLab=tf;
                    break;
                case 8:
                    _CommuniModeLab=tf;
                    break;
                case 9:
                    _CommuniNumLab=tf;
                    break;

                case 10:
                    _installTf=tf;
                    break;
                case 11:
                    _dueTf=tf;
                    break;

                default:
                    break;
            }
        }else{
            UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(kScreen_Width-70, 44*12+6, 44, 22)];
            _mySwitch=switchButton;
            NSString *s=_detailArray[12];
            if ([s isEqualToString:@"是"]) {
                 [switchButton setOn:YES];
                _backView.frame=CGRectMake(0, 0, kScreen_Width, 44*14);
                _midView.hidden=NO;
                
            }else{
                 [switchButton setOn:NO];
                _backView.frame=CGRectMake(0, 0, kScreen_Width, 44*13);
                _midView.hidden=YES;
            }
           
            [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            [_backView addSubview:switchButton];
        }
     
    }
    for (int i=0; i<3; i++) {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=i;
        if (i==0) {
            btn.frame=CGRectMake(kScreen_Width-160, 44*8, 150, 44);
        }else if (i==1){
            btn.frame=CGRectMake(kScreen_Width-160, 44*10, 150, 44);
        }else if (i==2){
            btn.frame=CGRectMake(kScreen_Width-160, 44*11, 150, 44);
        }
//        }else{
//            btn.frame=CGRectMake(kScreen_Width-160, 44*13, 150, 44);
//        }
        [btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:btn];
    }

    return  _backView;
}
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"打开");
         _midView.hidden=NO;
        _backView.frame=CGRectMake(0, 0, kScreen_Width, 44*14);
    }else {
        NSLog(@"关闭");
        _midView.hidden=YES;
        _backView.frame=CGRectMake(0, 0, kScreen_Width, 44*13);
    }
    [self.tableview reloadData];
}
-(void)clickbtn:(UIButton *)sender{
    NSLog(@"%ld",sender.tag);
    if (sender.tag==0) {
//        _bigBtn=[[UIButton alloc]initWithFrame:self.view.bounds];
//        [_bigBtn addTarget:self action:@selector(empty) forControlEvents:UIControlEventTouchUpInside];
 //       [self.tableview addSubview:_bigBtn];
        UIView *view=[self setMieView];
        _midView=view;
        view.backgroundColor=[UIColor whiteColor];
        view.frame=CGRectMake(kScreen_Width-150, 44*9, 150, 44*2);
        view.layer.shadowOffset =  CGSizeMake(1, 1);
        view.layer.shadowOpacity = 0.8;
        view.layer.shadowColor =  [UIColor blackColor].CGColor;
        [_tableview addSubview:view];

        return;
    }
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSLog(@"时间： %@",date);
        if (sender.tag==1) {
            _installTf.text=date;
        }else if (sender.tag==2){
            _dueTf.text=date;
        }
    }];
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];
    
}
-(void)empty{
    [_bigBtn removeFromSuperview];
}
-(UIView *)setMieView{
    UIView *mieView=[[UIView alloc]init];
    
    for (int i=0; i<self.mieArray.count; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, i*44, 150, 44)];
        btn.tag=i;
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [btn setTitle:self.mieArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // [btn setBackgroundColor:[UIColor redColor]];
        [btn addTarget:self action:@selector(selectMieName:) forControlEvents:UIControlEventTouchUpInside];
        [mieView addSubview:btn];
        
    }
    return mieView;
}
-(void)selectMieName:(UIButton *)sender{
    NSMutableArray *newArray = [_mieArray mutableCopy];
    [newArray replaceObjectAtIndex:sender.tag withObject:_CommuniModeLab.text];
    _CommuniModeLab.text=self.mieArray[sender.tag];
    _mieArray = newArray;
    [_midView removeFromSuperview];
    
}
////参数传入开关对象本身
//- (void) swChange:(UISwitch*) sw{
//    
//    if(sw.on==YES){
//        NSLog(@"开关被打开");
//          [_mySwitch setThumbTintColor:[UIColor colorWithHexString:@"0x59c5b7"]];
//    }else{
//        NSLog(@"开关被关闭");
//        [_mySwitch setThumbTintColor:RGB(241, 241, 241)];
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
