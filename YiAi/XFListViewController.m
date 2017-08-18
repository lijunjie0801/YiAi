//
//  XFListViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/8/8.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "XFListViewController.h"
#import "YYMGroup.h"
#import "XFListModel.h"
@interface XFListViewController ()<UITableViewDataSource, UITableViewDelegate> {
    UITableView *myTableView;//定义tabview
    NSMutableArray *dataArray;//数据源数组
    
}
@property(nonatomic,strong)NSString *procode,*myTitle;
@property(nonatomic,strong)NSArray *bengArray;

@end

@implementation XFListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建tableview；
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    self.view=myTableView;
    self.title=_myTitle;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    
    //绑定数据源
    [self getListData];
    
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    self.procode=intentDic[@"procode"];
    _myTitle=intentDic[@"myTitle"];
}

-(void)getListData{
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode,@"deviceType":_myTitle};
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLTransforOrderTypeList] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
            NSArray *array=dic[@"datas"][@"transforAllList"][@"transforAllList"];
            _bengArray = [XFListModel mj_objectArrayWithKeyValuesArray:array];
        }else{
            [_svc showMessage:dic[@"msgs"]];
            [_svc hideLoadingView];
        }
        [myTableView reloadData];
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];
        
        [myTableView reloadData];
        
    }];
}
#pragma mark UITableViewDataSource回调方法
//这是tabview创建多少组的回调
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return _bengArray.count;
}
//这是每个组有多少联系人的回调
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XFListModel *model=_bengArray[section];
    return model.isFolded?0:model.portAddressList.count;
}
//将tabview的cell与数据模型绑定起来
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XFListModel *model=_bengArray[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }

    cell.textLabel.text=[model.portAddressList[indexPath.row] objectForKey:@"position"];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIView *sv=[[UIView alloc]initWithFrame:CGRectMake(10, 59, WIDTH-10, 1)];
    sv.backgroundColor=[UIColor colorWithHexString:@"0xeeeeee"];
    [cell.contentView addSubview:sv];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark UITableViewDelegate回调方法
//对hearderView进行编辑
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XFListModel *model=_bengArray[section];
    //首先创建一个大的view，nameview
    UIView *nameView=[[UIView alloc]init];
    nameView.backgroundColor=[UIColor whiteColor];
    //将分组的名字nameLabel添加到nameview上
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 60)];
    [nameView addSubview:nameLabel];
    nameView.layer.borderWidth=0.2;
    nameView.layer.borderColor=[UIColor grayColor].CGColor;
    //    NSArray *nameArray=@[@" 老朋友",@" 同事",@" 网友",@" 游戏朋友"];
    //    nameLabel.text=nameArray[section];
    nameLabel.text=model.hostId;
    UIView *sv=[[UIView alloc]initWithFrame:CGRectMake(0, 59, WIDTH, 1)];
    sv.backgroundColor=[UIColor colorWithHexString:@"0xeeeeee"];
    [nameView addSubview:sv];
    //添加一个button用于响应点击事件（展开还是收起）
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, self.view.frame.size.width, 40);
    [nameView addSubview:button];
    button.tag = 200 + section;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //将显示展开还是收起的状态通过三角符号显示出来
    UIImageView *fuhao=[[UIImageView alloc]initWithFrame:CGRectMake(345, 20, 20, 20)];
    fuhao.tag=section;
    [nameView addSubview:fuhao];
    if (model.isFolded==YES) {
        fuhao.image=[UIImage imageNamed:@"you"];
    }else{
        fuhao.image=[UIImage imageNamed:@"xia"];
    }
    //返回nameView
    return nameView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld------%ld",(long)indexPath.section,(long)indexPath.row);
    XFListModel *model=_bengArray[indexPath.section];
    NSDictionary *dic=model.portAddressList[indexPath.row];
    NSString *hostId=model.hostId;
    //NSString *hostId=model.hostId;
    [_svc pushViewController:_svc.CustomeLineChatViewController withObjects:@{@"procode":dic[@"proCode"],@"histId":hostId,@"macNum":dic[@"macNum"],@"portNum":dic[@"portNum"],@"address":dic[@"address"],@"deviceType":self.myTitle}];

    
    
}
//设置headerView高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}
//设置cell的高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
//button的响应点击事件
- (void) buttonClicked:(UIButton *) sender {
    //改变模型数据里面的展开收起状态
    //    YYMGroup *group2 = dataArray[sender.tag - 200];
    //    group2.folded = !group2.isFolded;
    XFListModel *model=_bengArray[sender.tag - 200];
    model.folded=!model.folded;
    [myTableView reloadData];
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
