//
//  HomeDetailViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/8.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "SYSTATCollectionViewCell.h"
#import "DTCustomeWebViewController.h"
#define SystatheaderViewIdentifier  @"SYSTAThederview"
#define SystatfooterViewIdentifier  @"SYSTATfooterview"

@interface HomeDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *goodCollectionView;
@property(nonatomic, strong) NSString *procode;
@property(nonatomic, strong) NSArray *SectionsArray;
@property(nonatomic, strong) NSArray *itemsArray;
@property(nonatomic, strong) NSArray *itemsIcons;
@property(nonatomic, strong) NSMutableArray *messageNums;
@property(nonatomic, strong) NSString *proname;
//火警，水系统，通讯故障，故障，屏蔽，动作反馈
@property(nonatomic, strong) UILabel *fireLbl,*waterLbl,*comfaultLbl,*faultLbl,*shieldLbl,*cotionFeedbackLbl;
@end

@implementation HomeDetailViewController
-(NSMutableArray *)messageNums{
    if (!_messageNums) {
        _messageNums =[NSMutableArray array];
    }
    return _messageNums;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.SectionsArray = @[@"基本信息",@"报警信息",@"消防信息",@"统计分析",@"维护监督"];
    
    self.itemsArray = @[@[@"项目概况",@"人员管理",@"主机信息"],@[@"火警",@"故障",@"水系统",@"通讯故障",@"屏蔽",@"动作反馈"],@[@"泵房状态",@"防排烟",@"广播",@"卷帘门",@"灭火器",@"消防电源"],@[@"火灾报警系统",@"消防设施",@"NFC",@"其他统计"],@[@"巡查",@"图形显示",@"我的工作",@"视频",@"查岗",@"任务书"]];
    
   self.itemsIcons = @[@[@"jb0",@"jb1",@"jb2"],@[@"bj0",@"bj1",@"bj2",@"bj3",@"bj4",@"bj5"],@[@"xf0",@"xf1",@"xf2",@"xf3",@"xf4",@"xf5"],@[@"tj0",@"tj1",@"tj2",@"tj3"],@[@"wh0",@"wh1",@"wh2",@"wh3",@"wh4",@"wh5"]];
    
    
    
    //UICollectionView
    self.automaticallyAdjustsScrollViewInsets=NO;
    UICollectionViewFlowLayout * layout1 = [[UICollectionViewFlowLayout alloc]init];
    //滚动的方向
    [layout1 setScrollDirection:UICollectionViewScrollDirectionVertical];
    _goodCollectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout1];
    
    //注册头视图
    [_goodCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SystatheaderViewIdentifier];
    //注册尾部视图
    [_goodCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SystatfooterViewIdentifier];
    
    _goodCollectionView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    _goodCollectionView.showsHorizontalScrollIndicator = NO;
    _goodCollectionView.showsVerticalScrollIndicator = NO;
    _goodCollectionView.dataSource=self;
    _goodCollectionView.delegate=self;
    [self.view addSubview:_goodCollectionView];
    
    [_goodCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
        make.width.offset(WIDTH);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    self.title=self.proname;
    [self requestMessageNumData];
}

-(void)setIntentDic:(NSDictionary *)intentDic{
    self.procode=intentDic[@"procode"];
    self.proname=intentDic[@"proname"];
}
#pragma mark  ----UICollectionViewDelegate-----
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.itemsArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array = self.itemsArray[section];
    return array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static BOOL nibri =NO;
    if(!nibri){
        
        [_goodCollectionView registerClass:[SYSTATCollectionViewCell class] forCellWithReuseIdentifier:systatCellIdentifier];
        nibri =YES;
    }
    
    SYSTATCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:systatCellIdentifier forIndexPath:indexPath];
    [cell.btn setImage:[UIImage imageNamed:_itemsIcons[indexPath.section][indexPath.row]] forState:UIControlStateNormal];
    cell.lab.text=self.itemsArray[indexPath.section][indexPath.row];
    if (indexPath.section!=1) {
        cell.numlbl.hidden=YES;
    }else{
        NSString *num=_messageNums[indexPath.row];
        if ([num intValue]>0) {
            cell.numlbl.hidden = NO;
            cell.numlbl.text = num;
        }else{
           cell.numlbl.hidden = YES;
        }
    }
    nibri=NO;
    return cell;
    
    
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        
        if (indexPath.row ==0) {
            NSString *webUrl=[NSString stringWithFormat:@"http://yaapi.zilankeji.com/project/index?proCode=%@&appKey=%@&hostUrl=%@",self.procode,[AppDataManager defaultManager].identifier,KBaseWebURL];
            [_svc pushViewController:_svc.DTWebViewController withObjects:@{@"weburl":webUrl,@"procode":self.procode}];
            
        }else if (indexPath.row ==1){
        
            //人员管理
            [_svc pushViewController:_svc.peopleManageViewController withObjects:@{@"procode":self.procode}];
        }else{
            [_svc pushViewController:_svc.HostListViewController withObjects:@{@"procode":self.procode}];
        }
        
    }else if (indexPath.section ==1){
        if (indexPath.row==0) {
             [_svc pushViewController:_svc.fireAlarmViewController withObjects:@{@"title":@"火警",@"procode":self.procode}];
        }else if (indexPath.row==1){
            [_svc pushViewController:_svc.breakdownViewController withObjects:@{@"title":@"故障",@"procode":self.procode}];
        }else if (indexPath.row==2){
             [_svc pushViewController:_svc.waterSystemViewController withObjects:@{@"title":@"水系统",@"procode":self.procode}];
        }else if (indexPath.row==3){
            [_svc pushViewController:_svc.conmunicationBreakdownViewController withObjects:@{@"title":@"通讯故障",@"procode":self.procode}];
        }else if (indexPath.row==4){
             [_svc pushViewController:_svc.screenViewController withObjects:@{@"title":@"屏蔽",@"procode":self.procode}];
        }else if (indexPath.row==5){
          [_svc pushViewController:_svc.motionFeedbackViewController withObjects:@{@"title":@"动作反馈",@"procode":self.procode}];
        }

    
    }else if (indexPath.section ==2){
        if (indexPath.row==0) {
            [_svc pushViewController:_svc.BengHomeStatuViewController withObjects:@{@"procode":self.procode}];
        }else if (indexPath.row==1){
            [_svc pushViewController:_svc.XFSSViewController withObjects:@{@"title":@"防排烟",@"procode":self.procode}];
        }else if (indexPath.row==2){
            [_svc pushViewController:_svc.XFSSViewController withObjects:@{@"title":@"广播",@"procode":self.procode}];
        }else if (indexPath.row==3){
            [_svc pushViewController:_svc.XFSSViewController withObjects:@{@"title":@"卷帘门",@"procode":self.procode}];
        }else if (indexPath.row==4){
            [_svc pushViewController:_svc.MHQViewController withObjects:@{@"procode":self.procode}];
        }else if (indexPath.row==5){
            [_svc pushViewController:_svc.XFSSViewController withObjects:@{@"title":@"消防电源",@"procode":self.procode}];
        }



    
    }else if (indexPath.section ==3){
        if (indexPath.row ==0) {
            [_svc pushViewController:_svc.HZBJViewController withObjects:@{@"procode":self.procode}];
        }else if (indexPath.row ==1){
            [_svc pushViewController:_svc.XFViewController withObjects:@{@"procode":self.procode}];
        }else if (indexPath.row ==2){
            [_svc pushViewController:_svc.NFCController withObjects:@{@"procode":self.procode}];
        }else if (indexPath.row ==3){
            [_svc pushViewController:_svc.QTTJViewController];
        }
    }else{
    
        if (indexPath.row ==0) {
            
            //巡查
        }else if (indexPath.row ==1){
        
            //图形显示
        }else if (indexPath.row ==2){
        
            //我的工作
            [_svc pushViewController:_svc.myWorkViewController];
            
        }else if (indexPath.row ==3){
        
            //视频
            [_svc pushViewController:_svc.videoViewController];
        }else if (indexPath.row ==4){
        
            //查岗
             [_svc pushViewController:_svc.CheckStationListViewController withObjects:@{@"procode":self.procode}];
        }else{
        
            //任务书
             [_svc pushViewController:_svc.taskBookViewController];
            
        }
    }
}







//定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    return CGSizeMake((WIDTH-[MyAdapter aDapter:30])/2,[MyAdapter aDapter:156]+20);
    return CGSizeMake((WIDTH-[MyAdapter aDapter:40] -20)/4,[MyAdapter aDapter:40]+40);
}

//定义每个UICollectionView 的间距  //
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake([MyAdapter aDapter:10],[MyAdapter aDapter:10],[MyAdapter aDapter:10],[MyAdapter aDapter:10]);
}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [MyAdapter aDapter:10];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



//section的HeaderView高度
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(WIDTH,[MyAdapter aDapter:40]);
    
    
}

//section的FooterView高度
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    return CGSizeMake(WIDTH,20);
    
    
}




//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:SystatheaderViewIdentifier forIndexPath:indexPath];
        
        
        for (UIView *view in header.subviews) {
            
            [view removeFromSuperview];
        }
        
        
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, [MyAdapter aDapter:40])];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, [MyAdapter aDapter:19]/2, WIDTH-10, [MyAdapter aDapter:21])];
        lbl.text = self.SectionsArray[indexPath.section];
        lbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
        lbl.font = [UIFont boldSystemFontOfSize:[MyAdapter fontDapter:16]];
        [topView addSubview:lbl];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, topView.frame.size.height-1, WIDTH, 1)];
        line.backgroundColor = [AppAppearance sharedAppearance].cellLineColor;
        [topView addSubview:line];
        
        header.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
        //头视图添加view
        [header addSubview:topView];
        return header;
        
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        
        UICollectionReusableView *footer=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:SystatfooterViewIdentifier forIndexPath:indexPath];
        
        
        for (UIView *view in footer.subviews) {
            
            [view removeFromSuperview];
        }
        
        
        
        footer.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
        return footer;
        
        
    }
    
    
    return nil;
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取消息的数目
-(void)requestMessageNumData
{
    
    if ([AppDataManager defaultManager].hasLogin) {
        NSDictionary *param = @{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode};
        [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLHomeMessageNum] withParamer:param completionHandler:^(id responseObject) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSLog(@"消息的数目===%@",dic);
            dic = dic[@"datas"][@"indexAlarmNums"][@"AlarmListNums"];
            
            //火警数量
            NSString *fireCount = dic[@"fireCount"];
            
            //水警数量
            NSString *waterCount = dic[@"waterCount"];
            
            //通讯故障
            NSString *comFaultCount = dic[@"comFaultCount"];
            //故障
            NSString *faultCount = dic[@"faultCount"];

            //屏蔽
            NSString *shieldCount = dic[@"shieldCount"];

            //动作反馈
            NSString *cotionFeedbackCount = dic[@"cotionFeedbackCount"];
            
            NSMutableArray *array=[NSMutableArray array];
            [array addObject:fireCount];
            [array addObject:faultCount];
            [array addObject:waterCount];
            [array addObject:comFaultCount];
            [array addObject:shieldCount];
            [array addObject:cotionFeedbackCount];
            _messageNums=[array mutableCopy];
            [_svc hideLoadingView];
            [self.goodCollectionView reloadData];
            
        } failureHandler:^(NSError *error, NSUInteger statusCode) {
            [_svc hideLoadingView];
            [_svc showMessage:error.domain];
        }];
        
        
    }
}


@end
