//
//  LoginViewController.m
//  CRFN
//
//  Created by zlkj on 2017/2/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "LoginViewController.h"
#import "UserBehaviorCell.h"

@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UITextField *phone;
@property(nonatomic, strong) UITextField *passWord;

@property(nonatomic, strong) NSString *phoneStr;

@property(nonatomic, strong)    UILabel *callIphonelbl;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//
//    self.navigationController.navigationBar.barTintColor= [AppAppearance sharedAppearance].tabBarColor;
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:[MyAdapter fontDapter:20]],
//                                                                      NSForegroundColorAttributeName:[AppAppearance sharedAppearance].whiteColor}];
    
    
//    self.title = @"登录";
    [self.navigationController setNavigationBarHidden:YES];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.tableHeaderView = [self headerView];
    _tableView.tableFooterView = [self footViews];
    
    [self requestPhone];
    
    
}

-(void)requestPhone
{
    
    
    
}


//头部视图
-(UIView *)headerView
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.frame           = CGRectMake(0, 0, _tableView.bounds.size.width, 240);
    
    UIImage *logoImg           = [UIImage imageNamed:@"loginImg"];
    
    UIImageView *imageView     = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    imageView.backgroundColor  = [UIColor clearColor];
    imageView.image            = logoImg;
    
    imageView.contentMode      = UIViewContentModeScaleAspectFit;
    imageView.center           = CGPointMake(headerView.bounds.size.width/2, headerView.bounds.size.height/2+20);
    [headerView addSubview:imageView];
    
    return headerView;
}
//尾部视图
-(UIView *)footViews
{
    UIView *footerView = [[UIView alloc] init];
    
    footerView.backgroundColor = [UIColor clearColor];
    footerView.frame           = CGRectMake(0, 0, _tableView.bounds.size.width, 350);
    
    
    
    
    //登录按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[AppAppearance sharedAppearance].mainColor];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    button.frame     = CGRectMake(20, 20, _tableView.bounds.size.width-40, [MyAdapter aDapter:45]);
    button.layer.cornerRadius = 6;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    
    
    
    UILabel *forgetlbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 260, kScreen_Width, 20)];
    forgetlbl.textAlignment=NSTextAlignmentCenter;
    forgetlbl.text = @"忘记密码?";
    forgetlbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    forgetlbl.font = [MyAdapter fontADapter:16];
    [footerView addSubview:forgetlbl];
    forgetlbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetClick)];
    [forgetlbl addGestureRecognizer:tag];
    
    CGSize titleSize = [@"忘记密码?"  sizeWithFont:[MyAdapter fontADapter:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    UIView *bottomLine=[[UIView alloc]initWithFrame:CGRectMake((kScreen_Width-titleSize.width)/2, 281, titleSize.width, 1)];
    bottomLine.backgroundColor=[AppAppearance sharedAppearance].title2TextColor;
   [footerView addSubview:bottomLine];
    
    
    
    return footerView;
}


//用户名和密码的验证
-(BOOL)loginCheck{
    
    [self.view endEditing:YES];
    if(_phone.text.length == 0){
        [_svc showMessage:@"请输入您的账号"];
        return NO;
    }
    if(_passWord.text.length == 0){
        [_svc showMessage:@"请输入您的密码"];
        return NO;
    }
    
    if (_passWord.text.length < 6) {
        [_svc showMessage:@"密码长度至少6位"];
        return NO;
    }
//    if(![Utility checkPhone:_phone.text])
//    {
//        [_svc showMessage:@"请输入正确的手机号"];
//        return NO;
//    }
    
    
    return YES;
}


//登录方法
-(void)loginAction
{
    
    if ([self loginCheck]) {
        
        [_svc showLoadingWithMessage:@"登录中..." inView:[UIApplication sharedApplication].keyWindow];
        
        
        
         NSString *reId=[DEFAULTS objectForKey:@"registrationID"];
        NSDictionary *param =@{@"userName":_phone.text,@"userPwd":_passWord.text,@"registration_id":reId                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               };
        
        
        [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLStringLogin] withParamer:param completionHandler:^(id responseObject) {
            
            NSLog(@"%@",responseObject);
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            NSLog(@"结果=========%@",dic);
          

            
            if ([dic[@"status"] intValue] ==100) {
                
                [[AppDataManager defaultManager] setIdentifier:dic[@"datas"][@"nameLogin"][@"appKey"]];
                [[AppDataManager defaultManager] setPhoneAccount:_phone.text];
                
                
//                if ([self.delegate respondsToSelector:@selector(refresh)]) {
//                    
//                    [self.delegate refresh];
//                }
//                [self.delegate refresh];
                [_svc dismissTopViewControllerCompletion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"0"}];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"homeRefresh" object:nil userInfo:nil];
                
            }
            
            
            [_svc showMessage:responseObject[@"msgs"]];
            
            [_svc hideLoadingView];
            
            
        } failureHandler:^(NSError *error, NSUInteger statusCode) {
            
            [_svc hideLoadingView];
            
            [_svc showMessage:error.domain];
            
        }];
        
        
        
        
//        // 1、创建URL
//        NSURL *url = [NSURL URLWithString:KBaseURL];
//        // 2、创建请求对象
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//        request.HTTPMethod = @"POST";
//        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        [request setValue:@"http://eiremote.org/nameLogin" forHTTPHeaderField:@"SOAPAction"];
//        
//        NSString *reqBody = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
//                             <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
//                             <soap:Body>\
//                             <nameLogin xmlns=\"http://eiremote.org/\">\
//                             <userName>%@</userName>\
//                             <userPwd>%@</userPwd>\
//                             </nameLogin>\
//                             </soap:Body>\
//                             </soap:Envelope>",_phone.text,_passWord.text];
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
//            NSLog(@"%@",dic[@"status"]);
//            
//            
//            if ([dic[@"status"] intValue] ==100) {
//                
//                [[AppDataManager defaultManager] setIdentifier:dic[@"datas"][@"nameLogin"][@"appKey"]];
//                [[AppDataManager defaultManager] setPhoneAccount:_phone.text];
//                
//                
//                
//                [_svc dismissTopViewControllerCompletion:nil];
//                  [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"0"}];
//                
//            }
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                [_svc showMessage:dic[@"msgs"]];
//                
//                [_svc hideLoadingView];
//                
//            });
//            
//            
//            
//            
//            
//        } failure:^(NSError *error) {
//            
//            
//            [_svc hideLoadingView];
//            [_svc showMessage:error.domain];
//            
//            
//            
//        }];
        
        
        
        
        
    }
    
    
    
    
    
}


//忘记密码方法
-(void)forgetClick
{
    //    [_svc pushViewController:_svc.forgetViewController];
}



#pragma mark -UITableViewDelegate-----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"loginCell";
    UserBehaviorCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UserBehaviorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            //            cell.imageView.image        = [UIImage imageNamed:@"people"];
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.textField.placeholder  = @"账号/手机号";
            cell.forgetPass.hidden = YES;
            cell.leftImgView.image=[UIImage imageNamed:@"zhanghao"];
            //            if ([AppDataManager defaultManager].PhoneAccount) {
            //
            //                cell.textField.text = [AppDataManager defaultManager].PhoneAccount;
            //            }
            _phone                      = cell.textField;
            _phone.text = @"shyhgc";
            break;
        case 1:
            cell.textField.keyboardType    = UIKeyboardTypeDefault;
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder     = @"密码";
            cell.isHide                    = YES;
          cell.leftImgView.image=[UIImage imageNamed:@"mima"];
            
            _passWord                      = cell.textField;
           _passWord.text = @"123456";
            
            cell.accessoryView = cell.forgetPass;
            break;
            
        default:
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyAdapter aDapter:60];
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

