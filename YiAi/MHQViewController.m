//
//  MHQViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/7/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "MHQViewController.h"
#import "MHQListViewController.h"
#import "SegmentView.h"
#import "SGPageView.h"
#import "MHQViewCell.h"
@interface MHQViewController ()<SGPageTitleViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,strong)NSString *procode;
@property(nonatomic,strong)NSString *type_MHQ;
@property (nonatomic, strong)NSArray *titleArrays;
@end

@implementation MHQViewController
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource =[NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"灭火器";
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode};
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLMHQList] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
            _titleArrays =dic[@"datas"][@"MHQAllList"][@"MHQAllList"];
            if (_titleArrays.count==0) {
                return ;
            }
            SGPageTitleView *pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreen_Width, 45) delegate:self titleNames:_titleArrays];
            pageTitleView.titleColorStateSelected=[UIColor colorWithRed:32/255.0 green:126/255.0 blue:219/255.0 alpha:1];
            pageTitleView.indicatorColor=[UIColor colorWithRed:32/255.0 green:126/255.0 blue:219/255.0 alpha:1];
            pageTitleView.selectedIndex = 0;
            pageTitleView.indicatorStyle=SGIndicatorTypeEqual;
            [self.view addSubview:pageTitleView];

        }else{
            [_svc showMessage:dic[@"msgs"]];
            [_svc hideLoadingView];
        }
       
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];
        
        
    }];
    //self.view.frame=CGRectMake(0, 50, kScreen_Width, kScreen_Height-45);
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //左右间距
    flowlayout.minimumInteritemSpacing = 0;
    //上下间距
    flowlayout.minimumLineSpacing = 0;
    flowlayout.sectionInset= UIEdgeInsetsMake(0, 10, 0, 10);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 ,50, kScreen_Width, kScreen_Height) collectionViewLayout:flowlayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [_collectionView registerClass:[MHQViewCell class] forCellWithReuseIdentifier:@"listCell"];
//    self.collectionView.header.stateHidden=YES;
//    self.collectionView.header.updatedTimeHidden=YES;
    
    [self.view addSubview:_collectionView];


}
-(void)getdata{
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode,@"type_MHQ":self.type_MHQ,@"page":@"0",@"pageSize":@"9999"};
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLMHQDetaiList] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
            NSArray *array =dic[@"datas"][@"MHQList"][@"MHQList"];
            NSMutableArray *homeModelArray=[NSMutableArray array];
            for (NSDictionary *dic in array) {
                MHQModel *model = [[MHQModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [homeModelArray addObject:model];
            }
            _dataSource=[homeModelArray mutableCopy];
            [self.collectionView reloadData];

        }else{
            [_svc showMessage:dic[@"msgs"]];
            [_svc hideLoadingView];
        }
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];
        
        
    }];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((kScreen_Width-30)/ 2, (kScreen_Width-30)/ 2+100);
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MHQViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listCell" forIndexPath:indexPath];
    MHQModel *model=self.dataSource[indexPath.row];
    [cell updateWithModel:model];
    cell.indexRow=[NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex{
    self.type_MHQ=_titleArrays[selectedIndex];
    [self getdata];
    NSLog(@"%ld",selectedIndex);
    
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    self.procode=intentDic[@"procode"];
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
