//
//  LookNFCequipmentViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/23.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "LookNFCequipmentViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ImageBrowserViewController.h"

@interface LookNFCequipmentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *imageArray;
@property(nonatomic, strong) NSArray *itemsArray;
@property(nonatomic, strong) NSString *proCodeName;
@property(nonatomic, strong) NSString *deviceName,*addressstr;
@property(nonatomic, strong) NSMutableArray *contentArray;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *proNameArray;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, strong) NSDictionary *dictionarray;

@property(nonatomic, strong) NSString *nearImg;

@property(nonatomic, strong) NSString *farImg;

@property(nonatomic, strong) NSString *ImgUrl;

/**
 *  URL数组
 */
@property (nonatomic,strong) NSMutableArray *bigImgUrls;
@end

@implementation LookNFCequipmentViewController

-(NSMutableArray *)bigImgUrls{
    
    if (!_bigImgUrls) {
        
        // 加载plist中的字典数组
        _bigImgUrls=[NSMutableArray array];
        
    }
    
    return _bigImgUrls;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getprocode];
    // Do any additional setup after loading the view.
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc] initWithTitle:@"修改"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(skip)];
   self.navigationItem.rightBarButtonItem = btn1;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.title = @"查看设备";
    
    self.itemsArray = @[@[@"项目名称",@"设备名称",@"设备类型",@"设备编号",@"编号",@"状态",@"责任人",@"安装时间",@"到期时间"],@[@"设备近景",@"设备远景",@"周边环境"],@[@"巡检记录"]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
   // _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [self footerViews];
    _tableView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    
    [self getNFCData];
    

}
-(void)skip{
    [_svc pushViewController:_svc.editDeviceInfoController withObjects:@{@"proName":self.contentArray[0],@"deviceName":self.contentArray[1],@"deviceNum":self.address,@"num":self.contentArray[4],@"address":self.addressstr,@"person":self.contentArray[6],@"install":self.contentArray[7],@"due":self.contentArray[8],@"pronames":self.proNameArray,@"dic":self.dictionarray}];
}
-(void)setIntentDic:(NSDictionary *)intentDic
{
    self.address = intentDic[@"address"];
}
-(void)getprocode{
    NSString *appKey=[AppDataManager defaultManager].identifier;
    NSDictionary *param = @{@"appKey":appKey};
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLGetProCode] withParamer:param completionHandler:^(id responseObject) {
        NSLog(@"procode：%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            NSArray *array=responseObject[@"datas"][@"Procodes"][@"projectList"];
            NSMutableArray *muarray=[NSMutableArray array];
            NSMutableDictionary *diction=[NSMutableDictionary dictionary];
            for (NSDictionary *dic in array) {
                [muarray addObject:dic[@"proCodeName"]];
                [diction setObject:dic[@"proCode"] forKey:dic[@"proCodeName"]];
            }
            self.proNameArray=[muarray mutableCopy];
            self.dictionarray =diction;
        }
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        NSLog(@"procode：%@",error);
    }];
}
-(void)getNFCData{
    NSDictionary *param = @{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":@"",@"nfcCode":self.address};
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLNFCInfo] withParamer:param completionHandler:^(id responseObject) {
        
        NSLog(@"NFC数据：%@",responseObject);
        NSDictionary *dic=responseObject[@"datas"][@"getNfcDevice"][@"detail"];
        if ([responseObject[@"status"] integerValue]==100) {
            NSMutableArray *marr=[NSMutableArray array];
            NSString *param1=dic[@"proCodeName"];
            NSString *param2=dic[@"deviceName"];
            NSString *param3=[NSString stringWithFormat:@"%@%@",dic[@"deviceType"],dic[@"deviceSecondType"]];
            NSString *param4=self.address;
            NSString *param5=dic[@"number"];
            NSString *param6=dic[@"status"];
            NSString *param7=dic[@"personPetect"];
            NSString *param8=dic[@"installTime"];
            NSString *param9=dic[@"dueTime"];
            self.addressstr=dic[@"position"];
            self.proCodeName=param1;
            self.deviceName=param2;
            [marr addObject:param1];
            [marr addObject:param2];
            [marr addObject:param3];
            [marr addObject:param4];
            [marr addObject:param5];
            [marr addObject:param6];
            [marr addObject:param7];
            [marr addObject:param8];
            [marr addObject:param9];
            self.contentArray =[marr mutableCopy];
            _nearImg=[NSString stringWithFormat:@"%@%@",dic[@"domainurl"],dic[@"nfcNearImg"]];
            self.farImg=[NSString stringWithFormat:@"%@%@",dic[@"domainurl"],dic[@"nfcFarImg"]];
            NSString *nfcDetailImg=dic[@"nfcDetailImg"];
            NSArray *array=[nfcDetailImg componentsSeparatedByString:@","];
           // _bigImgUrls=[array mutableCopy];
            NSMutableArray *muarr=[NSMutableArray array];
            for (int i=0; i<array.count; i++) {
                NSString *s=[NSString stringWithFormat:@"%@%@",dic[@"domainurl"],array[i]];
                [muarr addObject:s];
            }
            _bigImgUrls = [muarr mutableCopy];
            [self.tableView reloadData];
        }
      
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        NSLog(@"NFC错误：%@",error);
    }];

}

-(UIView *)footerViews
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, [MyAdapter aDapter:40]+40)];
    
    UIButton *Btn = [[UIButton alloc] init];
    
    [Btn setTitle:@"巡检" forState:UIControlStateNormal];
    [Btn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    [Btn setBackgroundColor:[AppAppearance sharedAppearance].mainColor];
    Btn.titleLabel.font = [MyAdapter fontADapter:16];
    Btn.layer.cornerRadius = 6;
    Btn.layer.masksToBounds = YES;
    
    Btn.frame = CGRectMake(20, 20, self.view.frame.size.width-40, [MyAdapter aDapter:40]);
    [Btn addTarget:self action:@selector(lookButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:Btn];
    
    
    
    return footerView;
    
}

//巡检
-(void)lookButtonAction
{
    [_svc pushViewController:_svc.pollingRecordUploadViewController withObjects:@{@"nfcCode":self.address}];
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
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}


#pragma mark  ------------UITableViewDelegate----------
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
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.itemsArray[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        
        cell.textLabel.textColor = [AppAppearance sharedAppearance].title3TextColor;
        cell.detailTextLabel.textColor = [AppAppearance sharedAppearance].titleTextColor;
//        cell.detailTextLabel.text = @"获取的信息";
          cell.detailTextLabel.text =self.contentArray[indexPath.row];
    }else{
        
        
        cell.textLabel.textColor = [AppAppearance sharedAppearance].titleTextColor;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = @"";
        
    }
    
    cell.textLabel.font = [MyAdapter fontADapter:16];
    cell.detailTextLabel.font = [MyAdapter fontADapter:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [MyAdapter aDapter:44];
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *foooter = [[UIView alloc] init];
    foooter.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    return foooter;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            
            NSLog(@"%@",_nearImg);
            [ImageBrowserViewController show:self type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
                return @[_nearImg];
            }];

            
        }else if (indexPath.row==1){
            NSLog(@"%@",_farImg);
            [ImageBrowserViewController show:self type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
                return @[_farImg];
            }];

        }else{
            NSLog(@"%@",_bigImgUrls);
            [ImageBrowserViewController show:self type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
                return _bigImgUrls;
            }];

        }
           }
    if (indexPath.section==2) {
        [_svc pushViewController:_svc.pollingRecordViewController withObjects:@{@"nfcCode":self.address,@"proCodeName":self.proCodeName,@"deviceName":self.deviceName}];
    }

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
