//
//  SwitchViewController.m
//  NewKuangJia
//
//  Created by fyaex001 on 2017/1/6.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "SwitchViewController.h"
#import "BaseViewController.h"
#import "RootViewController.h"
#import "PushMessageViewController.h"
#import "SettingViewController.h"
#import "HomeDetailViewController.h"
#import "BreakdownViewController.h"
#import "BreakDownDetailViewController.h"
#import "FireAlarmViewController.h"
#import "WaterSystemViewController.h"
#import "MyWorkViewController.h"
#import "TaskBookViewController.h"
#import "CheckJobSelectViewController.h"
#import "CheckJobViewController.h"
#import "VideoViewController.h"
#import "PeopleManageViewController.h"
#import "PushServiceViewController.h"
#import "ServiceDetailViewController.h"
#import "NetworkUnitViewController.h"
#import "HCScanQRViewController.h"
#import "LookNFCequipmentViewController.h"
#import "AddNFCequipmentViewController.h"
#import "PollingRecordViewController.h"
#import "PollingRecordUploadViewController.h"
#import "PollingRecordDetailViewController.h"
#import "VoltageViewController.h"
#import "LoginViewController.h"
#import "ConmunicationBreakdownViewController.h"
#import "ScreenViewController.h"
#import "MotionFeedbackViewController.h"
#import "NFCViewController.h"
#import "DTCustomeWebViewController.h"
#import "HostInfoListViewController.h"
#import "HostInfoDetailViewController.h"
#import "HostInfoEditViewController.h"
#import "BengHomeStatuViewController.h"
#import "BengHomeDetailViewController.h"
#import "BengStatuViewController.h"
#import "XFSSViewController.h"
#import "MHQViewController.h"
#import "HZBJViewController.h"
#import "QTTJViewController.h"
#import "XFViewController.h"
#import "NFCController.h"
#import "NFCDeviceTypeListController.h"
#import "EditNFCequipmentViewController.h"
#import "LineChartViewController.h"
#import "FireLineChartViewController.h"
#import "XFListViewController.h"
#import "AddressDistrController.h"
#import "CustomeLineChatViewController.h"
#import "CheckSationListViewController.h"
#import "HostVendorViewController.h"
@interface SwitchViewController()

{
    UINavigationController __weak* _topNavigationController;
    NSCache *_cacher;
}

@property(nonatomic, weak) UINavigationController *topNavigationController;
@property(nonatomic, strong) MBProgressHUD *hud;
@property(nonatomic, strong) MBProgressHUD *showMessage;

@end

@implementation SwitchViewController



+(instancetype)sharedSVC
{
    static SwitchViewController *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [SwitchViewController new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cacher = [[NSCache alloc] init];
        //发出通知监听内存警告
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

//当发出内存警告，就释放缓存中的数据
-(void)didReceiveMemoryWarning
{
    [_cacher removeAllObjects];
}

-(void)hideHud
{
    [self.hud hide:YES];
}

-(void)hideLoadingView
{
    [_showMessage hide:YES];
}

-(void)hideHudAfterDelay:(NSTimeInterval)delay
{
    [self.hud hide:YES afterDelay:delay];
}


-(MBProgressHUD *)hud
{
    if (!_hud) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        _hud = [[MBProgressHUD alloc] initWithWindow:keyWindow];
        _hud.detailsLabelFont = [UIFont systemFontOfSize:16];
        self.hud.animationType = MBProgressHUDAnimationZoomIn;
        self.hud.cornerRadius = 5;
        [keyWindow addSubview:self.hud];
    }
    return _hud;
}

-(void)showMessage:(NSString *)message
{
    [self showMessage:message duration:2.0];
}

-(void)showMessage:(NSString *)message duration:(NSTimeInterval)time
{
    self.hud.mode = MBProgressHUDModeText;
    self.hud.detailsLabelText = message;
    [self.hud show:YES];
    [self.hud hide:YES afterDelay:time];
}

-(void)setHudMessage:(NSString *)message
{
    self.hud.detailsLabelText = message;
}


-(void)showLoadingWithMessage:(NSString *)message
{
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.detailsLabelText = message;
    [self.hud show:YES];
}



-(void)showLoadingWithMessage:(NSString *)message inView:(UIView *)view
{
    [_showMessage removeFromSuperview];
    
    _showMessage = [[MBProgressHUD alloc] initWithView:view];
    
    [view addSubview:_showMessage];
    
    _showMessage.labelText = message;
    [_showMessage show:YES];
}



-(void)pushReuseObject:(NSObject *)obj
{
    NSString *key = NSStringFromClass(obj.class);
    NSCache *cache = [_cacher objectForKey:key];
    if (!cache) {
        cache = [[NSCache alloc] init];
        //当缓存的数量超过countLimit，或者cost之和超过totalCostLimit，NSCache会自动释放部分缓存。
        [cache setCountLimit:1];
        [_cacher setObject:cache  forKey:key];
    }
    [cache setObject:obj forKey:key];
}

-(void)presentViewController:(BaseViewController *)vc
{
    UINavigationController *nav =[self aNavigationControllerWithRootViewController:vc];
    //模态视图的动画效果
    //    nav.modalPresentationStyle = UIModalPresentationCustom;
    //    nav.transitioningDelegate = [TXTransition sharedtransition];
    
    [self.topNavigationController presentViewController:nav animated:YES completion:NULL];
    self.topNavigationController = nav;
}


-(void)presentViewController:(BaseViewController *)vc withObjects:(NSDictionary *)intentDic
{
    vc.intentDic = intentDic;
    
    [self presentViewController:vc];
}


-(void)setTopNavigationController:(UINavigationController *)topNavigationController
{
    if ([topNavigationController isKindOfClass:[UINavigationController class]]) {
        
        _topNavigationController = topNavigationController;
    }else {
        
        _topNavigationController = nil;
    }
}




#pragma mark --getters

-(UINavigationController *)topNavigationController {
    if (!_topNavigationController) {
        _topNavigationController = self.rootNaviController;
        if (!_topNavigationController) {
            return nil;
        }
        UINavigationController* vc = (UINavigationController*)_topNavigationController.presentedViewController;
        while (vc) {
            _topNavigationController = vc;
            //此视图控制器的视图控制器或其最近的祖先。
            vc = (UINavigationController*)_topNavigationController.presentedViewController;
        }
    }
    
    
    return _topNavigationController;
}


@synthesize rootNaviController = _rootNaviController;

-(UINavigationController *)rootNaviController
{
    if (!_rootNaviController) {
        
        RootViewController *vc=[[RootViewController alloc] init];
        _rootNaviController = [self aNavigationControllerWithRootViewController:vc];
    }
    return _rootNaviController;
}



-(UINavigationController *)aNavigationControllerWithRootViewController:(BaseViewController *)vc
{
    UINavigationController *navi=[[UINavigationController alloc] init];
    [navi pushViewController:vc animated:NO];
    
    
    return navi;
}

-(void)pushViewController:(BaseViewController *)vc
{
    [self.topNavigationController pushViewController:vc animated:YES];
}

-(void)pushViewController:(BaseViewController *)vc withObjects:(NSDictionary *)intentDic
{
    vc.intentDic = intentDic;
    [self pushViewController:vc];
}


-(void)popToViewController:(UIViewController *)vc
{
    [self.topNavigationController popToViewController:vc animated:YES];
}

//推出一个视图
-(BaseViewController *)popViewController
{
    BaseViewController *vc =(BaseViewController *)[self.topNavigationController popViewControllerAnimated:YES];
    if (vc.canBeCached) {
        
        [self pushReuseObject:vc];
    }
    return vc;
}

//重新进入一个视图，并且释放缓存
-(NSObject *)popReuseObjectForClass:(Class)class
{
    //把class类型转换成NString,就是获取class的类名
    NSString *key = NSStringFromClass(class);
    
    NSCache *cache = [_cacher objectForKey:key];
    NSObject *obj = [cache objectForKey:key];
    [cache removeObjectForKey:key];
    return obj;
    
}

-(void)dismissTopViewControllerCompletion:(void (^)(void))completion
{
    UINavigationController* navi = (UINavigationController*)self.topNavigationController.presentingViewController;
    NSArray* vcs = self.topNavigationController.viewControllers;
    
    [self.topNavigationController dismissViewControllerAnimated:YES completion:^{
        [vcs enumerateObjectsUsingBlock:^(BaseViewController *vc, NSUInteger idx, BOOL *stop) {
            if ([vc respondsToSelector:@selector(canBeCached)]) {
                if ([vc canBeCached]) {
                    [self pushReuseObject:vc];
                }
            }
        }];
        self.topNavigationController = navi;
        if (completion) {
            completion();
        }
    }];
    
}



#pragma mark -------跳转界面-----

-(BaseViewController *)loginViewController
{
    
    LoginViewController *vc = (LoginViewController *)[self popReuseObjectForClass:[LoginViewController class]];
    if (!vc) {
        
        vc = [[LoginViewController alloc] init];
    }
    return vc;
}
//
////忘记密码界面
//-(BaseViewController *)forgetViewController
//{
//    ForgetViewController *vc = (ForgetViewController *)[self popReuseObjectForClass:[ForgetViewController class]];
//    if (!vc) {
//        
//        vc = [[ForgetViewController alloc] init];
//    }
//    return vc;
//}
//
//////注册界面
//-(BaseViewController *)registerViewController
//{
//    RegisterViewController *vc = (RegisterViewController *)[self popReuseObjectForClass:[RegisterViewController class]];
//    if (!vc) {
//        
//        vc = [[RegisterViewController alloc] init];
//    }
//    return vc;
//}
//
//
//
////修改密码
//-(BaseViewController *)changeLoginPasswordViewController
//{
//    ChangeLoginPasswordViewController *vc = (ChangeLoginPasswordViewController *)[self popReuseObjectForClass:[ChangeLoginPasswordViewController class]];
//    if (!vc) {
//        
//        vc = [[ChangeLoginPasswordViewController alloc] init];
//    }
//    return vc;
//}

//推送消息
-(BaseViewController *)pushMessageViewController
{
    PushMessageViewController *vc = (PushMessageViewController *)[self popReuseObjectForClass:[PushMessageViewController class]];
    if (!vc) {
        
        vc = [[PushMessageViewController alloc] init];
    }
    return vc;
    
}

//设置界面
-(BaseViewController *)settingViewController
{
    
    SettingViewController *vc = (SettingViewController *)[self popReuseObjectForClass:[SettingViewController class]];
    if (!vc) {
        
        vc = [[SettingViewController alloc] init];
    }
    return vc;
}

//首页详情
-(BaseViewController *)homeDetailViewController
{
    HomeDetailViewController *vc = (HomeDetailViewController *)[self popReuseObjectForClass:[HomeDetailViewController class]];
    if (!vc) {
        
        vc = [[HomeDetailViewController alloc] init];
    }
    return vc;
}

//故障
-(BaseViewController *)breakdownViewController
{
    BreakdownViewController *vc = (BreakdownViewController *)[self popReuseObjectForClass:[BreakdownViewController class]];
    if (!vc) {
        
        vc = [[BreakdownViewController alloc] init];
    }
    return vc;
}

//故障详情 BreakDownDetailViewController
-(BaseViewController *)breakDownDetailViewController
{
    BreakDownDetailViewController *vc = (BreakDownDetailViewController *)[self popReuseObjectForClass:[BreakDownDetailViewController class]];
    if (!vc) {
        
        vc = [[BreakDownDetailViewController alloc] init];
    }
    return vc;
}
//屏蔽
-(BaseViewController *)screenViewController{
     ScreenViewController *vc = (ScreenViewController *)[self popReuseObjectForClass:[ScreenViewController class]];
    if (!vc) {
        
        vc = [[ScreenViewController alloc] init];
    }
    return vc;

}
//火警
-(BaseViewController *)fireAlarmViewController
{
    FireAlarmViewController *vc = (FireAlarmViewController *)[self popReuseObjectForClass:[FireAlarmViewController class]];
    if (!vc) {
        
        vc = [[FireAlarmViewController alloc] init];
    }
    return vc;
}

//水系统
-(BaseViewController *)waterSystemViewController
{
    WaterSystemViewController *vc = (WaterSystemViewController *)[self popReuseObjectForClass:[WaterSystemViewController class]];
    if (!vc) {
        
        vc = [[WaterSystemViewController alloc] init];
    }
    return vc;
}

//我的工作
-(BaseViewController *)myWorkViewController
{
    MyWorkViewController *vc = (MyWorkViewController *)[self popReuseObjectForClass:[MyWorkViewController class]];
    if (!vc) {
        
        vc = [[MyWorkViewController alloc] init];
    }
    return vc;
}

//任务书
-(BaseViewController *)taskBookViewController
{
    TaskBookViewController *vc = (TaskBookViewController *)[self popReuseObjectForClass:[TaskBookViewController class]];
    if (!vc) {
        
        vc = [[TaskBookViewController alloc] init];
    }
    return vc;
}

//查岗选择
-(BaseViewController *)checkJobSelectViewController
{
    CheckJobSelectViewController *vc = (CheckJobSelectViewController *)[self popReuseObjectForClass:[CheckJobSelectViewController class]];
    if (!vc) {
        
        vc = [[CheckJobSelectViewController alloc] init];
    }
    return vc;
}
//动作反馈
-(BaseViewController *)motionFeedbackViewController{
    MotionFeedbackViewController *vc = (MotionFeedbackViewController *)[self popReuseObjectForClass:[MotionFeedbackViewController class]];
    if (!vc) {
        
        vc = [[MotionFeedbackViewController alloc] init];
    }
    return vc;
}
//查岗
-(BaseViewController *)checkJobViewController
{
    CheckJobViewController *vc = (CheckJobViewController *)[self popReuseObjectForClass:[CheckJobViewController class]];
    if (!vc) {
        
        vc = [[CheckJobViewController alloc] init];
    }
    return vc;
}

//视频
-(BaseViewController *)videoViewController
{
    VideoViewController *vc = (VideoViewController *)[self popReuseObjectForClass:[VideoViewController class]];
    if (!vc) {
        
        vc = [[VideoViewController alloc] init];
    }
    return vc;
}

//人员管理
-(BaseViewController *)peopleManageViewController
{
    PeopleManageViewController *vc = (PeopleManageViewController *)[self popReuseObjectForClass:[PeopleManageViewController class]];
    if (!vc) {
        
        vc = [[PeopleManageViewController alloc] init];
    }
    return vc;
}
//webview
-(BaseViewController *)DTWebViewController{
    DTCustomeWebViewController *vc = (DTCustomeWebViewController *)[self popReuseObjectForClass:[DTCustomeWebViewController class]];
    if (!vc) {
        
        vc = [[DTCustomeWebViewController alloc] init];
    }
    return vc;

}
//发布维修信息
-(BaseViewController *)pushServiceViewController
{
    PushServiceViewController *vc = (PushServiceViewController *)[self popReuseObjectForClass:[PushServiceViewController class]];
    if (!vc) {
        
        vc = [[PushServiceViewController alloc] init];
    }
    return vc;
}

//维修详情
-(BaseViewController *)serviceDetailViewController
{
    ServiceDetailViewController *vc = (ServiceDetailViewController *)[self popReuseObjectForClass:[ServiceDetailViewController class]];
    if (!vc) {
        
        vc = [[ServiceDetailViewController alloc] init];
    }
    return vc;
}

//联网单位
-(BaseViewController *)networkUnitViewController
{
    NetworkUnitViewController *vc = (NetworkUnitViewController *)[self popReuseObjectForClass:[NetworkUnitViewController class]];
    if (!vc) {
        
        vc = [[NetworkUnitViewController alloc] init];
    }
    return vc;
}

//扫描二维码
-(BaseViewController *)hCScanQRViewController
{
    HCScanQRViewController *vc = (HCScanQRViewController *)[self popReuseObjectForClass:[HCScanQRViewController class]];
    if (!vc) {
        
        vc = [[HCScanQRViewController alloc] init];
    }
    return vc;
}

//查看设备
-(BaseViewController *)lookNFCequipmentViewController
{
    LookNFCequipmentViewController *vc = (LookNFCequipmentViewController *)[self popReuseObjectForClass:[LookNFCequipmentViewController class]];
    if (!vc) {
        
        vc = [[LookNFCequipmentViewController alloc] init];
    }
    return vc;
    
}

//添加设备
-(BaseViewController *)addNFCequipmentViewController
{
    AddNFCequipmentViewController *vc = (AddNFCequipmentViewController *)[self popReuseObjectForClass:[AddNFCequipmentViewController class]];
    if (!vc) {
        
        vc = [[AddNFCequipmentViewController alloc] init];
    }
    return vc;
}

//巡检记录
-(BaseViewController *)pollingRecordViewController
{
    PollingRecordViewController *vc = (PollingRecordViewController *)[self popReuseObjectForClass:[PollingRecordViewController class]];
    if (!vc) {
        
        vc = [[PollingRecordViewController alloc] init];
    }
    return vc;
}

//巡检记录详情
-(BaseViewController *)pollingRecordDetailViewController
{
    PollingRecordDetailViewController *vc = (PollingRecordDetailViewController *)[self popReuseObjectForClass:[PollingRecordDetailViewController class]];
    if (!vc) {
        
        vc = [[PollingRecordDetailViewController alloc] init];
    }
    return vc;
}

//巡检记录上传
-(BaseViewController *)pollingRecordUploadViewController
{
    PollingRecordUploadViewController *vc = (PollingRecordUploadViewController *)[self popReuseObjectForClass:[PollingRecordUploadViewController class]];
    if (!vc) {
        
        vc = [[PollingRecordUploadViewController alloc] init];
    }
    return vc;
}
-(BaseViewController *)conmunicationBreakdownViewController{
    ConmunicationBreakdownViewController *vc = (ConmunicationBreakdownViewController *)[self popReuseObjectForClass:[ConmunicationBreakdownViewController class]];
    if (!vc) {
        
        vc = [[ConmunicationBreakdownViewController alloc] init];
    }
    return vc;

}
//电压
-(BaseViewController *)voltageViewController
{
    VoltageViewController *vc = (VoltageViewController *)[self popReuseObjectForClass:[VoltageViewController class]];
    if (!vc) {
        
        vc = [[VoltageViewController alloc] init];
    }
    return vc;
}


//-(BaseViewController *)baseWebViewViewController
//{
//    
//    BaseWebViewController *vc = (BaseWebViewController *)[self popReuseObjectForClass:[BaseWebViewController class]];
//    if (!vc) {
//        
//        vc = [[BaseWebViewController alloc] init];
//    }
//    return vc;
//}

//NFC
-(BaseViewController *)NFCViewController{
    NFCViewController *vc = (NFCViewController *)[self popReuseObjectForClass:[NFCViewController class]];
    if (!vc) {
        
        vc = [[NFCViewController alloc] init];
    }
    return vc;

}
//主机列表
-(BaseViewController *)HostListViewController{
    HostInfoListViewController *vc = (HostInfoListViewController *)[self popReuseObjectForClass:[HostInfoListViewController class]];
    if (!vc) {
        
        vc = [[HostInfoListViewController alloc] init];
    }
    return vc;
}
//主机信息
-(BaseViewController *)HostDetailViewController{
    HostInfoDetailViewController *vc = (HostInfoDetailViewController *)[self popReuseObjectForClass:[HostInfoDetailViewController class]];
    if (!vc) {
        
        vc = [[HostInfoDetailViewController alloc] init];
    }
    return vc;

}
//编辑主机信息
-(BaseViewController *)HostEditViewController{
    HostInfoEditViewController *vc = (HostInfoEditViewController *)[self popReuseObjectForClass:[HostInfoEditViewController class]];
    if (!vc) {
        
        vc = [[HostInfoEditViewController alloc] init];
    }
    return vc;

}
-(BaseViewController *)BengHomeStatuViewController{
    BengHomeStatuViewController *vc = (BengHomeStatuViewController *)[self popReuseObjectForClass:[BengHomeStatuViewController class]];
    if (!vc) {
        
        vc = [[BengHomeStatuViewController alloc] init];
    }
    return vc;
}
-(BaseViewController *)BengHomeDetailViewController{
    BengHomeDetailViewController *vc = (BengHomeDetailViewController *)[self popReuseObjectForClass:[BengHomeDetailViewController class]];
    if (!vc) {
        
        vc = [[BengHomeDetailViewController alloc] init];
    }
    return vc;

}

-(BaseViewController *)BengStatuViewController{
    BengStatuViewController *vc = (BengStatuViewController *)[self popReuseObjectForClass:[BengStatuViewController class]];
    if (!vc) {
        
        vc = [[BengStatuViewController alloc] init];
    }
    return vc;

}
-(BaseViewController *)XFSSViewController{
    XFSSViewController *vc = (XFSSViewController *)[self popReuseObjectForClass:[XFSSViewController class]];
    if (!vc) {
        
        vc = [[XFSSViewController alloc] init];
    }
    return vc;

}
-(BaseViewController *)MHQViewController{
    MHQViewController *vc = (MHQViewController *)[self popReuseObjectForClass:[MHQViewController class]];
    if (!vc) {
        
        vc = [[MHQViewController alloc] init];
    }
    return vc;

}
-(BaseViewController *)HZBJViewController{
    HZBJViewController *vc = (HZBJViewController *)[self popReuseObjectForClass:[HZBJViewController class]];
    if (!vc) {
        
        vc = [[HZBJViewController alloc] init];
    }
    return vc;

}
-(BaseViewController *)QTTJViewController{
    QTTJViewController *vc = (QTTJViewController *)[self popReuseObjectForClass:[QTTJViewController class]];
    if (!vc) {
        
        vc = [[QTTJViewController alloc] init];
    }
    return vc;

}
-(BaseViewController *)XFViewController{
    XFViewController *vc = (XFViewController *)[self popReuseObjectForClass:[XFViewController class]];
    if (!vc) {
        
        vc = [[XFViewController alloc] init];
    }
    return vc;

}
-(BaseViewController *)NFCController{
    NFCController *vc = (NFCController *)[self popReuseObjectForClass:[NFCController class]];
    if (!vc) {
        
        vc = [[NFCController alloc] init];
    }
    return vc;
}
-(BaseViewController *)NFCDeviceTypeListController{
    NFCDeviceTypeListController *vc = (NFCDeviceTypeListController *)[self popReuseObjectForClass:[NFCDeviceTypeListController class]];
    if (!vc) {
        
        vc = [[NFCDeviceTypeListController alloc] init];
    }
    return vc;

}
-(BaseViewController *)editDeviceInfoController{
    EditNFCequipmentViewController *vc = (EditNFCequipmentViewController *)[self popReuseObjectForClass:[EditNFCequipmentViewController class]];
    if (!vc) {
        
        vc = [[EditNFCequipmentViewController alloc] init];
    }
    return vc;
}
-(BaseViewController *)lineChartController{
    LineChartViewController *vc = (LineChartViewController *)[self popReuseObjectForClass:[LineChartViewController class]];
    if (!vc) {
        
        vc = [[LineChartViewController alloc] init];
    }
    return vc;

}
-(BaseViewController *)FireLineChartViewController{
    FireLineChartViewController *vc = (FireLineChartViewController *)[self popReuseObjectForClass:[FireLineChartViewController class]];
    if (!vc) {
        
        vc = [[FireLineChartViewController alloc] init];
    }
    return vc;

}
-(BaseViewController *)XFListViewController{
    XFListViewController *vc = (XFListViewController *)[self popReuseObjectForClass:[XFListViewController class]];
    if (!vc) {
        
        vc = [[XFListViewController alloc] init];
    }
    return vc;

}
-(BaseViewController *)AddressDistrController{
    AddressDistrController *vc = (AddressDistrController *)[self popReuseObjectForClass:[AddressDistrController class]];
    if (!vc) {
        
        vc = [[AddressDistrController alloc] init];
    }
    return vc;
}
-(BaseViewController *)CustomeLineChatViewController{
    CustomeLineChatViewController *vc = (CustomeLineChatViewController *)[self popReuseObjectForClass:[CustomeLineChatViewController class]];
    if (!vc) {
        
        vc = [[CustomeLineChatViewController alloc] init];
    }
    return vc;

}
-(BaseViewController *)CheckStationListViewController{
    CheckSationListViewController *vc = (CheckSationListViewController *)[self popReuseObjectForClass:[CheckSationListViewController class]];
    if (!vc) {
        
        vc = [[CheckSationListViewController alloc] init];
    }
    return vc;

}
-(BaseViewController *)HostVendorViewController{
    HostVendorViewController *vc = (HostVendorViewController *)[self popReuseObjectForClass:[HostVendorViewController class]];
    if (!vc) {
        
        vc = [[HostVendorViewController alloc] init];
    }
    return vc;

}
@end
