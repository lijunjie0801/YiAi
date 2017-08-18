//
//  DeviceCell.h
//  YiAi
//
//  Created by lijunjie on 2017/7/27.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceModel.h"
#import "VoltageView.h"
@interface DeviceCell : UITableViewCell
@property(nonatomic, strong) UILabel *addressLbl,*remarkLbl,*numLbl,*qujianLbl,*lb1,*lb2,*lb3,*lb4,*lb5;
@property(nonatomic, strong) DeviceModel *model;
@property (strong, nonatomic) VoltageView *progressView;
@property (nonatomic, strong) UIImageView *backgroundImg;
@property (nonatomic, strong) UIImageView *pointImg;
+(instancetype)taskBooksCellWithTableView:(UITableView *)tableView;
@end
