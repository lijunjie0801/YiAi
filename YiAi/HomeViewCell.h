//
//  HomeViewCell.h
//  YiAi
//
//  Created by zlkj on 2017/6/7.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeModel;
@interface HomeViewCell : UITableViewCell


@property(nonatomic, strong) HomeModel *model;

+(instancetype)homeViewCellWithTableView:(UITableView *)tableView;

@end
