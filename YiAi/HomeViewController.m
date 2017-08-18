//
//  HomeViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/6.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewCell.h"
//#import <CoreNFC/CoreNFC.h>
#import "HomeModel.h"
#import "LoginViewController.h"
//@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,NFCNDEFReaderSessionDelegate,NSXMLParserDelegate>
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>

{
    
    int pageNum;
}


@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIView *headerView;


@property (nonatomic, copy) NSString *currentElementName;
@property(nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic, strong) NSString *hasMoreStr;

//火警，水系统，通讯故障，故障，屏蔽，动作反馈
@property(nonatomic, strong) UILabel *fireLbl,*waterLbl,*comfaultLbl,*faultLbl,*shieldLbl,*cotionFeedbackLbl;


@end

@implementation HomeViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"woyun" image:[UIImage imageNamed:@"工程管理ICON-拷贝"] tag:1];
        //self.tabBarItem.selectedImage=[UIImage imageNamed:@"shouye_sel"];
        self.title = @"工程管理";
        self.tabBarItem.title = @"工程管理";
        //调整tabbaritem中文字的位置
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }
    return self;
}



-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage buildImageWithColor:[AppAppearance sharedAppearance].tabBarColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                      NSForegroundColorAttributeName:[AppAppearance sharedAppearance].whiteColor}];
    
    
    //系统消息的数目
    [self requestMessageNumData];
//    [self headerRefresh];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeRefresh:) name:@"homeRefresh" object:nil];
    
}
-(void)homeRefresh:(NSNotification *)noti{
    [self headerRefresh];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-44) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    
     _tableView.tableHeaderView = [self headerView];
//    
    [self createRefresh];

    [self headerRefresh];
//    NFCNDEFReaderSession *session = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT) invalidateAfterFirstRead:NO];
//    [session beginSession];
    
    
    
    
}


//- (void) readerSession:(nonnull NFCNDEFReaderSession *)session didDetectNDEFs:(nonnull NSArray *)messages {
//
//    NSLog(@"开启NFC的回调");
//
//    for (NFCNDEFMessage *message in messages) {
//
//        for (NFCNDEFPayload *payload in message.records) {
//
//            NSLog(@"Payload data:%@",payload.payload);
//        }
//    }
//}




-(UIView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, [MyAdapter aDapter:120]+40+20+10+[MyAdapter aDapter:40])];
//        _headerView.backgroundColor = [UIColor orangeColor];
        int totalCol = 4;
        NSArray *titleArray= @[@"火警",@"水系统",@"通讯故障",@"故障",@"屏蔽",@"动作反馈",@"我的工作",@"巡查"];
        NSArray *iconArray= @[@"火",@"形状-31",@"通讯故障",@"故障",@"屏蔽",@"反馈",@"形状-35",@"形状-36"];
        
        
        CGFloat marginTop=20;
        CGFloat viewW=[MyAdapter aDapter:40];
        
        for (int i=0; i<titleArray.count; i++) {
            
 
            CGFloat marginY=viewW;
            CGFloat x=(WIDTH/totalCol)*(i%totalCol);
            CGFloat y=marginTop+(viewW+marginY)*(i/totalCol);
            
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x+(WIDTH/totalCol-viewW)/2, y, viewW, viewW)];
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -[MyAdapter aDapter:50], -[MyAdapter aDapter:60], -[MyAdapter aDapter:10]);
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.font = [MyAdapter fontADapter:12];
            [button setImage:[UIImage imageNamed:iconArray[i]] forState:UIControlStateNormal];
            button.tag = i;
            button.imageView.contentMode = UIViewContentModeScaleAspectFill;
            
            
            
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_headerView addSubview:button];
            
            
            
            if (i<=5) {
                
                
                UILabel *numlbl = [[UILabel alloc] init];
                numlbl.frame = CGRectMake(CGRectGetMaxX(button.frame)-2, CGRectGetMinY(button.frame)-5, 16, 16);
                numlbl.hidden = YES;
                numlbl.layer.cornerRadius = 8;
                numlbl.backgroundColor = [AppAppearance sharedAppearance].redColor;
                numlbl.textAlignment = NSTextAlignmentCenter;
                numlbl.clipsToBounds = YES;
                numlbl.font = [UIFont systemFontOfSize:10];
                numlbl.textColor = [AppAppearance sharedAppearance].whiteColor;
                [_headerView addSubview:numlbl];
                
                //火警，水系统，通讯故障，故障，屏蔽，动作反馈
                if (i==0) {
                    
                    self.fireLbl = numlbl;
                }
                if (i==1){
                    
                    self.waterLbl = numlbl;
                }
                if (i==2){
                    self.comfaultLbl = numlbl;
                    
                }
                if (i==3){
                    
                    self.faultLbl = numlbl;
                }
                if (i==4){
                    self.shieldLbl = numlbl;
                    
                }
                if (i==5){
                    
                    self.cotionFeedbackLbl = numlbl;
                }
                
            }
            
            
//            self.numlbl.text = @"10";
            

            
        }
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, [MyAdapter aDapter:120]+40+20, WIDTH, 10+[MyAdapter aDapter:40])];
        [_headerView addSubview:footerView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 10)];
        line.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
        [footerView addSubview:line];
        
        UILabel *testlbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(line.frame)+[MyAdapter aDapter:19]/2, WIDTH-10, [MyAdapter aDapter:21])];
        testlbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
        testlbl.text = @"项目列表";
        testlbl.font = [UIFont boldSystemFontOfSize:[MyAdapter fontDapter:16]];
        [footerView addSubview:testlbl];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, footerView.frame.size.height-1, WIDTH, 1)];
        line1.backgroundColor = [AppAppearance sharedAppearance].cellLineColor;
        [footerView addSubview:line1];
        
        
        
    }
    
    return _headerView;
}



-(void)buttonClick:(UIButton *)btn

{
    
    switch (btn.tag) {
        case 0:
            //火警
            [_svc pushViewController:_svc.fireAlarmViewController withObjects:@{@"title":@"火警",@"procode":@""}];
            break;
            
        case 1:
            //水系统
            [_svc pushViewController:_svc.waterSystemViewController withObjects:@{@"title":@"水系统",@"procode":@""}];
            break;
        case 2:
            //通讯故障
         //   [_svc pushViewController:_svc.pollingRecordUploadViewController];
            [_svc pushViewController:_svc.conmunicationBreakdownViewController withObjects:@{@"title":@"通讯故障",@"procode":@""}];
            break;
        case 3:
            //故障
            [_svc pushViewController:_svc.breakdownViewController withObjects:@{@"title":@"故障",@"procode":@""}];
     
            break;
        case 4:
            //屏蔽
            //[_svc pushViewController:_svc.hCScanQRViewController];
            [_svc pushViewController:_svc.screenViewController withObjects:@{@"title":@"屏蔽",@"procode":@""}];
            break;
        case 5:
            //动作反馈
            //[_svc pushViewController:_svc.addNFCequipmentViewController];
             [_svc pushViewController:_svc.motionFeedbackViewController withObjects:@{@"title":@"动作反馈",@"procode":@""}];
            break;
        case 6:
            //我的工作
            [_svc pushViewController:_svc.myWorkViewController];
            break;
        case 7:
            //巡查
           // [_svc pushViewController:_svc.pollingRecordViewController];
            [_svc pushViewController:_svc.NFCViewController];

            break;
            
        default:
            break;
    }
    
    
    
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
    
    

//    [self headerRefresh];
    
}


#pragma mark   -----------下拉刷新-----------------
//下拉刷新
-(void)headerRefresh
{
    
    
    if ([AppDataManager defaultManager].hasLogin) {
        
        
        pageNum = 0;
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
        
        
        NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"page":[NSString stringWithFormat:@"%d",pageNum],@"pageSize":@10};
        
        [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLHome] withParamer:param completionHandler:^(id responseObject) {
            
            
            NSLog(@"首页数据:%@",responseObject);
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            
            if ([dic[@"status"] integerValue] ==100) {
                
                
                self.hasMoreStr = dic[@"datas"][@"indexProcodes"][@"page"][@"hasMore"];
                
                //首页列表信息
                self.dataArray = [HomeModel mj_objectArrayWithKeyValuesArray:dic[@"datas"][@"indexProcodes"][@"projectList"]];
                
        
                
            }else{
                
                [_svc showMessage:dic[@"msgs"]];
                
                [_svc hideLoadingView];

            }
            
            
            
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
            
        } failureHandler:^(NSError *error, NSUInteger statusCode) {
            
            
            [_svc showMessage:error.domain];
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
        }];
        
        
        
//        // 1、创建URL
//        NSURL *url = [NSURL URLWithString:KBaseURL];
//        // 2、创建请求对象
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//        request.HTTPMethod = @"POST";
//        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        [request setValue:@"http://eiremote.org/indexProcodes" forHTTPHeaderField:@"SOAPAction"];
//
//        NSString *reqBody = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
//                             <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
//                             <soap:Body>\
//                             <indexProcodes xmlns=\"http://eiremote.org/\">\
//                             <appKey>%@</appKey>\
//                             <page>%@</page>\
//                             <pageSize>%@</pageSize>\
//                             </indexProcodes>\
//                             </soap:Body>\
//                             </soap:Envelope>",[AppDataManager defaultManager].identifier,[NSString stringWithFormat:@"%d",pageNum],@10];
//        // 3、设置body
//        NSData *reqData = [reqBody dataUsingEncoding:NSUTF8StringEncoding];
//        request.HTTPBody = reqData;
//
//
//        [RequestManager requestManagerWidhRequest:request success:^(id responseObject) {
//
//            NSData *jsonData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
//
//            //2.将NSData解析为NSDictionary
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                                options:NSJSONReadingMutableContainers
//                                                                  error:nil];
//
//            NSLog(@"结果=========%@",dic);
//
//            if ([dic[@"status"] integerValue] ==100) {
//
//
//                self.hasMoreStr = dic[@"datas"][@"indexProcodes"][@"page"][@"hasMore"];
//
//
//                //首页列表信息
//                self.dataArray = [HomeModel mj_objectArrayWithKeyValuesArray:dic[@"datas"][@"indexProcodes"][@"projectList"]];
//
//                NSLog(@"获取数据");
//
//            }else{
//
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//                    [_svc showMessage:dic[@"msgs"]];
//
//                    [_svc hideLoadingView];
//
//                });
//
//
//            }
//
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                [self.tableView reloadData];
//                [self.tableView.mj_header endRefreshing];
//
//            });
//
//
//
//
//        } failure:^(NSError *error) {
//
//
//            [_svc showMessage:error.domain];
//
//            [self.tableView reloadData];
//            [self.tableView.mj_header endRefreshing];
//
//        }];
//
//
//
//
//
    }
    
        

    
    
    
    
    
    
    [self.tabBarController.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:1 atIndex:0];
    
    
    
    
}

//上拉刷新
-(void)footerRefresh
{
    if ([self.hasMoreStr intValue] >0) {
        
        pageNum ++;
        
        
        NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"page":[NSString stringWithFormat:@"%d",pageNum],@"pageSize":@10};
        
        [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLHome] withParamer:param completionHandler:^(id responseObject) {
            
            
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            if ([dic[@"status"] integerValue] ==100) {
                
                
                self.hasMoreStr = dic[@"datas"][@"indexProcodes"][@"page"][@"hasMore"];
                
                
                //首页列表信息
                NSArray *array= [HomeModel mj_objectArrayWithKeyValuesArray:dic[@"datas"][@"indexProcodes"][@"projectList"]];
                
                [self.dataArray addObjectsFromArray:array];
                
                
                
                
            }else{
                
                [_svc showMessage:dic[@"msgs"]];
                
                [_svc hideLoadingView];
                
            }
            
            
            
            
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            
            
        } failureHandler:^(NSError *error, NSUInteger statusCode) {
            
            
            [_svc showMessage:error.domain];
            
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            
        }];
        
    }else{
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }
    
}


//获取消息的数目
-(void)requestMessageNumData
{
    
    if ([AppDataManager defaultManager].hasLogin) {
        
        
        NSDictionary *param = @{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":@""};
        
        [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLHomeMessageNum] withParamer:param completionHandler:^(id responseObject) {
            
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSLog(@"消息的数目===%@",dic);
            
            dic = dic[@"datas"][@"indexAlarmNums"][@"AlarmListNums"];
            
            //火警数量
            NSString *fireCount = dic[@"fireCount"];
            
            if ([fireCount intValue]>0) {
                
                self.fireLbl.hidden = NO;
                self.fireLbl.text = fireCount;
                
            }else{
                
                self.fireLbl.hidden = YES;
            }
            
            
            //水警数量
            NSString *waterCount = dic[@"waterCount"];
            
            if ([waterCount intValue]>0) {
                
                self.waterLbl.hidden = NO;
                self.waterLbl.text = waterCount;
                
            }else{
                
                self.waterLbl.hidden = YES;
            }
            
            
            //通讯故障
            NSString *comFaultCount = dic[@"comFaultCount"];
            if ([comFaultCount intValue]>0) {
                
                self.comfaultLbl.hidden = NO;
                self.comfaultLbl.text = comFaultCount;
                
            }else{
                
                self.comfaultLbl.hidden = YES;
            }
            
            //故障
            NSString *faultCount = dic[@"faultCount"];
            if ([faultCount intValue]>0) {
                
                self.faultLbl.hidden = NO;
                self.faultLbl.text = faultCount;
                
            }else{
                
                self.faultLbl.hidden = YES;
            }
            
            //屏蔽
            NSString *shieldCount = dic[@"shieldCount"];
            if ([shieldCount intValue]>0) {
                
                self.shieldLbl.hidden = NO;
                self.shieldLbl.text = shieldCount;
                
            }else{
                
                self.shieldLbl.hidden = YES;
            }
            
            //动作反馈
            NSString *cotionFeedbackCount = dic[@"cotionFeedbackCount"];
            if ([cotionFeedbackCount intValue]>0) {
                
                self.cotionFeedbackLbl.hidden = NO;
                self.cotionFeedbackLbl.text = cotionFeedbackCount;
                
            }else{
                
                self.cotionFeedbackLbl.hidden = YES;
            }
            
            
            [_svc hideLoadingView];
            [self.tableView reloadData];
            
            
            
        } failureHandler:^(NSError *error, NSUInteger statusCode) {
            
            
            [_svc hideLoadingView];
            [_svc showMessage:error.domain];
            
            
            
            
        }];
        
        
    }
}




#pragma mark -------UITableViewDelegate------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    HomeViewCell *cell = [HomeViewCell homeViewCellWithTableView:tableView];
    
    cell.model = (HomeModel *)self.dataArray[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeModel *model=self.dataArray[indexPath.row];
    [_svc pushViewController:_svc.homeDetailViewController withObjects:@{@"procode":model.proCode,@"proname":model.projectName}];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyAdapter aDapter:100]+20;
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
