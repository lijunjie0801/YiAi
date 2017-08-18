//
//  BreakDownDetailViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BreakDownDetailViewController.h"
#import "BreakDownDetailCell.h"
#import "FireDetailModel.h"
@interface BreakDownDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIView *headerView;
@property(nonatomic, strong) UIView *footerView;

@property(nonatomic, strong) UIButton *typeBtn;
@property(nonatomic, strong) UILabel *titleLbl,*detailLbl,*timeLbl;

@property(nonatomic, strong) UIView *cellView;

//名称,设备，地址，联系人
@property(nonatomic, strong) UILabel *nameLbl,*facililtyLbl,*addressNameLbl,*addressLbl,*linkmanLbl;
@property(nonatomic, strong) UIButton *progressBtn;


@property(nonatomic, strong) NSString *projectId;
@property(nonatomic, strong) NSString *myTitle;
@property(nonatomic, strong) NSString *addressLb;
@property(nonatomic, strong) NSMutableArray *handleList;

@end

@implementation BreakDownDetailViewController
-(NSMutableArray *)handleList{
    if (!_handleList) {
        _handleList=[NSMutableArray array];
    }
    return _handleList;
}
-(void)setIntentDic:(NSDictionary *)intentDic
{
    self.projectId = intentDic[@"project"];
    self.myTitle = intentDic[@"title"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"%@详情",self.myTitle];
    
    self.view.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, WIDTH-20, HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.tableHeaderView = [self headerViews];
    
    _tableView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    [self getDetailData];
}

-(void)getDetailData{
    
    
    
    NSDictionary *param = @{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":@"",@"fireId":self.projectId};

   [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLFireDetail] withParamer:param completionHandler:^(id responseObject) {
       
      NSLog(@"火警详情数据：%@",responseObject);
       if ([responseObject[@"status"] integerValue]==100) {
           self.addressLbl.text=responseObject[@"datas"][@"fireDetail"][@"fireDetail"][@"fireAddress"];
           NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:self.addressLbl.text];
           NSRange contentRange = {0,[content length]};
           [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
           self.addressLbl.attributedText = content;

           NSString *name=responseObject[@"datas"][@"fireDetail"][@"fireDetail"][@"firstPersonName"];
            NSString *phonenum=responseObject[@"datas"][@"fireDetail"][@"fireDetail"][@"firstPersonTel"];
           NSMutableAttributedString *contentLinkman = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"联系人：%@，%@",name,phonenum]];
           NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [AppAppearance sharedAppearance].mainColor,NSForegroundColorAttributeName,[MyAdapter fontADapter:14],NSFontAttributeName,nil, nil];
           
           [contentLinkman setAttributes:attrs range:NSMakeRange([contentLinkman length]-11,11)];
           NSRange contentRangeLinkman = {[contentLinkman length]-11,11};
           [contentLinkman addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRangeLinkman];
           self.linkmanLbl.attributedText = contentLinkman;

           NSString *equipType=responseObject[@"datas"][@"fireDetail"][@"fireDetail"][@"equipType"];
           self.facililtyLbl.text=[NSString stringWithFormat:@"设备：%@",equipType];
           
           NSString *basePosition=responseObject[@"datas"][@"fireDetail"][@"fireDetail"][@"basePosition"];
           self.nameLbl.text=[NSString stringWithFormat:@"名称：%@",basePosition];
           
           NSString *projectName=responseObject[@"datas"][@"fireDetail"][@"fireDetail"][@"projectName"];
           self.titleLbl.text=projectName;
           
           NSString *localPosition=responseObject[@"datas"][@"fireDetail"][@"fireDetail"][@"localPosition"];
           self.detailLbl.text=[NSString stringWithFormat:@"地址：%@",localPosition];
           
           NSString *alarmTime=responseObject[@"datas"][@"fireDetail"][@"fireDetail"][@"alarmTime"];
           self.timeLbl.text = alarmTime;
          
           
           NSArray *arr=responseObject[@"datas"][@"fireDetail"][@"handleList"];
           NSMutableArray *muAarray=[NSMutableArray array];
           for (NSDictionary *dic in arr) {
               FireDetailModel *model = [[FireDetailModel alloc] init];
               [model setValuesForKeysWithDictionary:dic];
               [muAarray addObject:model];
           }
           _handleList=[muAarray mutableCopy];
            [self.tableView reloadData];
           
       }
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        NSLog(@"火警详情错误：%@",error);
    }];
}

-(UIView *)headerViews
{
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, [MyAdapter aDapter:227]+60)];
        _headerView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _headerView.frame.size.width, [MyAdapter aDapter:80]/3+10)];
        topView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
        [_headerView addSubview:topView];
        
        
        _typeBtn = [[UIButton alloc] initWithFrame:CGRectMake((_tableView.frame.size.width-[MyAdapter aDapter:80])/2, 10, [MyAdapter aDapter:80], [MyAdapter aDapter:80])];
        _typeBtn.backgroundColor = [AppAppearance sharedAppearance].yellowColor;
        _typeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:[MyAdapter fontDapter:25]];
        _typeBtn.layer.masksToBounds = YES;
        _typeBtn.layer.cornerRadius = [MyAdapter aDapter:80]/2;
        [_headerView addSubview:_typeBtn];
        [_typeBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
        [_typeBtn setTitle:self.myTitle forState:UIControlStateNormal];
        
        
        self.titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_typeBtn.frame)+5, _headerView.frame.size.width-20, [MyAdapter aDapter:21])];
        self.titleLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
        self.titleLbl.font = [MyAdapter fontADapter:16];
        [self.headerView addSubview:self.titleLbl];
        
        
        
        
        
        self.detailLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLbl.frame)+5, 100, [MyAdapter aDapter:21])];
        self.detailLbl.textColor = [AppAppearance sharedAppearance].title3TextColor;
        self.detailLbl.font = [MyAdapter fontADapter:14];
        [self.headerView addSubview:self.detailLbl];
        
        
        self.timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(_headerView.frame.size.width-110, CGRectGetMaxY(self.titleLbl.frame)+5, 100, [MyAdapter aDapter:21])];
        self.timeLbl.textColor = [AppAppearance sharedAppearance].title3TextColor;
        self.timeLbl.textAlignment = NSTextAlignmentRight;
        self.timeLbl.font = [MyAdapter fontADapter:14];
        [self.headerView addSubview:self.timeLbl];
        
        
        //下划线
        self.cellView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.detailLbl.frame)+5, _headerView.frame.size.width, 1)];
        self.cellView.backgroundColor = [AppAppearance sharedAppearance].cellLineColor;
        [self.headerView addSubview:self.cellView];
        
        
        //名称
        self.nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.cellView.frame)+5, _headerView.frame.size.width-20, [MyAdapter aDapter:21])];
        self.nameLbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
        self.nameLbl.font = [MyAdapter fontADapter:14];
        [self.headerView addSubview:self.nameLbl];
        
        
        self.progressBtn = [[UIButton alloc] initWithFrame:CGRectMake(_headerView.frame.size.width-10-60, CGRectGetMaxY(self.nameLbl.frame)+5, 60, [MyAdapter aDapter:21])];
        self.progressBtn.titleLabel.font = [MyAdapter fontADapter:14];
        self.progressBtn.backgroundColor = [AppAppearance sharedAppearance].yellowColor;
        [self.headerView addSubview:self.progressBtn ];
        
        
        
        //设备
        self.facililtyLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.nameLbl.frame)+5, _headerView.frame.size.width-20, [MyAdapter aDapter:21])];
        self.facililtyLbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
        self.facililtyLbl.font = [MyAdapter fontADapter:14];
        [self.headerView addSubview:self.facililtyLbl];
        
        //地址
        self.addressNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.facililtyLbl.frame)+5, 50, [MyAdapter aDapter:21])];
        self.addressNameLbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
        self.addressNameLbl.text = @"地址：";
        self.addressNameLbl.font = [MyAdapter fontADapter:14];
        [self.headerView addSubview:self.addressNameLbl];
        
        //详细地址：
        self.addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(self.facililtyLbl.frame)+3, _headerView.frame.size.width-60, [MyAdapter aDapter:21])];
        self.addressLbl.numberOfLines = 0;
        self.addressLbl.textColor = [AppAppearance sharedAppearance].mainColor;
        self.addressLbl.font = [MyAdapter fontADapter:14];
        [self.headerView addSubview:self.addressLbl];
        
//        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"合肥市蜀山区望江西路与创业大道交叉口"]];
//        NSRange contentRange = {0,[content length]};
//        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
//        
//        self.addressLbl.attributedText = content;
        
        
        //联系人
        self.linkmanLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.addressLbl.frame)+5,_headerView.frame.size.width-20, [MyAdapter aDapter:21])];
        self.linkmanLbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
        self.linkmanLbl.font = [MyAdapter fontADapter:14];
        [self.headerView addSubview:self.linkmanLbl];

        NSMutableAttributedString *contentLinkman = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"联系人：刘亦菲，187-0986-2532"]];
        
        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                [AppAppearance sharedAppearance].mainColor,NSForegroundColorAttributeName,[MyAdapter fontADapter:14],NSFontAttributeName,nil, nil];
        
        [contentLinkman setAttributes:attrs range:NSMakeRange([contentLinkman length]-13,13)];
        NSRange contentRangeLinkman = {[contentLinkman length]-13,13};
        [contentLinkman addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRangeLinkman];
        
        
        
        self.linkmanLbl.attributedText = contentLinkman;
        
        
        
        
        
        
        
        
        //填入数据
        
        
        self.titleLbl.text = @"1号楼12层12分区";
        self.detailLbl.text = @"设计组办公室";
        self.timeLbl.text = @"2015/06/07 06:30";
        
        //计算时间的长度
         CGFloat timeW = [self.timeLbl.text boundingRectWithSize:CGSizeMake(MAXFLOAT, [MyAdapter aDapter:21]) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[MyAdapter fontADapter:14]} context:nil].size.width+10;
        
        self.timeLbl.frame = CGRectMake(_headerView.frame.size.width-10-timeW, CGRectGetMaxY(self.titleLbl.frame)+5, timeW, [MyAdapter aDapter:21]);
        self.detailLbl.frame = CGRectMake(10, CGRectGetMaxY(self.titleLbl.frame)+5, _headerView.frame.size.width-30-timeW, [MyAdapter aDapter:21]);
        
        self.nameLbl.text = @"名称：黄山大厦A座";
        self.facililtyLbl.text = @"设备：烟雾探头";
        
        
        //计算处理进度的长度
        [self.progressBtn setTitle:@"处理中" forState:UIControlStateNormal];;
        CGFloat typeW = [self.progressBtn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, [MyAdapter aDapter:21]) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[MyAdapter fontADapter:14]} context:nil].size.width+10;
        
        self.progressBtn.frame = CGRectMake(_headerView.frame.size.width-10-typeW, CGRectGetMaxY(self.nameLbl.frame)+5, typeW, [MyAdapter aDapter:21]);
        self.facililtyLbl.frame = CGRectMake(10, CGRectGetMaxY(self.nameLbl.frame)+5, _headerView.frame.size.width-20-typeW, [MyAdapter aDapter:21]);
        
        
        self.addressLbl.text = @"合肥市";
        
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:self.addressLbl.text];
        NSRange contentRange = {0,[content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        self.addressLbl.attributedText = content;
        
        
        //根据高度重新计算高度
         CGFloat addressW = [self.addressLbl.text boundingRectWithSize:CGSizeMake(MAXFLOAT, [MyAdapter aDapter:21]) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[MyAdapter fontADapter:14]} context:nil].size.width;
        
        //判断地址的长度，来计算headerView的高度
        if (addressW >_headerView.frame.size.width-60) {
            
            self.addressLbl.frame = CGRectMake(50, CGRectGetMaxY(self.facililtyLbl.frame)+3, _headerView.frame.size.width-60, [MyAdapter aDapter:42]);
            
             _headerView.frame = CGRectMake(0, 0, _tableView.frame.size.width, [MyAdapter aDapter:227]+60);
            
        }else{
      
            self.addressLbl.frame = CGRectMake(50, CGRectGetMaxY(self.facililtyLbl.frame)+3, _headerView.frame.size.width-60, [MyAdapter aDapter:21]);
            
            _headerView.frame = CGRectMake(0, 0, _tableView.frame.size.width, [MyAdapter aDapter:206]+60);
        }
        
        self.linkmanLbl.frame = CGRectMake(10, CGRectGetMaxY(self.addressLbl.frame)+5,_headerView.frame.size.width-20, [MyAdapter aDapter:21]);
        
        
        
    }
    
    return _headerView;
}










#pragma mark ---------UITableViewDelegate---------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _handleList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FireDetailModel *model=_handleList[indexPath.row];
    BreakDownDetailCell *cell = [BreakDownDetailCell breakDownDetailCellWithTableView:tableView];
    cell.titleLbl.text=model.handleContent;
    cell.timeLbl.text =model.handleTime;
    cell.titleLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    cell.timeLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    if (indexPath.row ==0) {
        
        cell.typelbl.layer.borderColor = [[AppAppearance sharedAppearance].redColor CGColor];
//        cell.titleLbl.text = @"已发送预警信息通知相关负责人";
//        cell.titleLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
//        
//        cell.timeLbl.text = @"2016/05/06 13:05:06";
//        cell.timeLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    }else{
    
//        cell.typelbl.layer.borderColor = [[AppAppearance sharedAppearance].title3TextColor CGColor];
//        cell.titleLbl.text = @"12层12分区探头发生故障";
//        cell.titleLbl.textColor = [AppAppearance sharedAppearance].title3TextColor;
//        
//        cell.timeLbl.text = @"2016/05/06 13:05:06";
//        cell.timeLbl.textColor = [AppAppearance sharedAppearance].title3TextColor;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyAdapter aDapter:42]+20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [MyAdapter aDapter:40]+10;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, [MyAdapter aDapter:40]+10)];
    sectionView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 10)];
    line.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    [sectionView addSubview:line];
    
    UILabel *testlbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(line.frame)+[MyAdapter aDapter:19]/2, WIDTH-10, [MyAdapter aDapter:21])];
    testlbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    testlbl.text = @"处理记录";
    testlbl.font = [UIFont boldSystemFontOfSize:[MyAdapter fontDapter:16]];
    [sectionView addSubview:testlbl];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, sectionView.frame.size.height-1, WIDTH, 1)];
    line1.backgroundColor = [AppAppearance sharedAppearance].cellLineColor;
    [sectionView addSubview:line1];
    
    return sectionView;
    
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
