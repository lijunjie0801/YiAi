 

#import <Foundation/Foundation.h>
//#import "AFHTTPRequestOperationManager.h"

typedef void(^RequestCompletionHandler)(id responseObject);
typedef void(^ProgressHandler)(CGFloat progress);
typedef void(^FailureHandler)(NSError *error,NSUInteger statusCode);

@interface MKRequestTask : NSObject
@property(strong, nonatomic)id sessionTaskOrOperation;
-(void)cancel;
@end

@interface RequestManager : NSObject

#pragma mark --
#pragma mark --  POST
+ (MKRequestTask *) postRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestCompletionHandler)completionHandler failureHandler:(FailureHandler)failureHandler;

#pragma mark --
#pragma mark --  GET
+ (MKRequestTask *) getRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestCompletionHandler)completionHandler failureHandler:(FailureHandler)failureHandler;

#pragma mark --
#pragma mark --  DELETE
+ (MKRequestTask *) deleteRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestCompletionHandler)completionHandler failureHandler:(FailureHandler)failureHandler;

#pragma mark --
#pragma mark --  UPLOAD
+ (MKRequestTask *) uploadFileRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer postData:(NSData *)postData postType:(NSInteger)postType completionHandler:(RequestCompletionHandler)completionHandler progressHandler:(ProgressHandler)progressHandler failureHandler:(FailureHandler)failureHandler;

#pragma mark --
#pragma mark --  DOWNLOAD
+ (MKRequestTask *) downloadFileRquestWithFileUrl:(NSString *)fileUrl fileName:(NSString *)fileName fileCachePath:(NSString *)fileCachePath completionHandler:(RequestCompletionHandler) completionHandler progressHandle:(ProgressHandler)progressHandle failureHandler:(FailureHandler)failureHandler;

@end
