//
//  HCScanQRViewController.m
//  HCSystemicQRCodeDemo
//
//  Created by Caoyq on 16/5/4.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import "HCScanQRViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HCHeader.h"

@interface HCScanQRViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    NSString *QRCode;
}

#pragma mark - ---属性---
/**
 *输入输出中间桥梁(会话)
 */
@property (strong, nonatomic) AVCaptureSession *session;

/**
 *计时器
 */
@property (strong, nonatomic) CADisplayLink *link;

/**
 *实际有效扫描区域的背景图(亦或者自己设置一个边框)
 */
@property (strong, nonatomic) UIImageView *bgImg;

/**
 *有效扫描区域循环往返的一条线（这里用的是一个背景图）
 */
@property (strong, nonatomic) UIImageView *scrollLine;

/**
 *扫码有效区域外自加的文字提示
 */
@property (strong, nonatomic) UILabel *tip;

/**
 *用于控制照明灯的开启
 */
@property (strong, nonatomic) UIButton *lamp;

/**
 *用于记录scrollLine的上下循环状态
 */
@property (assign, nonatomic) BOOL up;

@property(nonatomic, strong) NSMutableArray *proNameArray;

@property(nonatomic, strong) NSDictionary *dictionarray;

#pragma mark -------

@end

@implementation HCScanQRViewController

#pragma mark - ---Life Cycle---
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getprocode];
    self.view.backgroundColor = [UIColor whiteColor];
    //[self setNavigationItem];
    
    self.title = @"二维码";
    _up = YES;
    
    [self session];
    
    //1.添加一个可见的扫描有效区域的框（这里直接是设置一个背景图片）
    [self.view addSubview:self.bgImg];
    
    //2.添加一个上下循环运动的线条（这里直接是添加一个背景图片来运动）
    [self.view addSubview:self.scrollLine];
    
    //3.添加其他有效控件
    [self.view addSubview:self.tip];
    [self.view addSubview:self.lamp];
}
-(void)getprocode{
    NSString *appKey=[AppDataManager defaultManager].identifier;
    NSDictionary *param = @{@"appKey":appKey};
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLGetProCode] withParamer:param completionHandler:^(id responseObject) {
        NSLog(@"procode：%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            NSArray *array=responseObject[@"datas"][@"Procodes"][@"projectList"];
            NSMutableArray *muarray=[NSMutableArray array];
            NSMutableDictionary *diction=[NSMutableDictionary dictionary];
            for (NSDictionary *dic in array) {
                [muarray addObject:dic[@"proCodeName"]];
                [diction setObject:dic[@"proCode"] forKey:dic[@"proCodeName"]];
            }
            self.proNameArray=[muarray mutableCopy];
            self.dictionarray =diction;
        }
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        NSLog(@"procode：%@",error);
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.session startRunning];
    //计时器添加到循环中去
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.session stopRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - ---lazy load---
- (UIImageView *)bgImg {
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(kBgImgX, kBgImgY, kBgImgWidth, kBgImgWidth)];
        _bgImg.image = [UIImage imageNamed:bgImg_img];
    }
    return _bgImg;
}

- (UIImageView *)scrollLine {
    if (!_scrollLine) {
        _scrollLine = [[UIImageView alloc]initWithFrame:CGRectMake(kBgImgX, kBgImgY, kBgImgWidth, kScrollLineHeight)];
        _scrollLine.image = [UIImage imageNamed:Line_img];
    }
    return _scrollLine;
}

- (UILabel *)tip {
    if (!_tip) {
        _tip = [[UILabel alloc]initWithFrame:CGRectMake(kBgImgX, CGRectGetMaxY(_bgImg.frame)+20, kBgImgWidth, kTipHeight)];
        _tip.text = @"自动扫描框内二维码";
        _tip.numberOfLines = 0;
        _tip.textColor = [UIColor whiteColor];
        _tip.textAlignment = NSTextAlignmentCenter;
        _tip.font = [UIFont FontWithSize:14];
    }
    return _tip;
}

- (CADisplayLink *)link {
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(LineAnimation)];
    }
    return _link;
}

- (UIButton *)lamp {
    if (!_lamp) {
        _lamp = [[UIButton alloc]initWithFrame:CGRectMake(kLampX, CGRectGetMaxY(_tip.frame)+10, kLampWidth, kLampWidth)];
        _lamp.alpha = kBgAlpha;
        _lamp.selected = NO;
        [_lamp.layer setMasksToBounds:YES];
        [_lamp.layer setCornerRadius:kLampWidth/2];
        [_lamp.layer setBorderWidth:2.0];
        [_lamp.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        _lamp.backgroundColor = [UIColor whiteColor];
        [_lamp setImage:[UIImage imageNamed:turn_off] forState:UIControlStateNormal];
        [_lamp addTarget:self action:@selector(touchLamp:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lamp;
}

- (AVCaptureSession *)session {
    if (!_session) {
        //1.获取输入设备（摄像头）
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        //2.根据输入设备创建输入对象
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
        if (input == nil) {
            return nil;
        }
        
        //3.创建元数据的输出对象
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
        //4.设置代理监听输出对象输出的数据,在主线程中刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // 5.创建会话(桥梁)
        AVCaptureSession *session = [[AVCaptureSession alloc]init];
        //实现高质量的输出和摄像，默认值为AVCaptureSessionPresetHigh，可以不写
        [session setSessionPreset:AVCaptureSessionPresetHigh];
        // 6.添加输入和输出到会话中（判断session是否已满）
        if ([session canAddInput:input]) {
            [session addInput:input];
        }
        if ([session canAddOutput:output]) {
            [session addOutput:output];
        }
        
        // 7.告诉输出对象, 需要输出什么样的数据 (二维码还是条形码等) 要先创建会话才能设置
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode];
        
        // 8.创建预览图层
        AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
        [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        previewLayer.frame = self.view.bounds;
        [self.view.layer insertSublayer:previewLayer atIndex:0];
        
        //9.设置有效扫描区域，默认整个图层(很特别，1、要除以屏幕宽高比例，2、其中x和y、width和height分别互换位置)
        CGRect rect = CGRectMake(kBgImgY/ScreenHeight, kBgImgX/ScreenWidth, kBgImgWidth/ScreenHeight, kBgImgWidth/ScreenWidth);
        output.rectOfInterest = rect;
        
        //10.设置中空区域，即有效扫描区域(中间扫描区域透明度比周边要低的效果)
        UIView *maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:kBgAlpha];
        [self.view addSubview:maskView];
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
        [rectPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(kBgImgX, kBgImgY, kBgImgWidth, kBgImgWidth) cornerRadius:1] bezierPathByReversingPath]];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = rectPath.CGPath;
        maskView.layer.mask = shapeLayer;
        
        _session = session;
    }
    return _session;
}




#pragma mark - 线条运动的动画
- (void)LineAnimation {
    if (_up == YES) {
        CGFloat y = self.scrollLine.frame.origin.y;
        y += 2;
        [self.scrollLine setY:y];
        if (y >= (kBgImgY+kBgImgWidth-kScrollLineHeight)) {
            _up = NO;
        }
    }else{
        CGFloat y = self.scrollLine.frame.origin.y;
        y -= 2;
        [self.scrollLine setY:y];
        if (y <= kBgImgY) {
            _up = YES;
        }
    }
}


#pragma mark - 开灯或关灯
- (void)touchLamp:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.selected == YES) {
        [btn setImage:[UIImage imageNamed:turn_off] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
    }else{
        [btn setImage:[UIImage imageNamed:turn_on] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
    }
    btn.selected = !btn.selected;
    [SystemFunctions openLight:btn.selected];
}







#pragma mark - AVCaptureMetadataOutputObjectsDelegate
// 扫描到数据时会调用
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        [SystemFunctions openShake:YES Sound:YES];
        // 1.停止扫描
               [self.session stopRunning];
        // 2.停止冲击波
                [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        // 3.取出扫描到得数据
        AVMetadataMachineReadableCodeObject *obj = [metadataObjects lastObject];
        if (obj) {
            NSString *str = [obj stringValue];
            if([str rangeOfString:@"id="].location !=NSNotFound)//_roaldSearchText
            {
                NSLog(@"yes");
            }
            else
            {
                [_svc pushViewController:_svc.addNFCequipmentViewController withObjects:@{@"param":str,@"pronames":self.proNameArray,@"dic":self.dictionarray}];
                return;
            }

            NSRange range = [str rangeOfString:@"id="]; //现获取要截取的字符串位置
            
            
            NSString * result = [str substringFromIndex:range.location+3]; //截取字符串
            NSString *address = [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
            address = [address stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            address = [address stringByReplacingOccurrencesOfString:@"\n" withString:@""];

            
            NSDictionary *param = @{@"appKey":[AppDataManager defaultManager].identifier,@"proCode":@"",@"nfcCode":address};
            [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLNFCInfo] withParamer:param completionHandler:^(id responseObject) {
                NSLog(@"NFC数据：%@",responseObject);
                if ([responseObject[@"status"] integerValue]==100) {
                    [_svc pushViewController:_svc.lookNFCequipmentViewController withObjects:@{@"address":address}];
                }else{
                    [_svc pushViewController:_svc.addNFCequipmentViewController withObjects:@{@"param":address,@"pronames":self.proNameArray,@"dic":self.dictionarray}];

                }    
            } failureHandler:^(NSError *error, NSUInteger statusCode) {
                NSLog(@"NFC错误：%@",error);
            }];

            

            

            
        }
    }
}

-(BOOL)shouldHideNavigationBar
{
    return NO;
}




@end
