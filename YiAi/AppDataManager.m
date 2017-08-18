//
//  AppDataManager.m
//  BenShiFu
//
//  Created by fyaex001 on 16/8/16.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "AppDataManager.h"


NSString * const appDidLogoutNotification = @"appDidLogoutNotification";
NSString * const appDidLoginNotification =  @"appDidLoginNotification";


static AppDataManager* instance;

@interface AppDataManager()

@property(readonly, nonatomic)NSUserDefaults* userDefaults;
@property(readonly, nonatomic)NSDictionary * userDictionary;

@end

@implementation AppDataManager

+(instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AppDataManager alloc] init];
    });
    
    return instance;
}

-(NSDictionary *)userDictionary
{
    if (![self identifier]) {
        return nil;
    }
    return [self.userDefaults objectForKey:[self identifier]];
}

-(NSUserDefaults *)userDefaults {
    
    return [NSUserDefaults standardUserDefaults];
}

-(void)setIdentifier:(NSString *)identifier {
    if (!identifier) {
        [self.userDefaults removeObjectForKey:@"identifier"];
        [self.userDefaults synchronize];
        return;
    }
    NSString *identifierStr = [NSString stringWithFormat:@"%@",identifier];
    
    [self.userDefaults setObject:identifierStr forKey:@"identifier"];
    NSDictionary* dic = [self.userDefaults objectForKey:identifierStr];
    if (!dic) {
        dic = @{@"isOff":@(1)};
        [self.userDefaults setObject:dic forKey:identifierStr];
    }
    
    [self.userDefaults synchronize];
}

-(NSString *)identifier {
    
    return [self.userDefaults objectForKey:@"identifier"];
}
//账号
-(void)setUseridAccount:(NSString *)useridAccount
{
    if (![self userDictionary]){
        return;
    }
    NSMutableDictionary* dic = [self.userDictionary mutableCopy];
    [dic setObject:useridAccount forKey:@"useridAccount"];
    
    [self.userDefaults setObject:dic forKey:[self identifier]];
    [self.userDefaults synchronize];
}

-(NSString *)useridAccount
{
    return [self.userDictionary objectForKey:@"useridAccount"];
}



//登录账号
-(NSString *)PhoneAccount
{
    return [self.userDefaults objectForKey:@"phoneAccount"];
}

-(void)setPhoneAccount:(NSString *)PhoneAccount
{
  
    [self.userDefaults setObject:PhoneAccount forKey:@"phoneAccount"];
    [self.userDefaults synchronize];
}



//保存登录密码
-(void)setPassWord:(NSString *)passWord
{
    if (![self identifier]) {
        
        return;
    }
    [self.userDefaults setObject:passWord forKey:@"passWord"];
    [self.userDefaults synchronize];
}

-(NSString *)passWord
{
    
    return [self.userDefaults objectForKey:@"passWord"];
}






//搜索历史
-(void)setHistorySearchArray:(NSMutableArray *)historySearchArray
{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:historySearchArray];
    
    [self.userDefaults setObject:data forKey:@"historySearchArray"];
    [self.userDefaults synchronize];
}

-(NSMutableArray *)historySearchArray
{
    NSData *data = [self.userDefaults valueForKey:@"historySearchArray"];
    NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arr;
}





//储存广告栏的信息
-(void)setBannerModelArray:(NSArray *)BannerModelArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:BannerModelArray];
    
    [self.userDefaults setObject:data forKey:@"BannerModel"];
    [self.userDefaults synchronize];
    
}

-(NSArray *)BannerModelArray
{
    NSData *data = [self.userDefaults valueForKey:@"BannerModel"];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arr;
}





-(BOOL)hasLogin
{
    return [self identifier].length ? YES:NO;
}



-(void)logout {


    [[AppDataManager defaultManager] setUseridAccount:@""];
    [[AppDataManager defaultManager] setPhoneAccount:@""];
    [[AppDataManager defaultManager] setPassWord:@""];
    [self setIdentifier:nil];

    
   
}

-(BOOL)isChangeUser
{
    //    if([[UserModel sharedModel].userid isEqualToString:[self identifier]] )
    //    {
    //        return NO;
    //    }
    return YES;
    
}




@end
