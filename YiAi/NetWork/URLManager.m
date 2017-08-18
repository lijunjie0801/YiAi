 

#import "URLManager.h"

////////////////////////////////////正式环境/////////////////////////////////////

#if DEBUG
NSString *const KBaseURL                     = @"http://www.eifire.net:9010/EIFIRE_Interface.asmx/";

#else
NSString *const KBaseURL                     = @"http://www.eifire.net:9010/EIFIRE_Interface.asmx/";
#endif

////////////////////////////////////测试/////////////////////////////////////
//#if DEBUG
//NSString *const KBaseURL                     = @"http://shangxiao.zilankeji.com/api.php/";
//#else
//NSString *const KBaseURL                     = @"http://shangxiao.zilankeji.com/api.php/";
//#endif

//用户行为



NSString *const KURLHome                     = @"indexProcodes"; //首页数据

NSString *const KURLHostList                     = @"getHostList"; //主机列表
NSString *const KURLUpdateProImg                     = @"updateProImg"; //更新项目图像
NSString *const KURLSerLGStatus                     = @"serLGStatus"; //查询离岗状态
NSString *const KURLFingGuard                     = @"fingGuard"; //查询离岗写入下行表
NSString *const KURLGuardHistory                     = @"guardHistory"; //查询离岗结束写入离岗查询历史表
NSString *const KURLMHQList                     = @"MHQAllList"; //灭火器种类列表

NSString *const KURLXFTypeList           = @"transforDataAllList"; //消防种类列表
NSString *const KURLAlarmStatisticalAnalysis           = @"alarmStatisticalAnalysis"; //折线图数据
NSString *const KURLMHQDetaiList                = @"getMHQList"; //灭火器列表
NSString *const KURLNFCAllList                = @"nfcAllList"; //nfc种类列表
NSString *const KURLNfcList                = @"getNfcList"; //nfc信息列表
NSString *const KURLBengHomeList            = @"getProCodeTransforDataList"; //泵房列表

NSString *const KURLTransforOrderTypeList            = @"transforOrderTypeList"; //消防列表

NSString *const KURLHostCompanyList            = @"hostCompanyList"; //主机厂商列表
NSString *const KURLNfcTypeDistributed            = @"nfcTypeDistributed"; //柱状图
NSString *const KURLNfcAdressDistributed            = @"nfcAdressDistributed"; //饼图
NSString *const KURLBengHomeDetail            = @"getDetailFromType"; //泵房详情
NSString *const KURLHostDetail                     = @"getHostForm"; //主机信息

NSString *const KURLHostChange                    = @"changeHostForm"; //修改主机信息

NSString *const KURLHomeMessageNum           = @"indexAlarmNumsNew"; //首页消息数目

NSString *const KURLGoodList                 = @"alarmListNew";//项目列表

NSString *const KURLFireStaAnaList                 = @"fireStaAnaList";//自定义折线图

NSString *const KURLTypeControlList          = @"setTypeControlList";//消防设施

NSString *const KURLPersonList                 = @"getPersonManageList";//人员列表


NSString *const KURLHistory                = @"nfcPatrolHistory"; //nfc巡查

NSString *const KURLFireDetail                 = @"fireDetail";//故障详情

NSString *const KURLNFCInfo                 = @"getNfcDevice";//nfc

NSString *const KURLAddNFCInfo                 = @"addNfcDevice";//添加nfc设备

NSString *const KURLUpdateNfcDevice                 = @"updateNfcDevice";//修改nfc设备

NSString *const KURLPollingUpload           = @"addNfcPatrolHistory";//上传巡检记录

NSString *const KURLGetProCode           = @"getPronames";//获取procode

NSString *const KURLWaterGoodList            = @"tranDevList";//水系统列表

NSString *const KURLStringSendSma            = @"user/sendCode";//获取验证码

NSString *const KURLStringLogin              = @"nameLogin";//用户登录
NSString *const KURLStringRegister           = @"user/userReg";//用户注册


NSString *const KULStringForgetPassword       = @"user/changePwd";//忘记密码




NSString *const KURLLogOut                    = @"user/loginOut";//用户退出

NSString *const KULMyInfo                      = @"userCenter/index";//用户个人信息

NSString *const KURLMyImg                      = @"userCenter/changeUserImg";//用户个人头像
NSString *const KURLChangeMyInfo               = @"userCenter/changeUserInfo";//修改用户信息

NSString *const KULChangePwd                  = @"userCenter/changeUserPwd";//修改密码


NSString *const KURLShopping                 = @"goods/goodsList";//商城
NSString *const KURLMoreShopping             = @"goods/goodsTuList";//多爱拼商城

NSString *const KURLShoppingType             = @"goods/sysClassList";//商城分类

NSString *const KURLSearchList              = @"goods/goodsSearchList";//查找列表

NSString *const KURLTabbarAdBanner           = @"index/getBannerHZ"; //首页中的轮播图






//h5界面

NSString *const KURLHomeDouBan               = @"otherShop/jianzhi";//豆荚兼职
NSString *const KURLHomeYiEr                 = @"otherShop/bookStore";//一二书城


NSString *const KURLShoppingCar              = @"goods/shopList";//购物车

NSString *const KURLGoodLidt                 = @"goods/goodsOne";//商品详情
NSString *const KURLOrdeList                 = @"userCenter/orderList";//订单列表

NSString *const KURLUserRecharge             = @"userCenter/userRecharge";//充值
NSString *const KURLUserWithdraw             = @"userCenter/userCash";//提现

NSString *const KURLJiaoYiList               = @"userCenter/capitalList";//交易
NSString *const KURLBanbenXinxi              = @"userCenter/edition";//版本信息
NSString *const KURLInvite                   = @"userCenter/userTuiList";//邀请用户
NSString *const KURLHelpe                    = @"userCenter/help";//帮助中心

NSString *const KURLMyFinance                = @"userCenter/finance";//或是金融

NSString *const KURLMyShouCang               = @"user/userCollectList";//收藏

NSString *const KURLMyShiTang                = @"userCenter/mingshitang";//名师堂


NSString *const KURLAddress                  = @"userCenter/userAddrList";//收货地址



@implementation URLManager

+ (NSString *)requestURLGenetatedWithURL:(NSString *const) path
{
 
    return [KBaseURL stringByAppendingString:path];
}
@end
