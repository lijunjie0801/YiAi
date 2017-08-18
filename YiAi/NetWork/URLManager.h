 

#import <Foundation/Foundation.h>

extern NSString *const KBaseURL;  //服务器地址

//用户行为

extern NSString *const KURLHome; //首页数据
extern NSString *const KURLHomeMessageNum; //首页消息数目
extern NSString *const KURLGetProCode;//获取procode
extern NSString *const KURLGoodList;//项目列表
extern NSString *const KURLAddNFCInfo;//添加nfc设备
extern NSString *const KURLHistory;//nfc巡查
extern NSString *const KURLPersonList;//人员列表
extern NSString *const KURLHostList; //主机列表
extern NSString *const KURLHostDetail; //主机信息
extern NSString *const KURLHostChange; //修改主机信息
extern NSString *const KURLPollingUpload;//上传巡检记录
extern NSString *const KURLBengHomeList;//泵房列表
extern NSString *const KURLWaterGoodList;//水系统列表

extern NSString *const KURLFireDetail;//故障详情

extern NSString *const KURLNFCInfo;//NFC
extern NSString *const KURLStringSendSma;//获取验证码
extern NSString *const KURLStringLogin;//用户登录
extern NSString *const KURLStringRegister;//用户注册
extern NSString *const KURLBengHomeDetail; //泵房详情
extern NSString *const KULStringForgetPassword;//忘记密码
extern NSString *const KURLLogOut;//用户退出
extern NSString *const KURLTypeControlList;//消防设施
extern NSString *const KURLMyImg;//用户个人头像
extern NSString *const KURLChangeMyInfo;//修改用户信息
extern NSString *const KURLMHQList; //灭火器种类列表
extern NSString *const KURLMHQDetaiList; //灭火器列表
extern NSString *const KULChangePwd;//修改密码
extern NSString *const KULMyInfo;//用户个人信息
extern NSString *const KURLXFTypeList; //消防种类列表
extern NSString *const KURLNFCAllList; //nfc种类列表
extern NSString *const KURLShopping;//商城
extern NSString *const KURLMoreShopping;//多爱拼商城
extern NSString *const KURLShoppingType;//商城分类
extern NSString *const KURLSearchList;//查找列表
extern NSString *const KURLNfcList; //nfc信息列表
extern NSString *const KURLUpdateNfcDevice;//修改nfc设备
extern NSString *const KURLMyFinance;//或是金融
extern NSString *const KURLMyShiTang;//名师堂
extern NSString *const KURLAlarmStatisticalAnalysis; //折线图数据
extern NSString *const KURLTransforOrderTypeList; //消防列表
extern NSString *const KURLTabbarAdBanner; //首页中的轮播图
extern NSString *const KURLNfcTypeDistributed; //柱状图
extern NSString *const KURLNfcAdressDistributed; //饼图
extern NSString *const KURLFireStaAnaList;//自定义折线图
extern NSString *const KURLSerLGStatus; //查询离岗状态
extern NSString *const KURLFingGuard; //查询离岗写入下行表
extern NSString *const KURLGuardHistory; //查询离岗结束写入离岗查询历史表
extern NSString *const KURLUpdateProImg; //更新项目图像
//h5界面
extern NSString *const KURLHostCompanyList; //主机厂商列表
extern NSString *const KURLHomeDouBan;//豆荚兼职
extern NSString *const KURLHomeYiEr;//一二书城

extern NSString *const KURLGoodLidt;//商品详情
extern NSString *const KURLOrdeList;//订单列表
extern NSString *const KURLUserRecharge;//充值
extern NSString *const KURLUserWithdraw;//提现

extern NSString *const KURLJiaoYiList;//交易
extern NSString *const KURLBanbenXinxi;//版本信息
extern NSString *const KURLInvite;//邀请用户
extern NSString *const KURLHelpe;//帮助中心

extern NSString *const KURLMyShouCang;//收藏

extern NSString *const KURLAddress;//收货地址

extern NSString *const KURLShoppingCar;//购物车




@interface URLManager : NSObject
+ (NSString *)requestURLGenetatedWithURL:(NSString *const) path;
@end
