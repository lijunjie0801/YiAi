//
//  PollingRecordDetailViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/29.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "PollingRecordDetailViewController.h"
#import "PollingViewCell.h"
#import "ImageBrowserViewController.h"
@interface PollingRecordDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSArray *itemsArray;
@property(nonatomic, strong) NSMutableArray *paramArray;
@property(nonatomic, strong) NSMutableArray *detialArray;
@property(nonatomic, strong) NSString *nfcFarImg,*nfcNearImg,*nfcDetailImg,*DomainUrl;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation PollingRecordDetailViewController
-(NSMutableArray *)paramArray{
    if (!_paramArray) {
        _paramArray=[NSMutableArray array];
    }
    return _paramArray;
}
-(NSMutableArray *)detialArray{
    if (!_detialArray) {
        _detialArray=[NSMutableArray array];
    }
    return _detialArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"巡查记录";
    
    self.itemsArray = @[@[@"项目名称",@"巡检人姓名",@"巡检时间",@"设备名称",@"编号",@"状态",@"备注"],@[@"设备近景",@"设备远景",@"设备周边环境"]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.tableFooterView = [self footerViews];
    _tableView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
//    _tableView.tableFooterView=[self setBottomView];
    [self createRefresh];
    
    
}
-(UIView *)setBottomView{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
    view.backgroundColor=[UIColor greenColor];
    return view;
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    NSMutableArray *marr=[NSMutableArray array];
    for (int i=0; i<7; i++) {
        NSString *index=[NSString stringWithFormat:@"param%d",i+1];
        NSString *param=[intentDic objectForKey:index];
        [marr addObject:param];
    }
    _paramArray=[marr mutableCopy];
    self.nfcNearImg=intentDic[@"nfcNearImg"];
    self.nfcFarImg=intentDic[@"nfcFarImg"];
    self.nfcDetailImg=intentDic[@"nfcDetailImg"];
    self.DomainUrl=intentDic[@"DomainUrl"];
    
    NSArray *array=[self.nfcDetailImg componentsSeparatedByString:@","];
    NSMutableArray *muarr=[NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        NSString *s=[NSString stringWithFormat:@"%@%@",self.DomainUrl,array[i]];
        [muarr addObject:s];
    }
    _detialArray=[muarr mutableCopy];

}

//-(UIView *)footerViews
//{
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, [MyAdapter aDapter:40]+40)];
//
//    UIButton *Btn = [[UIButton alloc] init];
//
//    [Btn setTitle:@"巡检" forState:UIControlStateNormal];
//    [Btn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
//    [Btn setBackgroundColor:[AppAppearance sharedAppearance].mainColor];
//    Btn.titleLabel.font = [MyAdapter fontADapter:16];
//    Btn.layer.cornerRadius = 6;
//    Btn.layer.masksToBounds = YES;
//
//    Btn.frame = CGRectMake(20, 20, self.view.frame.size.width-40, [MyAdapter aDapter:40]);
//    [Btn addTarget:self action:@selector(lookButtonAction) forControlEvents:UIControlEventTouchUpInside];
//
//    [footerView addSubview:Btn];
//
//
//
//    return footerView;
//
//}

//巡检
-(void)lookButtonAction
{
    
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
        cell.detailTextLabel.text = self.paramArray[indexPath.row];
        
    }else{
        
        
        PollingViewCell *cell = [PollingViewCell pollingViewCellWithTableView:tableView];
        cell.titleLbl.text=self.itemsArray[indexPath.section][indexPath.row];
        NSString *imgUrl;
        if (indexPath.row!=2) {
            if (indexPath.row==0) {
                imgUrl=_nfcNearImg;
            }else if (indexPath.row==1){
                imgUrl=_nfcFarImg;
            }
            cell.headImg.userInteractionEnabled=YES;
            cell.headImg.tag=indexPath.row;
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"NFC"]];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigtopView:)];
            [cell.headImg addGestureRecognizer:tap];

        }else{
            CGFloat width=(kScreen_Width-100)/3;
            for (int i=0; i<self.detialArray.count; i++) {
                UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(25+(25+width)*(i%3), 40+(i/3)*(width+20), width, width)];
                imgview.userInteractionEnabled=YES;
                imgview.tag=i;
                [cell.contentView addSubview:imgview];
                [imgview sd_setImageWithURL:[NSURL URLWithString:_detialArray[i]] placeholderImage:[UIImage imageNamed:@"NFC"]];
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigView:)];
                [imgview addGestureRecognizer:tap];
            }

        }
      
        return cell;
        
    }
    
    cell.textLabel.font = [MyAdapter fontADapter:16];
    cell.detailTextLabel.font = [MyAdapter fontADapter:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)bigtopView:(UIGestureRecognizer *)tap{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)tap;
    NSInteger i=[singleTap view].tag;
    if (i==0) {
        [ImageBrowserViewController show:self type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
            return @[self.nfcNearImg];
        }];
    }else{
        [ImageBrowserViewController show:self type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
            return @[self.nfcFarImg];
        }];
    }

}
-(void)bigView:(UIGestureRecognizer *)tap{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)tap;
    NSLog(@"%ld",[singleTap view].tag);
    [ImageBrowserViewController show:self type:PhotoBroswerVCTypeModal index:[singleTap view].tag imagesBlock:^NSArray *{
        return _detialArray;
    }];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width=(kScreen_Width-100)/3;
    if (indexPath.section==0) {
         return [MyAdapter aDapter:44];
    }else{
        if (indexPath.row!=2) {
            return [MyAdapter aDapter:50+width];
        }else{
            return [MyAdapter aDapter:50+((self.detialArray.count-1)/3+1)*(width+20)];
        }
        
    }
   
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
