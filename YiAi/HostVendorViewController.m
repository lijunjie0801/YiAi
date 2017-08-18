//
//  HostVendorViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/8/17.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "HostVendorViewController.h"
#import "OpenTest.h"
#define LabelTag            101
#define viewTag            102
#define zheTag            103
#define SpaceWidth          15

#define UI_SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width
@interface HostVendorViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong )UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (copy, nonatomic) NSIndexPath *indexPath;
@property (nonatomic,strong) NSMutableArray *resultArray;

@end

@implementation HostVendorViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)resultArray{
    if (!_resultArray) {
        _resultArray=[NSMutableArray array];
    }
    return _resultArray;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"主机厂商";
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    self.view = _mainTableView;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initData];
}

- (void)initData {
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":@""};
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLHostCompanyList] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
            NSArray *array=dic[@"datas"][@"guardHistoryArrList"][@"guardHistoryArrList"];
            NSMutableArray *marr=[NSMutableArray array];
            
            for (NSDictionary *dic in array) {
                OpenTest *model = [[OpenTest alloc] init];
                model.title = dic[@"proCodeName"];
                model.proCode=dic[@"proCode"];
                model.level = 0;
                model.isOpen = NO;
                NSArray *hostCompanyList= dic[@"hostCompanyList"];
                NSString *procode=dic[@"proCode"];
                NSMutableArray *marr1=[NSMutableArray array];
                for (NSDictionary *dic in hostCompanyList) {
                    OpenTest *model = [[OpenTest alloc] init];
                    model.title = dic[@"hostCompany"];
                    model.level = 1;
                    model.isOpen = NO;
                    model.detailArray = dic[@"hostList"];
                    
                    NSArray *hostList=dic[@"hostList"];
                     NSMutableArray *marr2=[NSMutableArray array];
                    for (NSString *str in hostList) {
                        OpenTest *model = [[OpenTest alloc] init];
                        model.title = str;
                        model.level = 2;
                        model.isOpen = NO;
                        model.proCode=procode;
                        [marr2 addObject:model];
                    }
                    model.detailArray=marr2;

                    [marr1 addObject:model];
                }
                model.detailArray = marr1;
               [marr addObject:model];
            }
            _dataArray=[marr mutableCopy];
            NSLog(@"_dataArray:%ld-------result:%ld",_dataArray.count,_resultArray.count);
            [self dealWithDataArray:_dataArray];
              NSLog(@"_dataArray:%ld-------result:%ld",_dataArray.count,_resultArray.count);
              [_mainTableView reloadData];
        }else{
            [_svc showMessage:dic[@"msgs"]];
            [_svc hideLoadingView];
        }
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];
        
        [_mainTableView reloadData];
        
    }];
  
}
- (void)dealWithDataArray:(NSMutableArray *)dataArray {
    NSMutableArray *marr=[NSMutableArray array];
    for (OpenTest *model in dataArray) {
        //[_resultArray addObject:model];
        [marr addObject:model];
        
        if (model.isOpen && model.detailArray.count > 0) {
            [self dealWithDataArray:model.detailArray];
        }
    }
    _resultArray=[marr mutableCopy];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    OpenTest *model = _resultArray[row];
    
//    if (model.level == 0) {
//        return 160;
//    }
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    OpenTest *model = _resultArray[row];
    
    if (model.level == 0) {
        UITableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"Cellw"];
        
        
        if (titleCell == nil) {
            titleCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cellw"];
            titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *sepview=[[UIView alloc]initWithFrame:CGRectMake(0, 43, kScreen_Width, 1)];
            sepview.backgroundColor=[UIColor colorWithHexString:@"0xeeeeee"];
            [titleCell.contentView addSubview:sepview];
            titleCell.textLabel.text=model.title;
            UIImageView *fuhao=[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width-25, 12, 20, 20)];
            fuhao.tag=viewTag;
            [titleCell.contentView addSubview:fuhao];
            
        }
        for (UIView *view in titleCell.contentView.subviews) {
            if (view.tag == viewTag) {
                if (model.isOpen==YES) {
                     ((UIImageView *)view).image=[UIImage imageNamed:@"xia"];
                }else{
                     ((UIImageView *)view).image=[UIImage imageNamed:@"you"];
                }

            }
        }

        
        
        return titleCell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, UI_SCREEN_WIDTH / 2, 44)];
            label.font = [UIFont systemFontOfSize:14];
            label.tag = LabelTag;
            [cell.contentView addSubview:label];
            UIView *sepview=[[UIView alloc]initWithFrame:CGRectMake(0, 43, kScreen_Width, 1)];
            sepview.backgroundColor=[UIColor colorWithHexString:@"0xeeeeee"];
            [cell.contentView addSubview:sepview];
            
            UIImageView *fuhao=[[UIImageView alloc]initWithFrame:CGRectMake(0, 12, 20, 20)];
            fuhao.tag=zheTag;
            [cell.contentView addSubview:fuhao];

        }
        
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == LabelTag) {
                ((UILabel *)view).text = model.title;
                ((UILabel *)view).frame = CGRectMake(35 + (model.level - 1) * SpaceWidth , 0, UI_SCREEN_WIDTH / 2, 44);
            }
        }
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == zheTag) {
//                if (model.isOpen==YES) {
//                    ((UIImageView *)view).image=[UIImage imageNamed:@"xia"];
//                }else{
                    ((UIImageView *)view).image=[UIImage imageNamed:@"zhejiao"];
              //  }
                ((UIImageView *)view).frame = CGRectMake(15 + (model.level - 1) * 5 , 12, 20, 20);
                
            }
        }
        

        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    OpenTest *model = _resultArray[row];
    
    if (model.isOpen) {
        //原来是展开的，现在要收起,则删除model.detailArray存储的数据
        [self deleteObjectWithDataArray:model.detailArray count:0];
    }
    else {
        if (model.detailArray.count > 0) {
            //原来是收起的，现在要展开，则需要将同层次展开的收起，然后再展开
            [self compareSameLevelWithModel:model row:row];
        }
        else {
            //点击的是最后一层数据，跳转到别的界面
            NSLog(@"最后一层，%@,,,,%@",model.title,model.proCode);
            [_svc pushViewController:_svc.HostDetailViewController withObjects:@{@"procode":model.proCode,@"hostId":model.title,@"isEdit":@"0"}];
        }
    }
    
    model.isOpen = !model.isOpen;
    

    [tableView reloadData];
}

#pragma mark - 业务代码

/**
 与点击同一层的数据比较，然后删除要收起的数据和插入要展开的数据
 
 @param model 点击的cell对应的model
 @param row   点击的在tableview的indexPath.row,也对应_resultArray的下标
 */
- (void)compareSameLevelWithModel:(OpenTest *)model row:(NSInteger)row {
    NSInteger count = 0;
    NSInteger index = 0;    //需要收起的起始位置
    NSMutableArray *copyArray = [_resultArray mutableCopy];
    
    for (int i = 0; i < copyArray.count; i++) {
        OpenTest *openModel = copyArray[i];
        if (openModel.level == model.level) {
            //同一个层次的比较
            if (openModel.isOpen) {
                //删除openModel所有的下一层
                count = [self deleteObjectWithDataArray:openModel.detailArray count:count];
                index = i;
                openModel.isOpen = NO;
                break;
            }
        }
    }
    
    //插入的位置在删除的位置的后面，则需要减去删除的数量。
    if (row > index && row > count) {
        row -= count;
    }
    
    [self addObjectWithDataArray:model.detailArray row:row + 1];
}

/**
 在指定位置插入要展示的数据
 
 @param dataArray 数据
 @param row       需要插入的数组下标
 */
- (void)addObjectWithDataArray:(NSMutableArray *)dataArray row:(NSInteger)row {
    for (int i = 0; i < dataArray.count; i++) {
        OpenTest *model = dataArray[i];
        model.isOpen = NO;
        
        [_resultArray insertObject:model atIndex:row];
        
        row += 1;
    }
}

/**
 删除要收起的数据
 
 @param dataArray 数据
 @param count     统计删除数据的个数
 
 @return 删除数据的个数
 */
- (CGFloat)deleteObjectWithDataArray:(NSMutableArray *)dataArray count:(NSInteger)count {
    for (OpenTest *model in dataArray) {
        count += 1;
        
        if (model.isOpen && model.detailArray.count > 0) {
            count = [self deleteObjectWithDataArray:model.detailArray count:count];
        }
        
        model.isOpen = NO;
        
        [_resultArray removeObject:model];
    }
    
    return count;
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
