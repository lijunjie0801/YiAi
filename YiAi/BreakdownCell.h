//
//  BreakdownCell.h
//  YiAi
//
//  Created by zlkj on 2017/6/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FireModel;

@class WaterModel;

@class BreakModel;

@class XFModel;
@interface BreakdownCell : UITableViewCell


@property(nonatomic, strong) FireModel *fireModel;

@property(nonatomic, strong) WaterModel *waterModel;

@property(nonatomic, strong) BreakModel *breakModel;

@property(nonatomic, strong) XFModel *xfModel;

+(instancetype)breakDownCellWithTableView:(UITableView *)tableView;

@end
