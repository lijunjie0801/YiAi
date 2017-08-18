//
//  VoltageViewController.m
//  YiAi
//
//  Created by zlkj on 2017/7/11.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "VoltageViewController.h"
#import "VoltageView.h"

@interface VoltageViewController ()

@property (strong, nonatomic) VoltageView *progressView;

@property (nonatomic, strong) UIImageView *backgroundImg;

@property (nonatomic, strong) UIImageView *pointImg;




@end

@implementation VoltageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"电压";
    
    
    self.progressView = [[VoltageView alloc] initWithFrame:CGRectMake((WIDTH-[MyAdapter aDapter:200])/2, 150, [MyAdapter aDapter:200], [MyAdapter aDapter:200])];
    self.progressView.startAngle = [MyAdapter aDapter:200]/2;
    // 背景色
    self.progressView.trackBackgroundColor = [[AppAppearance sharedAppearance].mainColor colorWithAlphaComponent:0.3];
    // 进度颜色
    self.progressView.trackColor = [AppAppearance sharedAppearance].mainColor;
    self.progressView.headerImage = [self drawImage];
    // 开始角度位置
    //    self.progressView.beginAngle =
    // 自定义progressLabel的属性...
    self.progressView.progressLabel.textColor = [UIColor blueColor];
    //    self.progressView.progressLabel.hidden = YES;
    [self.view addSubview:self.progressView];
    
    
    self.backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH - [MyAdapter aDapter:150])/2, 180+10, [MyAdapter aDapter:150], [MyAdapter aDapter:150*248/498])];
    self.backgroundImg.image = [UIImage  imageNamed:@"point"];
    [self.view addSubview:self.backgroundImg];
    
    
    self.pointImg = [[UIImageView alloc] initWithFrame:CGRectMake(([MyAdapter aDapter:150]-[MyAdapter aDapter:64])/2, [MyAdapter aDapter:150*101/166]-[MyAdapter aDapter:32]-18, [MyAdapter aDapter:64], [MyAdapter aDapter:32])];
    self.pointImg.image = [UIImage imageNamed:@"椭圆-1"];
    [self.backgroundImg bringSubviewToFront:self.pointImg];
    [self.backgroundImg addSubview:self.pointImg];
    
    
    self.pointImg.layer.anchorPoint = CGPointMake(0.73,0.4);
    
    
    
    self.progressView.progress = 3/0.003/1000*0.03*0.75;
    CGFloat progress = self.progressView.progress*100;
    NSLog(@"progress===%f",self.progressView.progress);
    self.pointImg.transform = CGAffineTransformMakeRotation(progress*M_PI/100);
//    __block float timeout = 0;  //倒计时间
//    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatchQueue);
//    dispatch_source_set_timer(_time, dispatch_walltime(NULL, 0),0.001 * NSEC_PER_SEC, 0);
//    dispatch_source_set_event_handler(_time, ^{
//        
//        
//        if (timeout >3) {
//            
//            
//            dispatch_source_cancel(_time);
//            
//            
//            
//            
//        }else {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                   NSLog(@"时间===%f",timeout);
//                
//                self.progressView.progress = timeout/0.003/1000*0.03;
//                
//                NSLog(@"进度=====%f",self.progressView.progress);
//                
//            });
//            
//            timeout +=0.001;
//            //             NSLog(@"时间===%f",timeout);
//        }
//        
//        
//        
//    });
//    dispatch_resume(_time);
    
    
//    __weak VoltageViewController *ws =  self;
//    
//    [self.progressView setSelectProgressChange:^(NSString *progressStr) {
//        
//        
//        CGFloat progress = [progressStr floatValue];
//        NSLog(@"progress===%f",progress);
//        [UIView animateWithDuration:0.01 animations:^{
//            
//            ws.pointImg.transform = CGAffineTransformMakeRotation(progress*M_PI/100);
//            
//        }];
//        
//        
//        
//    }];
    
    
    
    
    
    
    
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
