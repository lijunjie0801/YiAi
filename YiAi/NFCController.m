//
//  NFCController.m
//  YiAi
//
//  Created by lijunjie on 2017/7/29.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "NFCController.h"
#import "CustomeView.h"
@interface NFCController ()
@property(nonatomic,strong)NSString *procode;
@end

@implementation NFCController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"NFC";
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUI];
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    self.procode=intentDic[@"procode"];
}
-(void)setUI{
    NSArray *titles=@[@"设备列表",@"设备数目分布图",@"设备位置分布图"];
    NSArray *icons=@[@"xlist01",@"xlist02",@"xlist02"];
    for (int i=0; i<3; i++) {
        CustomeView *cusView=[[CustomeView alloc]initWithFrame:CGRectMake(0,i*55, kScreen_Width, 55)];
        cusView.tag=i;
        cusView.imageview.image=[UIImage imageNamed:icons[i]];
        cusView.imageview.contentMode = UIViewContentModeScaleAspectFill;
        cusView.label.text=titles[i];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        singleTap.numberOfTapsRequired = 1;
        [cusView addGestureRecognizer:singleTap];

        [self.view addSubview:cusView];
    }
}
-(void)singleTap:(id)sender{
    NSLog(@"2333");
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    NSLog(@"%ld",[singleTap view].tag);
    NSInteger index=[singleTap view].tag;
    if (index==0) {
         [_svc pushViewController:_svc.NFCDeviceTypeListController withObjects:@{@"procode":self.procode}];
    }else if (index==1){
        [_svc pushViewController:_svc.networkUnitViewController withObjects:@{@"procode":self.procode}];

    }else if (index==2){
        [_svc pushViewController:_svc.AddressDistrController withObjects:@{@"procode":self.procode}];
        
    }
   
}


@end
