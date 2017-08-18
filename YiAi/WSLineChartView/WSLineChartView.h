//
//  WSLineChartView.h
//  WSLineChart
//
//  Created by iMac on 16/11/17.
//  Copyright © 2016年 zws. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WSLineDelegate <NSObject>
-(void)GetMore;
@end
@interface WSLineChartView : UIView

@property(nonatomic, weak) id<WSLineDelegate> delegate;
- (id)initWithFrame:(CGRect)frame xTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray yMax:(CGFloat)yMax yMin:(CGFloat)yMin limitup:(CGFloat)limitup limitdown:(CGFloat)limitdown;


@end
