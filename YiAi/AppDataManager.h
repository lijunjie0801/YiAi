
#import <Foundation/Foundation.h>

@interface AppDataManager : NSObject


+(instancetype)defaultManager;

@property (nonatomic,strong) NSString            * identifier;
/**
 *  和identifier相同
 */
@property (readwrite,nonatomic,strong ) NSString            *useridAccount;//用户的id

@property (readwrite, nonatomic,strong) NSString            *passWord;//登录密码

@property (readwrite, nonatomic,strong) NSString            *PhoneAccount;//登录账号





@property(nonatomic, strong, readwrite) NSArray *BannerModelArray; //广告栏的信息






-(BOOL)hasLogin;

-(void)logout;

-(BOOL)isChangeUser;

-(void)loginWithIdentifier:(NSString *)identifier;


@end
