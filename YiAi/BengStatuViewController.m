//
//  BengStatuViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/7/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BengStatuViewController.h"
#import "BengStatuModel.h"
#import "BengStatuCell.h"
@interface BengStatuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSString *procode,*transforType,*hostId;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation BengStatuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.transforType;
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    self.view=_tableview;
    
    [self getListData];
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    self.procode=intentDic[@"procode"];
    self.hostId=intentDic[@"hostId"];
    self.transforType=intentDic[@"transforType"];
}
-(void)getListData{
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode,@"hostId":self.hostId,@"transforType":self.transforType,@"page":@"0",@"pageSize":@"9999"};
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLBengHomeDetail] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
            NSArray *array=dic[@"datas"][@"typeList"][@"typeList"];
            _dataArray = [BengStatuModel mj_objectArrayWithKeyValuesArray:array];
        }else{
            [_svc showMessage:dic[@"msgs"]];
            [_svc hideLoadingView];
        }
        [_tableview reloadData];
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];
        
        [_tableview reloadData];
        
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 314;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BengStatuModel *model=_dataArray[indexPath.row];
    BengStatuCell *cell = [BengStatuCell bengStatuCellWithTableView:tableView];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    cell.model=model;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
