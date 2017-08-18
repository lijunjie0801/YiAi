//
//  ServiceDetailViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/15.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "ServiceDetailViewController.h"

@interface ServiceDetailViewController ()

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIView *topView,*footerView;

@property(nonatomic, strong) UITextField *nameFile,*locationFile;

@property(nonatomic, strong) UITextView *textView;


@end

@implementation ServiceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"维修详情";
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    
    _tableView.tableHeaderView = [self headerViews];
    
    
  
    
 
}



-(UIView *)headerViews
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, self.tableView.frame.size.width)];
    headerView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    
    
    
    //头部视图
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH,(10+[MyAdapter aDapter:40]+10)*2)];
    self.topView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    [headerView addSubview:self.topView];
    
    UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10+[MyAdapter aDapter:19]/2, [MyAdapter aDapter:80], [MyAdapter aDapter:21])];
    nameLbl.text = @"工程名称";
    nameLbl.textColor = [AppAppearance sharedAppearance].title3TextColor;
    nameLbl.font = [MyAdapter fontADapter:16];
    [self.topView addSubview:nameLbl];
    
    
    
    
    
    
    
    
    _nameFile = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLbl.frame)+10, 10+[MyAdapter aDapter:19]/2, WIDTH - CGRectGetMaxX(nameLbl.frame)-10-10, [MyAdapter aDapter:21])];
    _nameFile.textAlignment = NSTextAlignmentRight;
    _nameFile.font =[MyAdapter fontADapter:16];
    //    _nameFile.placeholder = @"请选择设备类型";
    _nameFile.text = @"华东大区工程";
    _nameFile.enabled = NO;
    [self.topView addSubview:_nameFile];
    
    
    
    
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLbl.frame)+10, WIDTH, 1)];
    linView.backgroundColor =[AppAppearance sharedAppearance].cellLineColor;
    [self.topView addSubview:linView];
    
    
    
    UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(linView.frame)+10+[MyAdapter aDapter:19]/2, [MyAdapter aDapter:80], [MyAdapter aDapter:21])];
    locationLbl.text = @"位置信息";
    locationLbl.textColor = [AppAppearance sharedAppearance].title3TextColor;
    locationLbl.font = [MyAdapter fontADapter:16];
    [self.topView addSubview:locationLbl];
    
    _locationFile = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(locationLbl.frame)+10, CGRectGetMaxY(linView.frame)+10+[MyAdapter aDapter:19]/2, WIDTH - CGRectGetMaxX(locationLbl.frame)-10-10, [MyAdapter aDapter:21])];
    _locationFile.textAlignment = NSTextAlignmentRight;
    _locationFile.font =[MyAdapter fontADapter:16];
    _locationFile.enabled = NO;
    _locationFile.text = @"总经理办公室";
    
    [self.topView addSubview:_locationFile];
    
    UIView *topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topView.frame.size.height-10, WIDTH, 10)];
    topBackView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    [self.topView addSubview:topBackView];
    
    
    
    
    //尾部视图
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), WIDTH, self.tableView.frame.size.height -  CGRectGetMaxY(self.topView.frame))];
    self.footerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.footerView];
    
    
    self.textView = [[UITextView alloc] init];
    self.textView.font = [MyAdapter fontADapter:14];
    self.textView.userInteractionEnabled = NO;
    self.textView.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [self.footerView addSubview:self.textView];
    
    
    
    
    //    textview 改变字体的行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[MyAdapter fontADapter:14],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
     NSString *str= @"打快感地方扣了感觉到放空管抵抗力房管局的时刻放假干京东方科技馆看电视放假干地方扣了过近段时间基地发给跨境电商盖浇饭大发牢骚金刚骷髅岛富商巨贾。";
    
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:str attributes:attributes];
    
    

   
    
   
    //计算文字的高度
    CGFloat textH = [self.textView.text boundingRectWithSize:CGSizeMake(WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[MyAdapter fontADapter:14]} context:nil].size.height+10;
    

    //计算共有多少行，并计算行数的高度
    int addtextH = textH/21*10;
    
    
    self.textView.frame = CGRectMake(10, 10, WIDTH - 20, textH+addtextH);
    
    
    
//    UIView *ImgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.textView.frame)+10, WIDTH, 80)];
//    ImgView.backgroundColor = [UIColor whiteColor];
//    [self.footerView addSubview:ImgView];
//    
    
    
    int totalCol = 4;
 
    NSArray *iconArray= @[@"yiershucheng",@"yiershucheng",@"yiershucheng",@"yiershucheng",@"yiershucheng",@"yiershucheng",@"yiershucheng",@"yiershucheng"];
    
    
    
    CGFloat viewW=(WIDTH - 50)/totalCol;
    
    
    UIButton *lastBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
    
    for (int i=0; i<iconArray.count; i++) {
        
        
        CGFloat x=(WIDTH/totalCol)*(i%totalCol);
        CGFloat y=viewW*(i/totalCol)+(i/totalCol)*20+CGRectGetMaxY(self.textView.frame)+10;
        
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x+(WIDTH/totalCol-viewW)/2, y, viewW, viewW)];
       
        [button setBackgroundImage:[UIImage imageNamed:iconArray[i]] forState:UIControlStateNormal];
        button.tag = i;
      
        [button addTarget:self action:@selector(ImgClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerView addSubview:button];
        
  
        if (i== iconArray.count -1) {
            
            lastBtn = button;
            
        }
        
        
    }
    
    
    headerView.frame = CGRectMake(0, 0, WIDTH, CGRectGetMaxY(lastBtn.frame)+10+CGRectGetMaxY(self.topView.frame));
    
    self.footerView.frame =CGRectMake(0, CGRectGetMaxY(self.topView.frame), WIDTH, CGRectGetMaxY(lastBtn.frame));
    
//    ImgView.frame = CGRectMake(0, CGRectGetMaxY(self.textView.frame)+10, WIDTH, CGRectGetMaxY(lastBtn.frame)- CGRectGetMaxY(self.textView.frame)-10);
    
    
    
    
    
    return headerView;
}




-(void)ImgClick:(UIButton *)btn
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
