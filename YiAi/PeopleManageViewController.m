//
//  PeopleManageViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/14.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "PeopleManageViewController.h"
#import "PeopleManageCell.h"

@interface PeopleManageViewController ()<UITableViewDataSource, UITableViewDelegate,PeopleDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSString *procode;



@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PeopleManageViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"人员管理";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _tableView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    
    [self createRefresh];
    
}

//刷新
-(void)createRefresh
{
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf headerRefresh];
        
    }];
    
    
    
    [self headerRefresh];
    
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    self.procode=intentDic[@"procode"];
   
}

#pragma mark   -----------下拉刷新-----------------
//下拉刷新
-(void)headerRefresh
{
    
//    [self.tabBarController.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:1 atIndex:0];
//    
//    
//    [self.tableView reloadData];
//    [self.tableView.mj_header endRefreshing];
     NSDictionary *param = @{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode};
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLPersonList] withParamer:param completionHandler:^(id responseObject) {
        NSLog(@"人员列表%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
             NSArray *dataArray=responseObject[@"datas"][@"staffList"];
            _dataArray=[dataArray mutableCopy];
            [self.tableView reloadData];
        }
       
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        
    }];
   
}



#pragma mark  ------UITableViewDelegate-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array=[_dataArray[section] objectForKey:@"ProjectPersonMessagesList"];;
    return array.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PeopleManageCell *cell = [PeopleManageCell peopleManageCellWithTableView:tableView];
    cell.delegate=self;
    NSDictionary *dic=[_dataArray[indexPath.section] objectForKey:@"ProjectPersonMessagesList"][indexPath.row];
    cell.indexSection=[NSString stringWithFormat:@"%ld",indexPath.section];
    cell.indexRow=[NSString stringWithFormat:@"%ld",indexPath.row];
    [cell updateWithDic:dic];
    return cell;
    
    
}
-(void)Call:(NSString *)section :(NSString *)row{
    NSInteger sec=[section integerValue];
    NSDictionary *dic=[_dataArray[sec] objectForKey:@"ProjectPersonMessagesList"][[row integerValue]];
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",dic[@"tel"]];
    // NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];


}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [_svc pushViewController:_svc.breakDownDetailViewController];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyAdapter aDapter:60]+20;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [MyAdapter aDapter:40];
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, [MyAdapter aDapter:40])];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, [MyAdapter aDapter:19]/2, WIDTH-10, [MyAdapter aDapter:21])];
    
    lbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    lbl.font = [UIFont boldSystemFontOfSize:[MyAdapter fontDapter:16]];
    [topView addSubview:lbl];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, topView.frame.size.height-1, WIDTH, 1)];
    line.backgroundColor = [AppAppearance sharedAppearance].cellLineColor;
//    [topView addSubview:line];
    
    topView.backgroundColor = [UIColor whiteColor];
    
    if (section ==0) {
        
        lbl.text = @"责任人";
    }else{
    
        lbl.text = @"消防工程师";
    }
    
    return topView;
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
