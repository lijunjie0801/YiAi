//
//  HostInfoDetailViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/7/25.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "HostInfoDetailViewController.h"

@interface HostInfoDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSString *procode;
@property(nonatomic,strong)NSString *hostId;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSArray *statuNameArray;
@property(nonatomic,strong)NSMutableArray *detailArray;
@property(nonatomic,strong)NSMutableArray *statuArray;
@property(nonatomic,strong)NSString *descrStr,*ID,*hostName,*isEdit;
@end

@implementation HostInfoDetailViewController
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
    self.title=@"主机信息";
    _dataArray=@[@"工程名称",@"工程分类",@"工程地址",@"上级节点",@"控制器机号",@"控制器型号",@"控制器回路数",@"控制器软件版本",@"通讯方式",@"通讯号码",@"安装时间",@"到期时间",@"是否维保模式",@"维保模式结束时间"];
    _statuNameArray=@[@"有效",@"存在泵房状态",@"有视频监控",@"两点联动",@"内部工程",@"采集",@"巡检",@"加密"];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    self.view =_tableview;
    [self getListData];
    
   
    if ([self.isEdit integerValue]==1) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    }
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:KFont_13, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
}
-(void)rightAction{
    [_svc pushViewController:_svc.HostEditViewController withObjects:@{@"detailArray":self.detailArray,@"statuArray":_statuArray,@"descrStr":self.descrStr,@"procode":self.procode,@"ID":self.ID,@"hostName":self.hostName}];
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    self.procode=intentDic[@"procode"];
    self.hostId=intentDic[@"hostId"];
    self.isEdit=intentDic[@"isEdit"];
}
-(void)getListData{
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode,@"hostId":self.hostId};
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLHostDetail] withParamer:param completionHandler:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"status"] integerValue] ==100) {
            NSDictionary *diction=dic[@"datas"][@"hostOne"][@"hostOne"];
            NSDictionary *statudic=dic[@"datas"][@"hostOne"][@"effectiveList"];
            self.descrStr=dic[@"datas"][@"hostOne"][@"Description"];
            self.ID=dic[@"datas"][@"hostOne"][@"hostOne"][@"ID"];
            self.hostName=diction[@"hostName"];
            NSString *param0=diction[@"hostName"];
            NSString *param1=diction[@"Category"];
            NSString *param2=diction[@"hostAddress"];
            NSString *param3=diction[@"superiorNode"];
            NSString *param4=diction[@"controllerNum"];
            NSString *param5=diction[@"controllerClassify"];
            NSString *param6=diction[@"controllerBackCount"];
            NSString *param7=diction[@"controlerVersion"];
            NSString *param8=diction[@"reportType"];
            NSString *param9=diction[@"reportPhone"];
            NSString *param10=diction[@"installTime"];
            NSString *param11=diction[@"hostWbEndTime"];
            NSString *param12;
            if ([diction[@"p_protectModel"] integerValue]==1) {
                param12=@"是";
            }else{
                param12=@"否";
            }

            NSString *param13=diction[@"p_auto_time"];
            NSMutableArray *marray=[NSMutableArray array];
            [marray addObject:param0];
            [marray addObject:param1];
            [marray addObject:param2];
            [marray addObject:param3];
            [marray addObject:param4];
            [marray addObject:param5];
            [marray addObject:param6];
            [marray addObject:param7];
            [marray addObject:param8];
            [marray addObject:param9];
            [marray addObject:param10];
            [marray addObject:param11];
            [marray addObject:param12];
            [marray addObject:param13];
            _detailArray=[marray mutableCopy];
            
            
            NSString *statu0=statudic[@"Enabled"];
            NSString *statu1=statudic[@"IsPumpStates"];
            NSString *statu2=statudic[@"IsSurveillance"];
            NSString *statu3=statudic[@"p_twoToStartup"];
            NSString *statu4=statudic[@"IsInnerProject"];
            NSString *statu5=statudic[@"p_gather"];
            NSString *statu6=statudic[@"p_patrol"];
            NSString *statu7=statudic[@"p_secret"];
            NSMutableArray *marr=[NSMutableArray array];
            [marr addObject:statu0];
            [marr addObject:statu1];
            [marr addObject:statu2];
            [marr addObject:statu3];
            [marr addObject:statu4];
            [marr addObject:statu5];
            [marr addObject:statu6];
            [marr addObject:statu7];
            _statuArray=[marr mutableCopy];

        }else{
            
            [_svc showMessage:dic[@"msgs"]];
            
            [_svc hideLoadingView];
            
        }
        [self.tableview reloadData];
        [self setfooter];
        
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        
        [_svc showMessage:error.domain];
        
        [self.tableview reloadData];
        
    }];
}
-(void)setfooter{
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 300)];
    CGFloat labWidth=(kScreen_Width-20)/3;
    UILabel *toplabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 100, 40)];
    toplabel.text=@"有效";
    toplabel.textColor=[UIColor colorWithHexString:@"0x999999"];
    [footer addSubview:toplabel];
    for (int i=0; i<8; i++) {
        UIImageView *selView=[[UIImageView alloc]initWithFrame:CGRectMake(10+labWidth*(i%3), 42.5+30*(i/3), 15, 15)];
        UIImage *image;
        
        if ([_statuArray[i] integerValue]==1) {
            image=[UIImage imageNamed:@"sel"];
        }else{
            image=[UIImage imageNamed:@"unsel"];
        }
        selView.image=image;
        [footer addSubview:selView];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30+labWidth*(i%3), 40+30*(i/3), labWidth, 20)];
        if ([_statuArray[i] integerValue]==1) {
            label.textColor=[UIColor colorWithHexString:@"0x207edb"];
        }else{
             label.textColor=[UIColor colorWithHexString:@"0x999999"];
        }

        label.text=_statuNameArray[i];
        label.font=[UIFont systemFontOfSize:15];
        [footer addSubview:label];
    }
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,135,kScreen_Width,1)];
    v.backgroundColor=[UIColor colorWithHexString:@"0xeeeeee"];
    [footer addSubview:v];
    UILabel *botlabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 150, 100, 30)];
    botlabel.text=@"说明";
    botlabel.textColor=[UIColor colorWithHexString:@"0x999999"];
    [footer addSubview:botlabel];

    UILabel *deslabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 150, kScreen_Width-10, 100)];
    deslabel.numberOfLines=0;
    deslabel.text=self.descrStr;
   // deslabel.textColor=[UIColor colorWithHexString:@"0x999999"];
    [footer addSubview:deslabel];

      _tableview.tableFooterView=footer;
  
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.textLabel.textColor=[UIColor colorWithHexString:@"0x999999"];
    UILabel *detLab=[[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width-200, 0, 190, 44)];
    detLab.text=_detailArray[indexPath.row];
    detLab.textAlignment=NSTextAlignmentRight;
    [cell.contentView addSubview:detLab];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,43,kScreen_Width,1)];
    v.backgroundColor=[UIColor colorWithHexString:@"0xeeeeee"];
    [cell.contentView addSubview:v];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *procode=self.procode;
//    NSString *hostId=[_hostList[indexPath.row] objectForKey:@"hostId"];
//}

@end
