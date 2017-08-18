//
//  DTCustomeWebViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/8.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "DTCustomeWebViewController.h"
#import "WebViewJS.h"
#import "BackBtn.h"
#import "XDAlertController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface DTCustomeWebViewController ()<BackBtnDelegate,UIWebViewDelegate,WebViewJSDelegate>
@property (nonatomic,strong) UIWebView *webview;
@property (nonatomic,strong) UINavigationItem * navigationBarTitle;
@property(nonatomic, strong) WebViewJS *WebviewJs;
@property(nonatomic, strong) NSString *procode;
@property(nonatomic, strong)UIImageView *navBarHairlineImageView;

@end

@implementation DTCustomeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
//    backbtn.delegate=self;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    //[ZZLProgressHUD showHUDWithMessage:@"正在加载"];
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, kScreen_Width, kScreen_Height)];
    _webview=webview;
    webview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    webview.scalesPageToFit = YES;
    webview.backgroundColor = [UIColor whiteColor];
    NSURL *url=[NSURL URLWithString:self.webUrl];
    [webview loadRequest:[NSURLRequest requestWithURL:url]];
    webview.allowsInlineMediaPlayback = YES;
    webview.mediaPlaybackRequiresUserAction = NO;
    webview.delegate=self;
    self.WebviewJs = [[WebViewJS alloc] init];
    self.WebviewJs.delegate = self;
    [self.view addSubview:webview];

}
-(void)setIntentDic:(NSDictionary *)intentDic{
    self.webUrl=intentDic[@"weburl"];
    self.procode=intentDic[@"procode"];
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
 
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"obj"]=self.WebviewJs;
}
//-(void)goback{
//    if ([self.webview canGoBack]) {
//        if([self.title isEqualToString:@"芝麻信用"]){
//            [self dismissViewControllerAnimated:NO completion:nil];
//            [self.delegate twoback];
////           [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
//        }else{
//            [self.webview goBack];
//        }
//    }else{
//        [self dismissViewControllerAnimated:NO completion:nil];
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)userCenterJS{
    [self.delegate homeRefresh];
    [self dismissViewControllerAnimated:NO completion:nil];
    [JRToast showWithText:@"提交个人资料成功" duration:1.0];
}
-(void)photoJS{
    NSLog(@"paizhao");
    XDAlertController *alert = [XDAlertController alertControllerWithTitle:@"修改头像" message:nil preferredStyle:XDAlertControllerStyleActionSheet];
    XDAlertAction *action1 = [XDAlertAction actionWithTitle:@"从相册获取" style: XDAlertActionStyleDefault handler:^( XDAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    XDAlertAction *action2 = [XDAlertAction actionWithTitle:@"拍照" style: XDAlertActionStyleDefault handler:^( XDAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    XDAlertAction *action3 = [XDAlertAction actionWithTitle:@"取消" style:XDAlertActionStyleCancel handler:^(XDAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)saveImage:(UIImage *)image {
    // 对于base64编码编码
    NSString *headImageString=[self UIImageToBase64Str:image];
    JSContext *context=[self.webview valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext" ];
    context.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        con.exception = exception;
    };
    NSString *alertJS=[NSString stringWithFormat:@"getPhoto('%@')",headImageString];
    [context evaluateScript:alertJS];
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode,@"proImg":headImageString};
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLUpdateProImg] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
           
        }else{
            [_svc showMessage:dic[@"msgs"]];
            
        }
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];
        
        
    }];

    
}
-(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 0.1f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodedImageStr;
}
@end
