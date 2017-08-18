//
//  BreakdownViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "ScreenViewController.h"
#import "BreakdownCell.h"
#import "BreakModel.h"
@interface ScreenViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    
    int pageNum;
}


@property(nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic, strong) NSString *hasMoreStr,*procode;

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.myTitle;

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    
    [self createRefresh];
    
}

-(void)setIntentDic:(NSDictionary *)intentDic
{
    self.myTitle = intentDic[@"title"];
    self.procode = intentDic[@"procode"];
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
//下拉刷新
-(void)headerRefresh
{
    pageNum = 0;
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    
    
    NSDictionary *param = @{@"appKey":[AppDataManager defaultManager].identifier,@"alarmType":@"4",@"handleType":@"3",@"page":[NSString stringWithFormat:@"%d",pageNum],@"pageSize":@10,@"proCode":self.procode};
    
    [_svc showLoadingWithMessage:@"加载中..." inView:[UIApplication sharedApplication].keyWindow];
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLGoodList] withParamer:param completionHandler:^(id responseObject) {
        NSLog(@"列表信息%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        
        if ([dic[@"status"] integerValue] ==100) {
            
            
            self.hasMoreStr = dic[@"datas"][@"Alarm"][@"page"][@"hasMore"];
            
            //首页列表信息
            self.dataArray = [BreakModel mj_objectArrayWithKeyValuesArray:dic[@"datas"][@"Alarm"][@"alarmList"]];
            
            
            
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
    
    
    
    
}


#pragma mark ------------上拉刷新-------------
-(void)footerRefresh
{
    
    if ([self.hasMoreStr intValue]>0) {
        
        
        pageNum++;
        NSDictionary *param = @{@"appKey":[AppDataManager defaultManager].identifier,@"alarmType":@"4",@"handleType":@"3",@"page":[NSString stringWithFormat:@"%d",pageNum],@"pageSize":@10,@"proCode":self.procode};
        
        [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLGoodList] withParamer:param completionHandler:^(id responseObject) {
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            
            if ([dic[@"status"] integerValue] ==100) {
                
                
                self.hasMoreStr = dic[@"datas"][@"Alarm"][@"page"][@"hasMore"];
                
                //首页列表信息
                NSArray *array = [BreakModel mj_objectArrayWithKeyValuesArray:dic[@"datas"][@"indexProcodes"][@"alarmList"]];
                
                [self.dataArray addObjectsFromArray:array];
                
                
            }else{
                
                
                
                
                [_svc showMessage:dic[@"msgs"]];
                
                
                
            }
            
            [_svc hideLoadingView];
            
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            
            
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
//-(void)headerRefresh
//{
//    
//    [self.tabBarController.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:1 atIndex:0];
//    
//    
//    [self.tableView reloadData];
//    [self.tableView.mj_header endRefreshing];
//}



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
    BreakdownCell *cell = [BreakdownCell breakDownCellWithTableView:tableView];
    cell.breakModel = self.dataArray[indexPath.section];
    
    return cell;
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [_svc pushViewController:_svc.breakDownDetailViewController];
     BreakModel *model=_dataArray[indexPath.section];
     [_svc pushViewController:_svc.breakDownDetailViewController withObjects:@{@"project":model.projectId,@"title":self.myTitle}];
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
