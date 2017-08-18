//
//  TaskBookIngViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/12.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "TaskBookIngViewController.h"
#import "TaskBooksCell.h"

@interface TaskBookIngViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;



@end

@implementation TaskBookIngViewController

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    _publishBtn.hidden = NO;
//}
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    _publishBtn.hidden = YES;
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    
//    _publishBtn = [[UIButton alloc] init];
//    [_publishBtn setBackgroundImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
//    _publishBtn.frame =CGRectMake(WIDTH-30-[MyAdapter aDapter:77], HEIGHT-160, [MyAdapter aDapter:77], [MyAdapter aDapter:77]);
//    [_publishBtn addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [[UIApplication sharedApplication].keyWindow addSubview:_publishBtn];
    
    
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


#pragma mark   -----------下拉刷新-----------------
//下拉刷新
-(void)headerRefresh
{
    
    [self.tabBarController.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:1 atIndex:0];
    
    
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}



#pragma mark  ------UITableViewDelegate-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskBooksCell *cell = [TaskBooksCell taskBooksCellWithTableView:tableView];
    
    
    return cell;
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_svc pushViewController:_svc.breakDownDetailViewController];
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
