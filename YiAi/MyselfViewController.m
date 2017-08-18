//
//  MyselfViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/6.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "MyselfViewController.h"
#import "CommonCell.h"

@interface MyselfViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIView *headerView;

@property(nonatomic, strong) UIImageView *myheadImg;
@property(nonatomic, strong) UILabel *myNicknamelbl;

@property(nonatomic, strong) NSArray *itemsArray;
@property(nonatomic, strong) NSArray *itemsIcons;


@end

@implementation MyselfViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"woyun" image:[UIImage imageNamed:@"我的ICON"] tag:1];
        //self.tabBarItem.selectedImage=[UIImage imageNamed:@"shouye_sel"];
        self.title = @"个人中心";
        self.tabBarItem.title = @"个人中心";
        //调整tabbaritem中文字的位置
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.itemsArray = @[@[@"火灾报警"],@[@"推送消息",@"关于我们",@"系统设置"]];
    self.itemsIcons = @[@[@"yiershucheng"],@[@"yiershucheng",@"yiershucheng",@"yiershucheng"]];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-44) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.tableHeaderView = [self headerView];
    
    
    [self createRefresh];
    
}

-(UIView *)headerView
{
    if (!_headerView) {

        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -300, WIDTH, _tableView.frame.size.height/3)];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, -300, WIDTH, 300)];
        topView.backgroundColor = [AppAppearance sharedAppearance].mainColor;
        [_headerView addSubview:topView];
        
        
        
        UIImageView *myBackgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, _tableView.frame.size.height/3)];
        myBackgroundImg.image = [UIImage imageNamed:@"MyBackground"];
        [_headerView addSubview:myBackgroundImg];
        
        
        _myheadImg = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH-[MyAdapter aDapter:80])/2, (myBackgroundImg.frame.size.height-[MyAdapter aDapter:101]-5)/2, [MyAdapter aDapter:80], [MyAdapter aDapter:80])];
        _myheadImg.layer.masksToBounds = YES;
        _myheadImg.layer.cornerRadius = [MyAdapter aDapter:80]/2;
        _myheadImg.layer.borderWidth = 1;
        _myheadImg.layer.borderColor = [[AppAppearance sharedAppearance].whiteColor CGColor];
        [myBackgroundImg addSubview:_myheadImg];
        
        _myNicknamelbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_myheadImg.frame)+5, WIDTH, [MyAdapter aDapter:21])];
        _myNicknamelbl.textColor = [AppAppearance sharedAppearance].whiteColor;
        _myNicknamelbl.textAlignment = NSTextAlignmentCenter;
        _myNicknamelbl.font = [UIFont boldSystemFontOfSize:[MyAdapter fontDapter:16]];
        [myBackgroundImg addSubview:_myNicknamelbl];
        
        _myNicknamelbl.text = @"LDRHeart";
        _myheadImg.image = [UIImage imageNamed:@"default1"];
        

        
    }
    return _headerView;
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
    return self.itemsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.itemsArray[section];
    return array.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonCell *cell = [CommonCell commonCellWithTableView:tableView];
    cell.titlelbl.text = self.itemsArray[indexPath.section][indexPath.row];
    cell.iconImg.image = [UIImage imageNamed:self.itemsIcons[indexPath.section][indexPath.row]];
    

    // 设置箭头
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyAdapter aDapter:44];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        
    }else{
    
    
        if (indexPath.row ==0) {
            
            [_svc pushViewController:_svc.pushMessageViewController];
            
         
            
            
        }else if (indexPath.row ==1){
        
        }else{
        
            [_svc pushViewController:_svc.settingViewController];
            
        }
    }
}




-(BOOL)shouldShowBackItem
{
    return NO;
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
