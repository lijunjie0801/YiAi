//
//  EditNFCequipmentViewController.m
//  YiAi
//
//  Created by lijunjie on 2017/7/31.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "EditNFCequipmentViewController.h"
#import "UserBehaviorsTableViewCell.h"
#import "QTRejectViewCell.h"
#import "TZImagePickerController.h"
#import "HXTagsView.h"
#import "XWDragCellCollectionView.h"
#import "BBTextField.h"
#import "WSDatePickerView.h"
#import "XDAlertController.h"
@interface EditNFCequipmentViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,XWDragCellCollectionViewDataSource, XWDragCellCollectionViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    XWDragCellCollectionView *_collectionView;
    NSInteger _count;
}

@property(nonatomic, strong) NSArray *itemsArray;
@property(nonatomic, strong) NSArray *detailsArray;
@property(nonatomic, strong) NSArray *deviceArray;
@property(nonatomic, strong) NSArray *mieArray;
@property(nonatomic, strong) NSDictionary *dictionarray;
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIView *footerView;

@property(nonatomic, strong) UIView *ProSelView;

@property(nonatomic, strong)UIView *topview;

@property(nonatomic, strong)UIView *midview;

@property(nonatomic, strong)UIView *botview;

@property(nonatomic, strong)UIButton *bigBtn;

@property(nonatomic, strong)NSString *deviceNum,*changeStr,*firstPro,*proName,*deviceName,*num,*deviceAddress,*person,*install,*due;

@property(nonatomic, strong)UITextField *devicetf,*numtf,*persontf,*addresstf,*devicenumtf;

//"项目名称",@"设备名称",@"设备类型",@"设备编号",@"编号",@"位置",@"状态",@"备注"
@property(nonatomic, strong) UITextField *goodNameFiel,*equitmentFiel,*equitmentTypeFile,*equitmentNoFile,*numNoFile,*locationFile,*stateFiel,*remarkFile;
//@property(nonatomic, strong) NSDictionary *dictionarray;
@property(nonatomic, strong) UIImageView *yuanImg,*jinImg;

@property(nonatomic, strong) UIButton *senderBtn;

@property(nonatomic, strong) UILabel *proLab,*deviceLab,*statuLab,*installLab,*dueLab,*mieLab;


@property(nonatomic, strong) NSMutableArray *proNameArray;

@property(nonatomic, strong)UIButton *statuBtn;
@end

@implementation EditNFCequipmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"修改设备";
  //  [self getProCode];
    self.itemsArray = @[@"项目名称",@"设备名称",@"设备类型",@"设备编号",@"编号",@"位置",@"状态",@"责任人",@"安装时间",@"到期时间"];
    self.detailsArray = @[@"请填写项目名称",@"请填写设备名称",@"请选择设备类型",@"请填写设备编号",@"请填写编号",@"请填写设备位置",@"请选择设备状态",@"请填写设备备注",@"请填写设备备注"];
//    NSArray *proNames=@[@"依爱厂房",@"步步高超市金海店",@"H88越虹广场",@"依爱测试系统",@"义乌市演示项目",@"依爱A12厂房"];
    self.deviceArray=@[@"灭火器", @"消火栓", @"喷淋泵", @"消防水炮", @"稳压泵", @"正压风机", @"水流指示器", @"讯响器", @"送风口", @"电梯", @"防火阀",@"消火栓泵", @"防火卷帘", @"消防广播", @"照明配电", @"排烟机", @"压力开关", @"非消防电源", @"消防电话", @"应急照明", @"控制器", @"其他"];
    self.mieArray=@[@"水基", @"干粉", @"泡沫", @"1211", @"二氧化碳", @"其他"];
    self.changeStr=@"异常";
    // self.proNameArray=[proNames mutableCopy];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    _tableView.tableFooterView = [self footerViews];
    
    self.phonelist = [[NSMutableArray alloc]init];
    self.tableView.tableHeaderView=[self setTopView];
}
-(void)setIntentDic:(NSDictionary *)intentDic{
    self.proName=intentDic[@"proName"];
    self.deviceName=intentDic[@"deviceName"];
    self.deviceNum=intentDic[@"deviceNum"];
    self.num=intentDic[@"num"];
    self.deviceAddress=intentDic[@"address"];
    self.person=intentDic[@"person"];
    self.install=intentDic[@"install"];
    self.due=intentDic[@"due"];
    
    NSArray *arr=intentDic[@"pronames"];
    NSArray *arr1 = [arr subarrayWithRange:NSMakeRange(1, arr.count -1)];
    self.firstPro=arr[0];
    self.proNameArray=[arr1 mutableCopy];
    self.dictionarray=intentDic[@"dic"];
}
//-(void)getProCode{
//    
//}
-(void)haha:(UITapGestureRecognizer*)tap{
    
    _bigBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height*2)];
    [_bigBtn addTarget:self action:@selector(empty) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:_bigBtn];
    
    NSInteger i=[tap view].tag;
    if (i==0) {
         UIScrollView *view=[self setProSelView];
        view.backgroundColor=[UIColor whiteColor];
      //  self.ProSelView=view;
        view.frame=CGRectMake(kScreen_Width-150, 44, 150, 44*self.proNameArray.count);
        view.layer.shadowOffset =  CGSizeMake(1, 1);
        view.layer.shadowOpacity = 0.8;
        view.layer.shadowColor =  [UIColor blackColor].CGColor;
        
        [_bigBtn addSubview:view];
    }else if(i==2){
        UIScrollView *view=[self setDeviceView];
        view.backgroundColor=[UIColor whiteColor];
        //self.ProSelView=view;
        view.frame=CGRectMake(kScreen_Width-150, 44*3, 150, kScreen_Height-44*3);
        view.layer.shadowOffset =  CGSizeMake(1, 1);
        view.layer.shadowOpacity = 0.8;
        view.layer.shadowColor =  [UIColor blackColor].CGColor;
        [_bigBtn addSubview:view];
        
    }
}
-(void)empty{
    [_bigBtn removeFromSuperview];
}

-(UIView *)setTopView{
    UIView *selview=[[UIView alloc]initWithFrame:CGRectMake(0,0 , kScreen_Width, 44*10)];
    NSArray *arr=@[self.proName,self.deviceName,@"消防泵"];
    _topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 44*3)];
    _topview.backgroundColor=[UIColor whiteColor];
    for (int i=0; i<3; i++) {
        UILabel *leftLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 44*i, 100, 44)];
        leftLab.text=self.itemsArray[i];
        [_topview addSubview:leftLab];
        leftLab.userInteractionEnabled=YES;
        if (i==1) {
            _devicetf=[[UITextField alloc]initWithFrame:CGRectMake(kScreen_Width-160, 44, 150, 44)];
            _devicetf.text=self.deviceName;
            _devicetf.textAlignment=NSTextAlignmentRight;
            [_topview addSubview:_devicetf];
        }
        
        if (i!=1) {
            UILabel *rightLab=[[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width-160, 44*i, 145, 44)];
            rightLab.tag=i;
            rightLab.text=arr[i];
            rightLab.textAlignment=NSTextAlignmentRight;
            rightLab.userInteractionEnabled=YES;
            [_topview addSubview:rightLab];
            if (i==0) {
                self.proLab=rightLab;
            }else if(i==2){
                self.deviceLab=rightLab;
            }
            //            else{
            //                _deviceHideLab=rightLab;
            //                rightLab.textColor=[UIColor colorWithHexString:@"0xc8c8c8"];
            //            }
            
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(haha:)];
            [rightLab addGestureRecognizer:tapGestureRecognizer];
        }
        UIView *sepview=[[UIView alloc]initWithFrame:CGRectMake(0, 43.5*(i+1), kScreen_Width, 0.5)];
        sepview.backgroundColor=[UIColor colorWithHexString:@"0xd3d3d3"];
        [_topview addSubview:sepview];
        
    }
    [selview addSubview:_topview];
    
    _midview=[[UIView alloc]initWithFrame:CGRectMake(0, 44*3, kScreen_Width, 44)];
    _midview.backgroundColor=[UIColor whiteColor];
    _midview.hidden=YES;
    [selview addSubview:_midview];
    UILabel *leftLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    leftLab.text=@"灭火器类型";
    [_midview addSubview:leftLab];
    UILabel *rightLab=[[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width-160, 0, 145, 44)];
    rightLab.text=@"水";
    _mieLab=rightLab;
    rightLab.userInteractionEnabled=YES;
    rightLab.textAlignment=NSTextAlignmentRight;
    rightLab.userInteractionEnabled=YES;
    [_midview addSubview:rightLab];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeMie:)];
    [rightLab addGestureRecognizer:tapGestureRecognizer];
    
    
    UIView *sepviewp=[[UIView alloc]initWithFrame:CGRectMake(0, 43.5, kScreen_Width, 0.5)];
    sepviewp.backgroundColor=[UIColor colorWithHexString:@"0xd3d3d3"];
    [_midview addSubview:sepviewp];
    
    
    
    _botview=[[UIView alloc]initWithFrame:CGRectMake(0, 44*3, kScreen_Width, 44*7)];
    _botview.backgroundColor=[UIColor whiteColor];
    for (int i=0; i<7; i++) {
        if (i==0) {
            _devicenumtf=[[UITextField alloc]initWithFrame:CGRectMake(kScreen_Width-160, 0, 150, 44)];
            _devicenumtf.text=self.deviceNum;
            _devicenumtf.textAlignment=NSTextAlignmentRight;;
            [_botview addSubview:_devicenumtf];
        }else if (i==1) {
            _numtf=[[UITextField alloc]initWithFrame:CGRectMake(kScreen_Width-160, 44, 150, 44)];
            _numtf.text=self.num;
            _numtf.textAlignment=NSTextAlignmentRight;;
            [_botview addSubview:_numtf];
        }else if(i==2){
            _addresstf=[[UITextField alloc]initWithFrame:CGRectMake(kScreen_Width-160, 44*2, 150, 44)];
            _addresstf.text=self.deviceAddress;
            _addresstf.textAlignment=NSTextAlignmentRight;
            [_botview addSubview:_addresstf];
            
        }else if (i==4){
            _persontf=[[UITextField alloc]initWithFrame:CGRectMake(kScreen_Width-160, 44*4, 150, 44)];
            _persontf.textAlignment=NSTextAlignmentRight;
            _persontf.text=self.person;
            [_botview addSubview:_persontf];
        }
        
        UILabel *leftLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 44*i, 100, 44)];
        leftLab.text=self.itemsArray[3+i];
        [_botview addSubview:leftLab];
        UIView *sepviewt=[[UIView alloc]initWithFrame:CGRectMake(0, 43.5*(i+1), kScreen_Width, 0.5)];
        sepviewt.backgroundColor=[UIColor colorWithHexString:@"0xd3d3d3"];
        [_botview addSubview:sepviewt];
        
        if (i!=0&i!=1&i!=2&i!=4) {
            UILabel *rightLab=[[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width-170, 44*i, 160, 44)];
            rightLab.userInteractionEnabled=YES;
            rightLab.tag=i;
            rightLab.textAlignment=NSTextAlignmentRight;
            rightLab.userInteractionEnabled=YES;
            [_botview addSubview:rightLab];
            if (i==3){
                _statuLab=rightLab;
                rightLab.text=@"正常";
            }else if (i==5){
                _installLab=rightLab;
                rightLab.text=_install;
            }else if (i==6){
                _dueLab=rightLab;
                rightLab.text=_due;
            }
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeCont:)];
            [rightLab addGestureRecognizer:tapGestureRecognizer];
            
        }
        
    }
    [selview addSubview:_botview];
    return  selview;
}
-(void)changeMie:(UITapGestureRecognizer*)tap{
    _bigBtn=[[UIButton alloc]initWithFrame:self.view.bounds];
    [_bigBtn addTarget:self action:@selector(empty) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:_bigBtn];
    UIView *view=[self setMieView];
    view.backgroundColor=[UIColor whiteColor];
    view.frame=CGRectMake(kScreen_Width-150, 44*4, 150, 44*6);
    view.layer.shadowOffset =  CGSizeMake(1, 1);
    view.layer.shadowOpacity = 0.8;
    view.layer.shadowColor =  [UIColor blackColor].CGColor;
    [_bigBtn addSubview:view];
}

-(void)changeCont:(UITapGestureRecognizer*)tap{
    _bigBtn=[[UIButton alloc]initWithFrame:self.view.bounds];
    [_bigBtn addTarget:self action:@selector(empty) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:_bigBtn];
    NSInteger i=[tap view].tag;
    if (i==3) {
        _statuBtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width-80, 44*7, 80, 44)];
        if ([_deviceLab.text isEqualToString:@"灭火器"]) {
            _statuBtn.frame=CGRectMake(kScreen_Width-80, 44*8, 80, 44);;
        }else{
            _statuBtn.frame=CGRectMake(kScreen_Width-80, 44*7, 80, 44);
        }
        
        [_statuBtn setBackgroundColor:[UIColor whiteColor]];
        [_statuBtn setTitle:self.changeStr forState:UIControlStateNormal];
        [_statuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_statuBtn addTarget:self action:@selector(changeStatu:) forControlEvents:UIControlEventTouchUpInside];
        _statuBtn.layer.shadowOffset =  CGSizeMake(1, 1);
        _statuBtn.layer.shadowOpacity = 0.8;
        _statuBtn.layer.shadowColor =  [UIColor blackColor].CGColor;
        [_bigBtn addSubview:_statuBtn];
    }else if (i==5||i==6){
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *startDate) {
            NSString *date = [startDate stringWithFormat:@"yyyy/MM/dd HH:mm:ss"];
            NSLog(@"时间： %@",date);
            if (i==5) {
                _installLab.text=date;
            }else{
                _dueLab.text=date;
            }
            
        }];
        datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
        [datepicker show];
    }
}
-(void)changeStatu:(UIButton *)sender{
    NSString *s=_statuLab.text;
    _statuLab.text=sender.titleLabel.text;
    self.changeStr=s;
    [_bigBtn removeFromSuperview];
}

-(UIView *)footerViews
{
    
    if (!_footerView) {
        
        self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, (10+(WIDTH-20)*156/345)*2+50+(WIDTH-40)/3+[MyAdapter aDapter:61]+30+40)];
        self.footerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreen_Width-10, 20)];
        lab.text=@"图片无修改可不选择";
        lab.textColor=[UIColor grayColor];
        [self.footerView addSubview:lab];
        
        self.yuanImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, WIDTH-20, (WIDTH -20)*156/345)];
        self.yuanImg.tag=0;
        self.yuanImg.image = [UIImage imageNamed:@"yuanjing"];
        [self.footerView addSubview:self.yuanImg];
        
        self.jinImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.yuanImg.frame)+10, WIDTH-20, (WIDTH -20)*156/345)];
        self.jinImg.image = [UIImage imageNamed:@"jinjing"];
        [self.footerView addSubview:self.jinImg];
        self.jinImg.tag=0;
        self.jinImg.userInteractionEnabled=YES;
        self.yuanImg.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapFar=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadFar:)];
        UITapGestureRecognizer *tapNear=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadNear:)];
        [self.yuanImg addGestureRecognizer:tapFar];
        [self.jinImg addGestureRecognizer:tapNear];
        
        UILabel *aroundLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.jinImg.frame)+10, WIDTH-20, [MyAdapter aDapter:21])];
        aroundLbl.text = @"设备周边环境图片";
        aroundLbl.font = [MyAdapter fontADapter:14];
        aroundLbl.textColor = [AppAppearance sharedAppearance].title3TextColor;
        [self.footerView addSubview:aroundLbl];
        
        
        //中部视图
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[XWDragCellCollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(aroundLbl.frame)+10, WIDTH,(WIDTH-40)/3+20) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[QTRejectViewCell class] forCellWithReuseIdentifier:@"rejectViewMeCell"];
        [self.footerView addSubview:_collectionView];
        
        //        self.viewlin = [[UIView alloc]initWithFrame:CGRectMake(0, _collectionView.frame.size.height-1, WIDTH, 1)];
        //        self.viewlin.backgroundColor = [AppAppearance sharedAppearance].cellLineColor;
        //        [_collectionView addSubview:self.viewlin];
        
        //添加照片按钮
        self.btnAddPhone = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnAddPhone.frame = CGRectMake(10, 10, (WIDTH-40)/3, (WIDTH-40)/3);
        [self.btnAddPhone setBackgroundImage:[UIImage imageNamed:@"icon_find_phone_tianjia2"] forState:UIControlStateNormal];
        [self.btnAddPhone addTarget:self action:@selector(BtnAddPhoneClick) forControlEvents:UIControlEventTouchUpInside];
        [_collectionView addSubview:self.btnAddPhone];
        
        
        self.senderBtn = [[UIButton alloc] init];
        [self.senderBtn setTitle:@"完成修改" forState:UIControlStateNormal];
        [self.senderBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
        [self.senderBtn setBackgroundColor:[AppAppearance sharedAppearance].mainColor];
        self.senderBtn.titleLabel.font = [MyAdapter fontADapter:16];
        self.senderBtn.layer.cornerRadius = 6;
        self.senderBtn.layer.masksToBounds = YES;
        
        self.senderBtn.frame = CGRectMake(20, CGRectGetMaxY(_collectionView.frame)+10, self.view.frame.size.width-40, [MyAdapter aDapter:40]);
        [self.senderBtn addTarget:self action:@selector(senderButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footerView addSubview:self.senderBtn];
        
        
        
    }
    return _footerView;
}


//完成添加
-(void)senderButtonAction
{

    NSLog(@"phonelist%@",self.phonelist);
    NSString *appKey=[AppDataManager defaultManager].identifier;
    NSString *proCode=[self.dictionarray objectForKey:self.proLab.text];
    NSString *proCodeName=self.proLab.text;
    NSString *nfcCode=self.deviceNum;
    NSString *number=_numtf.text;
    NSString *deviceName=_devicetf.text;
    NSString *deviceType=_deviceLab.text;
    NSString *position=_addresstf.text;
    NSString *deviceSecondType;
    if ([deviceType isEqualToString:@"灭火器"]) {
        deviceSecondType=_mieLab.text;
    }else{
        deviceSecondType=@"";
    }
    
    NSString *personPetect=_persontf.text;
    NSString *installTime=_installLab.text;
    NSString *dueTime=_dueLab.text;
    NSString *status=_statuLab.text;
    NSString *nfcFarImg;
    NSString *nfcNearImg;
    if (self.yuanImg.tag==0) {
        nfcFarImg=@"";
    }else{
        nfcFarImg=[self UIImageToBase64Str:_yuanImg.image];
    }
    
   if (self.jinImg.tag==0){
       nfcNearImg=@"";
   }else{
       nfcNearImg=[self UIImageToBase64Str:_jinImg.image];
   }
    NSString *nfcRemark=@"";
    NSMutableArray *imgArray=[NSMutableArray array];
    for (UIImage *img in _phonelist) {
        NSString *imgStr=[self UIImageToBase64Str:img];
        [imgArray addObject:imgStr];
    }
    NSString *nfcDetailImg;
    if (imgArray.count>0) {
        nfcDetailImg = [imgArray componentsJoinedByString:@","];
    }else if(imgArray.count==1){
        nfcDetailImg = imgArray[0];
    }else{
        nfcDetailImg =@"";
    }
    NSDictionary *param = @{@"appKey":appKey,@"proCode":proCode,@"proCodeName":proCodeName,@"nfcCode":nfcCode,@"number":number,@"deviceName":deviceName,@"deviceType":deviceType,@"deviceSecondType":deviceSecondType,@"personPetect":personPetect,@"installTime":installTime,@"dueTime":dueTime,@"status":status,@"nfcFarImg":nfcFarImg,@"nfcNearImg":nfcNearImg,@"remark":nfcRemark,@"nfcDetailImg":nfcDetailImg,@"position":position};
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLUpdateNfcDevice] withParamer:param completionHandler:^(id responseObject) {
        NSLog(@"上传NFC设备数据：%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
          [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2]animated:YES];
        [JRToast showWithText:@"上传设备信息成功" duration:2.0];
        }else{
            
        }
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        NSLog(@"上传NFC设备数据%@",error);
    }];
    
    
}
-(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 0.1f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodedImageStr;
}
-(void)uploadFar:(UITapGestureRecognizer*)tap{
    [self selectPicker:@"1"];
}
-(void)uploadNear:(UITapGestureRecognizer*)tap{
    [self selectPicker:@"2"];
}

-(void)selectPicker:(NSString *)picker{
    NSString *title;
    if ([picker integerValue]==1) {
        title=@"获取远景照片";
        _count=1;
    }else{
        title=@"获取近景照片";
        _count=2;
    }
    XDAlertController *alert = [XDAlertController alertControllerWithTitle:title message:nil preferredStyle:XDAlertControllerStyleActionSheet];
    XDAlertAction *action1 = [XDAlertAction actionWithTitle:@"从相册获取" style: XDAlertActionStyleDefault handler:^( XDAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    XDAlertAction *action2 = [XDAlertAction actionWithTitle:@"拍照" style: XDAlertActionStyleDefault handler:^( XDAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    XDAlertAction *action3 = [XDAlertAction actionWithTitle:@"取消" style:XDAlertActionStyleCancel handler:^(XDAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [self presentViewController:alert animated:YES completion:nil];
}



#pragma mark  --------UITableViewDelegate---------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;// self.itemsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UserBehaviorsTableViewCell *cell = [UserBehaviorsTableViewCell userBehaviorsTableViewCellWithTableView:tableView];
    
    cell.lblName.text = self.itemsArray[indexPath.row];
    cell.textField.placeholder = self.detailsArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(UIScrollView *)setDeviceView{
    UIScrollView *deviceView=[[UIScrollView alloc]init];
    deviceView.contentSize = CGSizeMake(0, 44*self.deviceArray.count);
    deviceView.bounces = NO;
    deviceView.pagingEnabled = YES;
    deviceView.showsHorizontalScrollIndicator = NO;
    deviceView.showsVerticalScrollIndicator = NO;
    for (int i=0; i<self.deviceArray.count; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, i*44, 150, 44)];
        btn.tag=i;
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [btn setTitle:self.deviceArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // [btn setBackgroundColor:[UIColor redColor]];
        [btn addTarget:self action:@selector(selectDevice:) forControlEvents:UIControlEventTouchUpInside];
        
        [deviceView addSubview:btn];
        
    }
    return deviceView;
}
-(UIScrollView *)setProSelView{
    UIScrollView *deviceView=[[UIScrollView alloc]init];
    deviceView.contentSize = CGSizeMake(0, 44*self.proNameArray.count);
    deviceView.bounces = NO;
    deviceView.pagingEnabled = YES;
    deviceView.showsHorizontalScrollIndicator = NO;
    deviceView.showsVerticalScrollIndicator = NO;
    for (int i=0; i<self.proNameArray.count; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, i*44, 150, 44)];
        btn.tag=i;
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [btn setTitle:self.proNameArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // [btn setBackgroundColor:[UIColor redColor]];
        [btn addTarget:self action:@selector(selectProName:) forControlEvents:UIControlEventTouchUpInside];
        
        [deviceView addSubview:btn];
        
    }
    return deviceView;
}
-(UIView *)setMieView{
    UIView *mieView=[[UIView alloc]init];
    
    for (int i=0; i<self.mieArray.count; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, i*44, 150, 44)];
        btn.tag=i;
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [btn setTitle:self.mieArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // [btn setBackgroundColor:[UIColor redColor]];
        [btn addTarget:self action:@selector(selectMieName:) forControlEvents:UIControlEventTouchUpInside];
        [mieView addSubview:btn];
        
    }
    return mieView;
}
-(void)selectMieName:(UIButton *)sender{
    NSMutableArray *newArray = [_mieArray mutableCopy];
    [newArray replaceObjectAtIndex:sender.tag withObject:_mieLab.text];
    _mieLab.text=self.mieArray[sender.tag];
    _mieArray = newArray;
    [_bigBtn removeFromSuperview];
    
}
-(void)selectProName:(UIButton *)sender{
    NSMutableArray *newArray = [_proNameArray mutableCopy];
    [newArray replaceObjectAtIndex:sender.tag withObject:_proLab.text];
    _proLab.text=self.proNameArray[sender.tag];
    _proNameArray = newArray;
    [_bigBtn removeFromSuperview];
    
}
-(void)selectDevice:(UIButton *)sender{
    if([sender.titleLabel.text isEqualToString:@"灭火器"]){
        _botview.frame=CGRectMake(0, 44*4, kScreen_Width, 44*7);
        self.tableView.tableHeaderView.frame=CGRectMake(0, 0, kScreen_Width, 44*11);
        _midview.hidden=NO;
    }else{
        _botview.frame=CGRectMake(0, 44*3, kScreen_Width, 44*7);
        self.tableView.tableHeaderView.frame=CGRectMake(0, 0, kScreen_Width, 44*10);
        _midview.hidden=YES;
    }
    [self.tableView reloadData];
    NSMutableArray *newArray = [_deviceArray mutableCopy];
    [newArray replaceObjectAtIndex:sender.tag withObject:_deviceLab.text];
    _deviceLab.text=self.deviceArray[sender.tag];
    _deviceArray = newArray;
    [_bigBtn removeFromSuperview];
    
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_ProSelView removeFromSuperview];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row ==0) {
        if (_proLab.tag%2==0) {
            UIView *view=[self setProSelView];
            view.backgroundColor=[UIColor whiteColor];
            
            self.ProSelView=view;
            view.frame=CGRectMake(kScreen_Width-150, 44, 150, 44*5);
            view.layer.shadowOffset =  CGSizeMake(1, 1);
            view.layer.shadowOpacity = 0.8;
            view.layer.shadowColor =  [UIColor blackColor].CGColor;
            [self.tableView addSubview:view];
        }else{
            [self.ProSelView removeFromSuperview];
        }
        _proLab.tag++;
        
    }
    if (indexPath.row ==2) {
        
        NSArray *textArray = @[@"消防",@"带你飞的",@"设备"];
        [ActionSheetStringPicker showPickerWithTitle:nil rows:textArray initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            
            self.equitmentTypeFile.text = textArray[selectedIndex];
            
            
        } cancelBlock:^(ActionSheetStringPicker *picker) {
            
            
        } origin:self.view];
        
    }
    
    if (indexPath.row ==6) {
        
        NSArray *textArray = @[@"可用",@"不可用",@"可用可不用"];
        [ActionSheetStringPicker showPickerWithTitle:nil rows:textArray initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            
            self.stateFiel.text = textArray[selectedIndex];
            
        } cancelBlock:^(ActionSheetStringPicker *picker) {
            
            
        } origin:self.view];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyAdapter aDapter:44];
}




#pragma mark       -----------点击点击多张周边环境图片的代理方法-------------

#pragma mark HXTagsViewDelegate

/**
 *  tagsView代理方法
 *
 *  @param tagsView tagsView
 *  @param sender   tag:sender.titleLabel.text index:sender.tag
 */
- (void)tagsViewButtonAction:(HXTagsView *)tagsView button:(UIButton *)sender {
    NSLog(@"tag:%@ index:%ld",sender.titleLabel.text,(long)sender.tag);
    if(sender.tag>0){
        [sender setBackgroundImage:[self imageWithColor:UIColorFromRGB(0x05d2a2) size:CGSizeMake(1.0, 1.0)] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.layer.borderColor = [[UIColor clearColor] CGColor];
    }else if (sender.tag<0){
        [sender setBackgroundImage:[self imageWithColor:[UIColor whiteColor] size:CGSizeMake(1.0, 1.0)] forState:UIControlStateNormal];
        [sender setTitleColor:UIColorFromRGB(0x7f7f7f) forState:UIControlStateNormal];
        sender.layer.borderColor = [UIColorFromRGB(0x7f7f7f) CGColor];
    }
    sender.tag = -sender.tag;
    
}
//颜色生成图片方法
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   
                                   color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
#pragma mark - UICollectionViewDataSource

- (NSArray *)dataSourceArrayOfCollectionView:(XWDragCellCollectionView *)collectionView{
    return self.phonelist;
}

- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView newDataArrayAfterMove:(NSMutableArray *)newDataArray{
    [self.phonelist removeAllObjects];
    [self.phonelist addObjectsFromArray:newDataArray];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.phonelist.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QTRejectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rejectViewMeCell" forIndexPath:indexPath];
    cell.imageView.image = [self.phonelist objectAtIndex:indexPath.row];
    cell.delBtn.tag = 100+indexPath.row;
    [cell.delBtn addTarget:self action:@selector(BtnDelPhone:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((WIDTH-40)/3, (WIDTH-40)/3);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//删除照片的事件
- (void)BtnDelPhone:(UIButton *)sender{
    [self.phonelist removeObjectAtIndex:sender.tag-100];
    [self resetLayout];
}
//添加图片事件
- (void)BtnAddPhoneClick{
    [self showSheetView];
}
//删除照片
- (void)DelClick{
    [self.phonelist removeAllObjects];
    [self resetLayout];
}

//动态改变界面的高度
-(void)resetLayout{
    int columnCount = ceilf((_phonelist.count + 1) * 1.0 / 3);
    float height = columnCount * ((WIDTH-40)/3 +10)+10;
    if (height < (WIDTH-40)/3+20) {
        height = (WIDTH-40)/3+20;
    }
    CGRect rect = _collectionView.frame;
    rect.size.height = height;
    _collectionView.frame = rect;
    [_collectionView reloadData];
    
    
    self.btnAddPhone.frame = CGRectMake(10+(10+(WIDTH-40)/3)*(self.phonelist.count%3), _collectionView.frame.size.height-(WIDTH-40)/3-10,(WIDTH-40)/3,(WIDTH-40)/3);
    
    self.senderBtn.frame = CGRectMake(20, CGRectGetMaxY(_collectionView.frame)+10, WIDTH-40, [MyAdapter aDapter:40]);
    
    self.footerView.frame = CGRectMake(0, 0, WIDTH,(10+(WIDTH-20)*156/345)*2+50+[MyAdapter aDapter:61]+30+_collectionView.frame.size.height);
    
    //    self.tableView.contentSize = CGSizeMake(WIDTH,CGRectGetMaxY(self.footerView.frame));
    
    [self.tableView reloadData];
}

-(void)showSheetView{
    
    
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择打开方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"相册", nil];
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    [sheet showInView:self.view];
    
    
    
    
    
    //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertAction *setAlert = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //        [self callCameraOrPhotoWithType:UIImagePickerControllerSourceTypeCamera];
    //
    //    }];
    //    UIAlertAction *PhoneAlert = [UIAlertAction actionWithTitle:@"从手机选择" style:
    //                                 UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //                                     TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:20 delegate:nil];
    //                                     // 你可以通过block或者代理，来得到用户选择的照片.
    //
    //                                     [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *asssets, BOOL isOk) {
    //
    //
    //                                         [self.phonelist addObjectsFromArray:photos];
    //                                         [self resetLayout];
    //
    //                                     }];
    //
    //                                     // 在这里设置imagePickerVc的外观
    //                                     imagePickerVc.navigationBar.barTintColor = [UIColor blackColor];
    //                                     imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    //                                     // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    //                                     // 设置是否可以选择视频/原图
    //                                     // imagePickerVc.allowPickingVideo = NO;
    //                                     // imagePickerVc.allowPickingOriginalPhoto = NO;
    //                                     imagePickerVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //                                     [self presentViewController:imagePickerVc animated:YES completion:nil];
    //
    //                                 }];
    //    UIAlertAction *hidAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    //    [alert addAction:setAlert];
    //    [alert addAction:PhoneAlert];
    //    [alert addAction:hidAlert];
    //
    //    [self presentViewController:alert animated:YES completion:^{
    //
    //    }];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _count=3;
    if (buttonIndex == 0) {
        
        
        [self callCameraOrPhotoWithType:UIImagePickerControllerSourceTypeCamera];
        
    }else if (buttonIndex ==1){
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:20 delegate:nil];
        // 你可以通过block或者代理，来得到用户选择的照片.
        
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *asssets, BOOL isOk) {
            
            
            [self.phonelist addObjectsFromArray:photos];
            [self resetLayout];
            
        }];
        
        // 在这里设置imagePickerVc的外观
        imagePickerVc.navigationBar.barTintColor = [UIColor blackColor];
        imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
        // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
        // 设置是否可以选择视频/原图
        // imagePickerVc.allowPickingVideo = NO;
        // imagePickerVc.allowPickingOriginalPhoto = NO;
        imagePickerVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
        
        
        
        
        
    }else{
        
        //取消
    }
}








-(void)callCameraOrPhotoWithType:(UIImagePickerControllerSourceType)sourceType{
    BOOL isCamera = YES;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {//判断是否有相机
        isCamera = [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera];
    }
    if (isCamera) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;//为NO，则不会出现系统的编辑界面
        imagePicker.sourceType = sourceType;
        [self presentViewController:imagePicker animated:YES completion:^(){
            if ([[[UIDevice currentDevice] systemVersion]floatValue]>=7.0) {
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            }
        }];
    } else {
        
    }
}
#pragma UIImagePickerControllerDelegate
//相册或则相机选择上传的实现
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo{
    
    if (_count==1) {
        self.yuanImg.image=aImage;
        self.yuanImg.tag=1;
    }else if(_count==2){
        self.jinImg.image=aImage;
        self.jinImg.tag=1;
    }else{
        
        NSArray *photos = [[NSArray alloc]initWithObjects:aImage, nil];
        [self.phonelist addObjectsFromArray:photos];
        [self resetLayout];
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        // [self uploadPhotos:photos];
    }];
    //    NSArray *photos = [[NSArray alloc]initWithObjects:aImage, nil];
    //
    //    [picker dismissViewControllerAnimated:YES completion:^{
    //        // [self uploadPhotos:photos];
    //    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
