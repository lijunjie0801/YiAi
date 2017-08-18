/**
 *  ReadMe:
 *  AboutLog:
 *  >>>>> 代表请求出的信息
 *  <<<<< 代表获取到的信息
 *
 */

#import "RequestManager.h"
#import "URLManager.h"
#import "AFNetworkActivityIndicatorManager.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
#import "AFHTTPSessionManager.h"
#endif

@implementation MKRequestTask

- (instancetype)initWithTaskOrOperation:(id)obj
{
    self = [super init];
    if (self) {
        _sessionTaskOrOperation = obj;
    }
    return self;
}

- (void)cancel
{
    if ([_sessionTaskOrOperation respondsToSelector:@selector(cancel)]) {
        [_sessionTaskOrOperation cancel];
    }
}
@end

@implementation RequestManager

//post请求
+ (MKRequestTask *)postRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestCompletionHandler)completionHandler failureHandler:(FailureHandler)failureHandler{
    
 
    NSLog(@"参数：%@------%@",requestPath,paramer);
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    //设置响应数据的格式
    //AFHTTPResponseSerializer 返回的数据类型为二进制类型
    //AFJSONResponseSerializer 返回数据类型为json类型
    //AFXMLParserResponseSerializer xml类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:requestPath parameters:paramer progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       
        NSString *dataStr =[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        //            NSLog(@"返回结果=====%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSRange start = [dataStr rangeOfString:@"{"];
        
        NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:dataStr.length];
        for (int i = (int)dataStr.length - 1; i >=0 ; i --) {
            
            unichar ch = [dataStr characterAtIndex:i];
            [newString appendFormat:@"%c", ch];
        }
        
        NSRange end = [newString rangeOfString:@"}"];
        
        NSString *sub = [dataStr substringWithRange:NSMakeRange(start.location, dataStr.length- end.location -start.location)];
        
        sub = [sub stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        sub = [sub stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSData *jsonData = [sub dataUsingEncoding:NSUTF8StringEncoding];
        
        //2.将NSData解析为NSDictionary
      //  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                            options:NSJSONReadingMutableContainers
//                                                              error:nil];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        completionHandler(dictionary);
//            NSLog(@"年后");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        NSLog(@"年后");
        failureHandler(error,0);
        
        
    }];
    
    
  
    return nil;
    

}

//get请求
+ (MKRequestTask *) getRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestCompletionHandler)completionHandler failureHandler:(FailureHandler)failureHandler{
    
    
    NSLog(@"获取表头的信息是:%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]);

  
//    
//    [[AFNetAPIClient sharedJsonClient].setRequest(requestPath).RequestType(Get).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(paramer) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        
//        
//         completionHandler(responseObject);
//        
//
//        
//        
//        
//    } progress:^(NSProgress *progress) {
//        
//        NSLog(@"1111");
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        failureHandler(error,0);
//    }];
//    
//    return [[MKRequestTask alloc] initWithTaskOrOperation:@""];
    return nil;
    
    
    
    

}

+ (MKRequestTask *) deleteRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestCompletionHandler)completionHandler failureHandler:(FailureHandler)failureHandler{
    
    

    
    return nil;
}

+ (MKRequestTask *) uploadFileRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer postData:(NSData *)postData postType:(NSInteger)postType completionHandler:(RequestCompletionHandler)completionHandler progressHandler:(ProgressHandler)progressHandler failureHandler:(FailureHandler)failureHandler{
    
    
    
//    [[AFNetAPIClient sharedJsonClient].setRequest(requestPath).Parameters(paramer).filedata(postData).name(@"userImg").filename(@"userImg.jpg").mimeType(@"image/jpeg") uploadfileWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"成功");
//        completionHandler(responseObject);
//        
//    } progress:^(NSProgress *progress) {
//        NSLog(@"1111");
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"bu成功");
//        
//        failureHandler(error,0);
//    }];
    
    
    
//    [[AFNetAPIClient sharedJsonClient].setRequest(requestPath).Parameters(paramer).filedata(postData).name(@"userImg").mimeType(@"image/jpeg") uploadfileWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
//        
//         completionHandler(responseObject);
//        
//    } progress:^(NSProgress *progress) {
//        
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        failureHandler(error,0);
//        
//    }];
    
//    NSString *fileName = @"file";
//    if (postType == 0) {
//        fileName = @"image.jpg";
//    }else{
//        fileName = @"video.mp4";
//    }
//    
//    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
//    
//    NSString* url = [URLManager requestURLGenetatedWithURL:requestPath];
//    NSMutableURLRequest *request =
//    [serializer multipartFormRequestWithMethod:@"POST" URLString:url parameters:paramer constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:postData
//                                    name:@"bin"
//                                fileName:fileName
//                                mimeType:@"application/octet-stream"];
//    } error:nil];
//    
//    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
//    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    AFHTTPRequestOperation *operation =
//    [operationManager HTTPRequestOperationWithRequest:request
//                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                                  
//                                                  NSUInteger statusCode = operation.response.statusCode;
//                                                  if (statusCode == 200) {
//                                                      NSString *requestTmp = [NSString stringWithString:operation.responseString];
//                                                      NSLog(@"<<<<< Success:\n%@\n string:\n%@", operation.response,requestTmp);
//                                                      
//                                                      completionHandler(requestTmp);
//                                                      
//                                                  }
//                                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                                  
//                                                  NSLog(@"Failure %@", error);
//                                                  
//                                                  failureHandler(error,operation.response.statusCode);
//                                              }];
//    
//    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        CGFloat progress = (bytesWritten / (double)totalBytesWritten) * 100;
//        if (progressHandler) {
//            progressHandler(progress);
//        }
//    }];
//    
//    [operation start];
//    
//    return [[MKRequestTask alloc]initWithTaskOrOperation:operation];
    
    return nil;
    
}

+ (MKRequestTask *)downloadFileRquestWithFileUrl:(NSString *)fileUrl fileName:(NSString *)fileName fileCachePath:(NSString *)fileCachePath completionHandler:(RequestCompletionHandler)completionHandler progressHandle:(ProgressHandler)progressHandle failureHandler:(FailureHandler)failureHandler{
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fileUrl]];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:fileCachePath append:NO];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSUInteger statusCode = operation.response.statusCode;
//        if (statusCode == 200) {
//            completionHandler(fileCachePath);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        failureHandler(error,operation.response.statusCode);
//    }];
//    
//    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//        CGFloat progress = (bytesRead / totalBytesRead) * 100;
//        progressHandle(progress);
//    }];
//    
//    [operation start];
//    
//    return [[MKRequestTask alloc]initWithTaskOrOperation:operation];
    return nil;
}
@end
