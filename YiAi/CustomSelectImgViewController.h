//
//  CustomSelectImgViewController.h
//  YiAi
//
//  Created by zlkj on 2017/6/23.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseViewController.h"

@class XWDragCellCollectionView;

@protocol CustomSelectImgViewControllerDelegate <NSObject>

-(void)refreshCustomFrame:(CGSize) custmSize;

-(void)selectPhpto;

@end

@interface CustomSelectImgViewController : BaseViewController

@property (strong,nonatomic)UIScrollView *svMain;           //背景滚动式图
@property (strong,nonatomic)UIView *viewBg;                 //上面的文本背景
@property (strong,nonatomic)UIView *viewlin;                 //上面的线
@property (strong,nonatomic)NSMutableArray *phonelist;      //图片数组
@property (strong,nonatomic)UIButton *btnAddPhone;          //添加照片按钮

@property (strong,nonatomic)  XWDragCellCollectionView *collectionView;

-(void)resetLayout;

@property(nonatomic,weak) id<CustomSelectImgViewControllerDelegate> delegate;

@end
