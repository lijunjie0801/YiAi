//
//  CheckJobViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/13.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "CheckJobViewController.h"
#import "ZJCircleProgressView.h"

@interface CheckJobViewController (){
    int count;
}


@property(nonatomic, strong) UIView *headerView,*footerView;
@property(nonatomic, strong)NSString *procode,*hostId,*updateVariety;
@property (strong, nonatomic) ZJCircleProgressView *progressView;
@property (strong, nonatomic)dispatch_source_t _time;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong)UILabel *lb1,*lb2;
@end

@implementation CheckJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查岗";
    count=0;
    [self action1];
    //[self createSubViews];
    
}

-(void)setIntentDic:(NSDictionary *)intentDic{
    self.procode=intentDic[@"procode"];
    self.hostId=intentDic[@"hostId"];
}
-(void)action1{
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode,@"hostId":self.hostId};
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLSerLGStatus] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
            NSString *updateVariety=dic[@"datas"][@"LGStatus"][@"LGStatus"][@"updateVariety"];
            _updateVariety=updateVariety;
            [self action2];
        }else{
            [_svc showMessage:dic[@"msgs"]];
        }
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];

        
    }];

}
-(void)action2{
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode,@"hostId":self.hostId};
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLFingGuard] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
            [self createSubViews];
        }else{
            [_svc showMessage:dic[@"msgs"]];
        }
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];
        
        
    }];
    
}
-(void)action3{
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode,@"hostId":self.hostId};
    
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLSerLGStatus] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
            NSString *updateVariety=dic[@"datas"][@"LGStatus"][@"LGStatus"][@"updateVariety"];
            if ([updateVariety isEqualToString:_updateVariety]) {
                NSLog(@"一样");
            }else{
                 NSLog(@"不一样");
                [self action4:updateVariety];
            }
        }else{
            [_svc showMessage:dic[@"msgs"]];
            
        }
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];
        
        
    }];
    
}


-(void)action4:(NSString *)guardResult{
    NSDictionary *param =@{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":self.procode,@"hostId":self.hostId,@"guardTYype":@"0",@"guardResult":guardResult};
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLGuardHistory] withParamer:param completionHandler:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"status"] integerValue] ==100) {
            dispatch_source_cancel(__time);
            [_timer invalidate];
            _lb2.text=@"";
        }else{
            [_svc showMessage:dic[@"msgs"]];
        }
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        [_svc showMessage:error.domain];
        
        
    }];
    
}

-(void)createSubViews
{
    //添加头部视图
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, [MyAdapter aDapter:250]+40)];
    [self.view addSubview:self.headerView];
    
    
    UIImageView *contImg = [[UIImageView alloc] init];
    [self.headerView addSubview:contImg];
    contImg.image = [UIImage imageNamed:@"progress_bg"];

    CGFloat contimgW = contImg.image.size.width;
    CGFloat contimgH = contImg.image.size.height;
    
    
    
    contImg.frame = CGRectMake((WIDTH - contimgW)/2, (self.headerView.frame.size.height - contimgH)/2, contimgW, contimgH);
    
    
    CGFloat imgW = contimgW-30;
    CGFloat imgH = contimgH-30;
    
    self.progressView = [[ZJCircleProgressView alloc] initWithFrame:CGRectMake(15, 15, imgW, imgH)];
//    self.progressView.center = contImg.center;
    
    
    
    self.progressView.startAngle = imgW/2;
    // 背景色
//    self.progressView.trackBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"progress_bg"]];
    // 进度颜色
    self.progressView.trackColor = [AppAppearance sharedAppearance].mainColor;
    self.progressView.headerImage = [self drawImage];
    // 开始角度位置
    //    self.progressView.beginAngle =
    // 自定义progressLabel的属性...
    self.progressView.progressLabel.textColor = [AppAppearance sharedAppearance].mainColor;
    //    self.progressView.progressLabel.hidden = YES;
    [contImg addSubview:self.progressView];
    
    self.progressView.progress = 0.0;
    
    
    
    __block float timeout = 0;  //倒计时间
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatchQueue);
    __time=_time;
    dispatch_source_set_timer(_time, dispatch_walltime(NULL, 0),0.001 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_time, ^{
        
        
        if (timeout >60) {

            dispatch_source_cancel(_time);
            [_timer invalidate];
            [self action4:@"2"];
            _lb1.text=@"查岗异常";
            
            
        }else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.progressView.progress = timeout/0.06/1000*0.6;
               // NSLog(@"%f",self.progressView.progress);
            });
            
            timeout +=0.001;

        }
    });
    dispatch_resume(_time);
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3
                                                  target:self
                                                selector:@selector(printString)
                                                userInfo:nil
                                                 repeats:true];
    
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), WIDTH, HEIGHT -64-[MyAdapter aDapter:250]-40)];
    [self.view addSubview:self.footerView];
    [self setotherview];
}
-(void)setotherview{
    UILabel *lb1=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreen_Width, 50)];
    _lb1=lb1;
    lb1.text=@"正在查岗";
    lb1.font=[UIFont boldSystemFontOfSize:30];
    lb1.textAlignment=NSTextAlignmentCenter;
    lb1.textColor=[UIColor colorWithHexString:@"0xff8035"];
    [self.footerView addSubview:lb1];
    
    UILabel *lb2=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, kScreen_Width, 20)];
    _lb2=lb2;
    lb2.text=@"控制器响应成功";
    lb2.textAlignment=NSTextAlignmentCenter;
    [self.footerView addSubview:lb2];
}

int num = 0;

- (void)printString{
    [self action3];
    NSLog(@"%d",num++);
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [self.timer setFireDate:[NSDate distantFuture]];  //很远的将来
}
- (UIImage *)drawImage {
    UIGraphicsBeginImageContext(CGSizeMake(20, 20));
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextAddArc(currentContext, 10, 10, 10, 0, 2*M_PI, 0);
    [[UIColor whiteColor] set];
    CGContextFillPath(currentContext);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
