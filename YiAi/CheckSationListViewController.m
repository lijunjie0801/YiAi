//
//  CheckSationListViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/8/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "CheckSationListViewController.h"

@interface CheckSationListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSString *procode;
@property(nonatomic,strong)NSArray *hostList;
@end

@implementation CheckSationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"查岗选择";
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    self.tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableview];
    [self getListData];
    
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    self.procode=intentDic[@"procode"];
}
-(void)getListData{
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"projectId":self.procode};
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLHostList] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
            _hostList=dic[@"datas"][@"hostList"][@"hostList"];
        }else{
            [_svc showMessage:dic[@"msgs"]];
            [_svc hideLoadingView];
        }
        [self.tableview reloadData];
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];
        
        [self.tableview reloadData];
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _hostList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.textLabel.text=[_hostList[indexPath.row] objectForKey:@"hostName"];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,43,kScreen_Width,1)];
    v.backgroundColor=[UIColor colorWithHexString:@"0xc8c8c8"];
    [cell.contentView addSubview:v];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *procode=self.procode;
    NSString *hostid=[_hostList[indexPath.row] objectForKey:@"hostName"];
    [_svc pushViewController:_svc.checkJobViewController withObjects:@{@"procode":procode,@"hostId":hostid}];
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
