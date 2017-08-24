//
//  SYSTATViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/6.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "SYSTATViewController.h"
#import "SYSTATCollectionViewCell.h"


#define SystatheaderViewIdentifier  @"SYSTAThederview"
#define SystatfooterViewIdentifier  @"SYSTATfooterview"

@interface SYSTATViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *goodCollectionView;

@property(nonatomic, strong) NSArray *SectionsArray;
@property(nonatomic, strong) NSArray *itemsArray;
@property(nonatomic, strong) NSArray *itemsIcons;
@property(nonatomic, strong) NSArray *tjArray;

@end

@implementation SYSTATViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"woyun" image:[UIImage imageNamed:@"统计ICON"] tag:1];
        //self.tabBarItem.selectedImage=[UIImage imageNamed:@"shouye_sel"];
        self.title = @"统计分析";
        self.tabBarItem.title = @"统计分析";
        //调整tabbaritem中文字的位置
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.SectionsArray = @[@"火灾报警系统",@"消防设施",@"其他统计"];
    
    self.itemsArray = @[@[@"火警",@"动作反馈",@"屏蔽",@"通讯故障",@"故障"],@[@"电流",@"电压",@"风速",@"光照强度",@"湿度",@"输出"],@[@"联网单位",@"查岗",@"研判",@"主机厂商",@"误报统计"]];
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":@""};
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLXFTypeList] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
            _tjArray=dic[@"datas"][@"transforAllList"][@"transforAllList"];
    
            [self.goodCollectionView reloadData];
        }else{
            [_svc showMessage:dic[@"msgs"]];
            [_svc hideLoadingView];
        }
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];
        
        
    }];

    
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

    
    
}


#pragma mark  ----UICollectionViewDelegate-----
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.itemsArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array = self.itemsArray[section];
    NSInteger count;
    if (section!=1) {
        count=array.count;
    }else{
        count=self.tjArray.count;
    }
    return count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static BOOL nibri =NO;
    if(!nibri){
        
        [_goodCollectionView registerClass:[SYSTATCollectionViewCell class] forCellWithReuseIdentifier:systatCellIdentifier];
        nibri =YES;
    }
    
    SYSTATCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:systatCellIdentifier forIndexPath:indexPath];
    if (indexPath.section!=1) {
         cell.lab.text=self.itemsArray[indexPath.section][indexPath.row];
    }else{
        cell.lab.text=self.tjArray[indexPath.row];
    }
   
    NSString *imgName;
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                imgName=@"bj0";
                break;
            case 1:
                imgName=@"bj5";
                break;
            case 2:
                imgName=@"bj4";
                break;
            case 3:
                imgName=@"bj3";
                break;
            case 4:
                imgName=@"bj1";
                break;

            default:
                break;
        }
    }else if(indexPath.section==1){
        if ([cell.lab.text containsString:@"电流"]) {
            imgName=@"dl_1";
        }else if([cell.lab.text containsString:@"电压"]){
            imgName=@"dy_1";
        }else if([cell.lab.text containsString:@"风速"]){
            imgName=@"fs_1";
        }else if([cell.lab.text containsString:@"光照强度"]){
            imgName=@"gzqd";
        }else if([cell.lab.text containsString:@"湿度"]){
            imgName=@"sd_1";
        }else if([cell.lab.text containsString:@"输出"]){
            imgName=@"sc_1";
        }else if([cell.lab.text containsString:@"水位"]){
            imgName=@"sw_1";
        }else if([cell.lab.text containsString:@"温度"]){
            imgName=@"wd_1";
        }else if([cell.lab.text containsString:@"压力"]){
            imgName=@"yl_1";
        }
\
    }else{
        switch (indexPath.row) {
            case 0:
                imgName=@"lwdw";
                break;
            case 1:
                imgName=@"cg_1";
                break;
            case 2:
                imgName=@"yp_1";
                break;
            case 3:
                imgName=@"zjcs";
                break;
            case 4:
                imgName=@"wbtj";
                break;
                
            default:
                break;
        }

    }
    [cell.btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    cell.numlbl.hidden=YES;
    
    nibri=NO;
    return cell;
    
    
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        
        if (indexPath.row==0) {
            [_svc pushViewController:_svc.FireLineChartViewController withObjects:@{@"myTitle":@"火警",@"procode":@""}];
        }else if (indexPath.row==1) {
            [_svc pushViewController:_svc.lineChartController withObjects:@{@"myTitle":@"动作反馈",@"procode":@""}];
        }else if (indexPath.row==2) {
            [_svc pushViewController:_svc.lineChartController withObjects:@{@"myTitle":@"屏蔽",@"procode":@""}];
        }else if (indexPath.row==3) {
            [_svc pushViewController:_svc.lineChartController withObjects:@{@"myTitle":@"通讯故障",@"procode":@""}];
        }else if (indexPath.row==4) {
            [_svc pushViewController:_svc.lineChartController withObjects:@{@"myTitle":@"故障",@"procode":@""}];
        }

        
        
    }else if (indexPath.section ==1){
        
         [_svc pushViewController:_svc.XFListViewController withObjects:@{@"myTitle":self.tjArray[indexPath.row],@"procode":@""}];
    
    }else{
    
        if (indexPath.row ==0) {
            
            //联网单位
//            [_svc pushViewController:_svc.networkUnitViewController];
            
        }else if (indexPath.row == 1){
        
            //查岗
        //    [_svc pushViewController:_svc.checkJobSelectViewController];
        }else if (indexPath.row ==2){
        
            //研判
        }else if (indexPath.row ==3){
        
            //主机厂商
            [_svc pushViewController:_svc.HostVendorViewController];
        }else{
        
            //误报统计
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
