//
//  PollingViewCell.h
//  YiAi
//
//  Created by lijunjie on 2017/7/19.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PollingViewCell : UITableViewCell

//@property(nonatomic, strong) UIButton *typeBtn;
@property(nonatomic, strong) UILabel *titleLbl;
@property(nonatomic, strong) UIImageView *headImg;
@property(nonatomic, strong) NSArray *imgArray;
+(instancetype)pollingViewCellWithTableView:(UITableView *)tableView;
@end
