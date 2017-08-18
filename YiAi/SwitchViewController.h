//
//  SwitchViewController.h
//  NewKuangJia
//
//  Created by fyaex001 on 2017/1/6.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BaseViewController;
@interface SwitchViewController : NSObject

+(instancetype)sharedSVC;

@property(nonatomic ,readonly)UINavigationController *rootNaviController;

-(UINavigationController *)topNavigationController;


/**
 *  展示信息到window
 */
-(void)showMessage:(NSString *)message;
-(void)showMessage:(NSString *)message duration:(NSTimeInterval)time;
-(void)setHudMessage:(NSString*)message;

-(void)showLoadingWithMessage:(NSString*)message;
-(void)hideHud;
-(void)hideHudAfterDelay:(NSTimeInterval)delay;

-(void)showLoadingWithMessage:(NSString *)message inView:(UIView *)view;
-(void)hideLoadingView;

-(void)pushViewController:(BaseViewController*)vc;
-(void)pushViewController:(BaseViewController*)vc withObjects:(NSDictionary*)intentDic;
-(BaseViewController*)popViewController;
-(void)popToViewController:(UIViewController *)vc;

-(void)presentViewController:(BaseViewController*)vc;

//跳转页面
-(void)presentViewController:(BaseViewController*)vc withObjects:(NSDictionary*)intentDic;

-(void)dismissTopViewControllerCompletion:(void (^)(void))completion;





//到登录界面
-(BaseViewController *)loginViewController;
//忘记密码界面
-(BaseViewController *)forgetViewController;

//注册
-(BaseViewController *)registerViewController;

//首页详情
-(BaseViewController *)homeDetailViewController;


//火警
-(BaseViewController *)fireAlarmViewController;

//故障
-(BaseViewController *)breakdownViewController;
//故障详情
-(BaseViewController *)breakDownDetailViewController;
//水系统
-(BaseViewController *)waterSystemViewController;
//我的工作
-(BaseViewController *)myWorkViewController;
//任务书
-(BaseViewController *)taskBookViewController;
//查岗选择
-(BaseViewController *)checkJobSelectViewController;
//查岗
-(BaseViewController *)checkJobViewController;
//视频
-(BaseViewController *)videoViewController;
//人员管理
-(BaseViewController *)peopleManageViewController;
//发布维修信息
-(BaseViewController *)pushServiceViewController;
//维修详情
-(BaseViewController *)serviceDetailViewController;

//联网单位
-(BaseViewController *)networkUnitViewController;


//扫描二维码
-(BaseViewController *)hCScanQRViewController;

//查看设备
-(BaseViewController *)lookNFCequipmentViewController;
//添加设备
-(BaseViewController *)addNFCequipmentViewController;

//巡检记录
-(BaseViewController *)pollingRecordViewController;
//巡查记录详情
-(BaseViewController *)pollingRecordDetailViewController;

//巡检记录上传
-(BaseViewController *)pollingRecordUploadViewController;

//电压
-(BaseViewController *)voltageViewController;



//设置
-(BaseViewController *)settingViewController;
//推送消息
-(BaseViewController *)pushMessageViewController;


-(BaseViewController *)baseWebViewViewController;

//通讯故障
-(BaseViewController *)conmunicationBreakdownViewController;

//屏蔽
-(BaseViewController *)screenViewController;

//动作反馈
-(BaseViewController *)motionFeedbackViewController;


//动作反馈
-(BaseViewController *)NFCViewController;

//webview
-(BaseViewController *)DTWebViewController;

//主机列表
-(BaseViewController *)HostListViewController;

//主机信息
-(BaseViewController *)HostDetailViewController;

//编辑主机信息
-(BaseViewController *)HostEditViewController;

//泵房状态
-(BaseViewController *)BengHomeStatuViewController;
//泵房列表详情
-(BaseViewController *)BengHomeDetailViewController;
//泵状态详情
-(BaseViewController *)BengStatuViewController;
//消防设施
-(BaseViewController *)XFSSViewController;

//灭火器
-(BaseViewController *)MHQViewController;

//火灾报警
-(BaseViewController *)HZBJViewController;

//其他统计
-(BaseViewController *)QTTJViewController;

//消防
-(BaseViewController *)XFViewController;

//NFC
-(BaseViewController *)NFCController;

//NFC设备列表
-(BaseViewController *)NFCDeviceTypeListController;

//修改设备信息
-(BaseViewController *)editDeviceInfoController;
//折线图
-(BaseViewController *)lineChartController;
//火警折线图
-(BaseViewController *)FireLineChartViewController;

//消防列表
-(BaseViewController *)XFListViewController;
//饼状图
-(BaseViewController *)AddressDistrController;
//自定义折线图
-(BaseViewController *)CustomeLineChatViewController;
//查岗选择
-(BaseViewController *)CheckStationListViewController;
//主机厂商列表
-(BaseViewController *)HostVendorViewController;
@end
