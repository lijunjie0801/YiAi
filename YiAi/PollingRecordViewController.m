//
//  PollingRecordViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/27.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "PollingRecordViewController.h"
#import "TaskBooksCell.h"
#import "NFCModel.h"
@interface PollingRecordViewController ()<UITableViewDataSource, UITableViewDelegate>{
    
    int pageNum;
}

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic, strong) NSString *hasMoreStr;
@property(nonatomic, strong) NSString *nfcCode;
@property(nonatomic, strong) NSString *proCodeName;
@property(nonatomic, strong) NSString *deviceName;
@end

@implementation PollingRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"巡检记录";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
   // [self headerRefresh];
    [self createRefresh];
    
}
-(void)getRecordData{
    
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    self.nfcCode=intentDic[@"nfcCode"];
    self.proCodeName=intentDic[@"proCodeName"];
    self.deviceName=intentDic[@"deviceName"];
}

//刷新
-(void)createRefresh
{
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf headerRefresh];
        
    }];
    
    
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf footerRefresh];
    }];
    
    
    [self headerRefresh];
    
}
-(void)footerRefresh
{
    
    if ([self.hasMoreStr intValue]>0) {
        
        
        pageNum++;

        NSDictionary *param = @{@"nfcCode":self.nfcCode,@"page":[NSString stringWithFormat:@"%d",pageNum],@"pageSize":@10};
        [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLHistory] withParamer:param completionHandler:^(id responseObject) {
            
            
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            
            if ([dic[@"status"] integerValue] ==100) {
                
                
                self.hasMoreStr = dic[@"datas"][@"indexProcodes"][@"page"][@"hasMore"];
                
                //            列表信息
                self.dataArray = [NFCModel mj_objectArrayWithKeyValuesArray:dic[@"datas"][@"indexProcodes"][@"projectList"]];
                
                
                
            }else{
                
                [_svc showMessage:dic[@"msgs"]];
                
                
            }
            
            
            [_svc hideLoadingView];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            

            
            
        } failureHandler:^(NSError *error, NSUInteger statusCode) {
            
            [_svc hideLoadingView];
            [_svc showMessage:error.domain];
            
        }];
        
        
        
    }else{
        
        [self.tableView.mj_footer endRefreshing];
        
    }
    
    
    
}


#pragma mark   -----------下拉刷新-----------------
//下拉刷新
-(void)headerRefresh
{
//    
//    [self.tabBarController.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:1 atIndex:0];
//    
//    
//    [self.tableView reloadData];
//    [self.tableView.mj_header endRefreshing];
    
    pageNum = 0;
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    
    
    NSDictionary *param = @{@"nfcCode":self.nfcCode,@"page":@0,@"pageSize":@10};
    
    [_svc showLoadingWithMessage:@"加载中..." inView:[UIApplication sharedApplication].keyWindow];
    
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLHistory] withParamer:param completionHandler:^(id responseObject) {
        
        

        NSDictionary *dic = (NSDictionary *)responseObject;
        
        
        if ([dic[@"status"] integerValue] ==100) {
            
            
           self.hasMoreStr = dic[@"datas"][@"indexProcodes"][@"page"][@"hasMore"];
            
//            列表信息
            self.dataArray = [NFCModel mj_objectArrayWithKeyValuesArray:dic[@"datas"][@"indexProcodes"][@"projectList"]];
            
            
            
        }else{
            
            [_svc showMessage:dic[@"msgs"]];
            
            
        }
        
        
        [_svc hideLoadingView];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
        [_svc hideLoadingView];
        [_svc showMessage:error.domain];
        
    }];
    
    
    
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];

}



#pragma mark  ------UITableViewDelegate-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskBooksCell *cell = [TaskBooksCell taskBooksCellWithTableView:tableView];
    cell.NFCModel=self.dataArray[indexPath.section];
    cell.titleLbl.text = self.proCodeName;
//    cell.numLbl.text = @"巡检人姓名";
//    cell.addressLbl.text = @"黄山大厦A座";
//    cell.timeLbl.text = @"2017/06/22 06:30";
//    [cell.typeBtn setTitle:@"正常" forState:UIControlStateNormal];
//    cell.typeBtn.backgroundColor = [AppAppearance sharedAppearance].mainColor;
    
    
    return cell;
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NFCModel *model=self.dataArray[indexPath.section];
    NSString *nfcFarImg=[NSString stringWithFormat:@"%@%@",model.DomainUrl,model.nfcFarImg];
     NSString *nfcNearImg=[NSString stringWithFormat:@"%@%@",model.DomainUrl,model.nfcNearImg];
    [_svc pushViewController:_svc.pollingRecordDetailViewController withObjects:@{@"param1":self.proCodeName,@"param2":model.nfcPatrolPerson,@"param3":model.nfcPatrolTime,@"param4":self.deviceName,@"param5":self.nfcCode,@"param6":model.nfcStatus,@"param7":model.nfcRemark,@"nfcFarImg":nfcFarImg,@"nfcNearImg":nfcNearImg,@"nfcDetailImg":model.nfcDetailImg,@"DomainUrl":model.DomainUrl}];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyAdapter aDapter:63]+36;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
