//
//  ZJCircleProgressView.m
//  ZJCircleProgressView
//
//  Created by ZeroJ on 16/10/16.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJCircleProgressView.h"

static CGFloat radiusFromAngle(CGFloat angle) {
    return (angle * M_PI)/180;
}

@interface ZJCircleProgressView ()

@property (strong, nonatomic) UILabel *progressLabel;
@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UILabel *detailLbl;


@end

@implementation ZJCircleProgressView


- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}
- (void)commonInit {
    _trackBackgroundColor = [UIColor clearColor];
    _trackColor = [AppAppearance sharedAppearance].mainColor;
    _lineWidth = 10;
    _lineCap = kCGLineCapRound;
    _beginAngle = radiusFromAngle(-90);
//    self.clipsToBounds = NO;
//    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.progressLabel];
    
    [self.progressLabel addSubview:self.detailLbl];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat slideLength = self.bounds.size.width;
    // 大概设置为内部小圆的外接正方形 -- 准确的位置实际应该先计算出label的高度来设置的
    // 不过不用精确设置也能正确显示
    self.progressLabel.frame = CGRectMake(_lineWidth, _lineWidth, slideLength-2*_lineWidth, slideLength-2*_lineWidth);
    
//    CGFloat centerX = self.progressLabel.center.x;
    
    CGFloat centerY = self.progressLabel.center.y;
    
    self.detailLbl.frame = CGRectMake(0, centerY+20, self.progressLabel.frame.size.width, 21);
    
    
    if (self.headerImage) {
        CGFloat angle = _progress*2*M_PI + _beginAngle;
        CGFloat centerX = slideLength/2;
        CGFloat centerY = slideLength/2;
        CGFloat r = (self.bounds.size.width-_lineWidth)/2;
        CGFloat imageCenterX = centerX + r*cos(angle);
        CGFloat imageCenterY = centerY + r*sin(angle);
        // 这里 + 8 作为imageView比轨道宽8的效果
        self.imageView.frame = CGRectMake(0, 0, _lineWidth+8, _lineWidth+8);
        self.imageView.center = CGPointMake(imageCenterX, imageCenterY);
    }
}


-(void)updatePointer:(NSInteger)percent withAnimationTime:(CGFloat)animationTime{
    CGFloat angle = percent/100.0 * (M_PI*2);
    
    //旋转动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = animationTime;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = NO;
    animation.fromValue = [NSNumber numberWithFloat:self.startAngle];
    animation.toValue = [NSNumber numberWithFloat:angle];
    animation.delegate = self;
    [animation setValue:[NSNumber numberWithFloat:angle] forKey:@"angle"];
    [self.imageView.layer addAnimation:animation forKey:@"rotationAnimation"];
    
    
    
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // 获取当前上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGFloat slideLength = self.bounds.size.width;
    CGFloat centerX = slideLength/2;
    CGFloat centerY = slideLength/2;
    // 添加背景轨道
    CGContextAddArc(currentContext, centerX, centerY, (slideLength-_lineWidth)/2, 0, 2*M_PI, 0);
    // 设置轨道宽度
    CGContextSetLineWidth(currentContext, self.lineWidth);
    // 设置背景颜色
    [self.trackBackgroundColor setStroke];
    // 绘制轨道
    CGContextStrokePath(currentContext);
    
    // 进度条轨道
    CGFloat deltaAngle = _progress*2*M_PI;
    // 根据进度progress的值绘制进度条
    // 注意: 角度需要使用弧度制
    // 设置圆心x, y坐标
    // 设置圆的半径 -- 这里需要的自然是(边长-轨道宽度)/2
    // 从beginAngle 绘制到endAngle= beginAngle+deltaAngle;
    CGContextAddArc(currentContext, centerX, centerY, (slideLength-_lineWidth)/2, self.beginAngle, self.beginAngle+deltaAngle, self.clickWise);
    // 设置进度条颜色
    [self.trackColor setStroke];
    // 设置轨道宽度
    CGContextSetLineWidth(currentContext, _lineWidth);
    // 设置轨道端点的样式
    CGContextSetLineCap(currentContext, _lineCap);
    // 使用stroke方式填充路径
    CGContextStrokePath(currentContext);
    
//    CGFloat r = (self.bounds.size.width-_lineWidth)/2;
//    CGFloat imageCenterX = centerX + r*cos(deltaAngle+_beginAngle);
//    CGFloat imageCenterY = centerY + r*sin(deltaAngle+_beginAngle);
//    CGFloat imageWidth = _lineWidth+8;
//    CGRect imageRect = CGRectMake(0, 0, imageWidth, imageWidth);
//    imageRect.origin.x = imageCenterX - imageWidth/2;
//    imageRect.origin.y = imageCenterY - imageWidth/2;
//
//    CGContextDrawImage(currentContext, imageRect, [self.imageView.image CGImage]);
    
}


- (void)setProgress:(CGFloat)progress {
    
    [self updatePointer:100 withAnimationTime:60];
    
    if (progress > 1 || progress < 0) return;
    _progress = progress/0.6;
    
    
   
 
    
    NSString *str = [NSString stringWithFormat:@"%.2f", progress];
    
    self.progressLabel.text = [str substringFromIndex:2];
        
    

    self.progressLabel.font = [UIFont fontWithName:@"AkzidenzGroteskBQ-XBdCnd" size:50];

    // 标记为需要重新绘制, 将会在下一个绘制循环中, 调用drawRect:方法重新绘制
    [self setNeedsDisplay];
    if (self.headerImage) { //  需要显示图片就触发重新布局
        [self setNeedsLayout];
    }
}
// 重写headerImage  set方法, 如果设置了图片就添加imageVIew
- (void)setHeaderImage:(UIImage *)headerImage {
    _headerImage = headerImage;
    if (self.headerImage) {
        [self addSubview:self.imageView];
        self.imageView.image = self.headerImage;
    }
}


- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.layer.masksToBounds = YES;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 9;
        imageView.layer.borderWidth = 1;
        imageView.layer.borderColor = [[AppAppearance sharedAppearance].mainColor CGColor];
        imageView.backgroundColor = [UIColor whiteColor];
        
        _imageView = imageView;
    }
    return _imageView;
}
- (UILabel *)progressLabel {
    if (!_progressLabel) {
        UILabel *progressLabel = [[UILabel alloc] init];
        progressLabel.textColor = [AppAppearance sharedAppearance].mainColor;
//        progressLabel.font = [UIFont boldSystemFontOfSize:18];
        progressLabel.backgroundColor = [UIColor clearColor];
        progressLabel.textAlignment = NSTextAlignmentCenter;
        progressLabel.text = @"0.0%";
        _progressLabel = progressLabel;
    }
    return _progressLabel;
}


-(UILabel *)detailLbl
{
    if (!_detailLbl) {
        UILabel *detaillbl = [[UILabel alloc] init];
        detaillbl.textColor = [AppAppearance sharedAppearance].title3TextColor;
        detaillbl.font = [MyAdapter fontADapter:14];
        detaillbl.backgroundColor = [UIColor clearColor];
        detaillbl.textAlignment = NSTextAlignmentCenter;
        detaillbl.text = @"响应时间";
        _detailLbl = detaillbl;
        
        
    }
    return _detailLbl;
}


@end
