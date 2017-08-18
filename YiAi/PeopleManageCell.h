//
//  PeopleManageCell.h
//  YiAi
//
//  Created by zlkj on 2017/6/14.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PeopleDelegate <NSObject>
-(void)Call:(NSString *)section:(NSString *)row;
@end
@interface PeopleManageCell : UITableViewCell

+(instancetype)peopleManageCellWithTableView:(UITableView *)tableView;
-(void)updateWithDic:(NSDictionary *)dic;
@property(nonatomic, weak) id<PeopleDelegate> delegate;
@property(nonatomic,strong)NSString *indexSection;
@property(nonatomic,strong)NSString *indexRow;
@end
