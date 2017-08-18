//
//  PushMessageViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/8.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "PushMessageViewController.h"

@interface PushMessageViewController ()<UITableViewDataSource, UITableViewDelegate>


@property(nonatomic, strong) UITableView *tableView;


@property(nonatomic, strong) UISwitch *switchs;

@property(nonatomic, strong) UISwitch *switchsVoice;

@property(nonatomic, strong) UISwitch *switchsShake;


@end

@implementation PushMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"推送消息";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}





#pragma mark ----UITableViewDelegate --------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        
        return 1;
    }
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = @"接收信消息通知";
 
        if (_switchs == nil) {
            
            _switchs = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.bounds.size.width-60, 5, 50, self.tableView.bounds.size.height-10)];
            _switchs.center = CGPointMake(self.tableView.bounds.size.width-35, cell.contentView.frame.size.height/2);
//            [_switchs addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//            _switchs.on = [AppDataManager defaultManager].isOff;
            [cell.contentView addSubview:_switchs];
            
        }
    }else{
        
        
        if (indexPath.row ==0) {
            
            
            cell.textLabel.text = @"声音";
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            if (_switchsVoice == nil) {
                
                _switchsVoice = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.bounds.size.width-60, 5, 50, self.tableView.bounds.size.height-10)];
                _switchsVoice.center = CGPointMake(self.tableView.bounds.size.width-35, cell.contentView.frame.size.height/2);
//                [_switchsVoice addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                //            _switchs.on = [AppDataManager defaultManager].isOff;
                [cell.contentView addSubview:_switchsVoice];
                
            }
            
        }else{
        
            
            cell.textLabel.text = @"振动";
    
            if (_switchsShake == nil) {
                
                _switchsShake = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.bounds.size.width-60, 5, 50, self.tableView.bounds.size.height-10)];
                _switchsShake.center = CGPointMake(self.tableView.bounds.size.width-35, cell.contentView.frame.size.height/2);
//                [_switchsShake addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                //            _switchsShake = [AppDataManager defaultManager].isOff;
                [cell.contentView addSubview:_switchsShake];
                
            }
        
            
        }
        
        
        
    }
    
    cell.textLabel.font = [MyAdapter fontADapter:16];
    cell.textLabel.textColor = [AppAppearance sharedAppearance].titleTextColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
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
