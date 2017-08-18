//
//  PollingRecordUploadViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/27.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "PollingRecordUploadViewController.h"
#import "QTRejectViewCell.h"
#import "TZImagePickerController.h"
#import "HXTagsView.h"
#import "XWDragCellCollectionView.h"
#import "XDAlertController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface PollingRecordUploadViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,XWDragCellCollectionViewDataSource, XWDragCellCollectionViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextViewDelegate>
{
    XWDragCellCollectionView *_collectionView;
    NSInteger _count;
    
}

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIView *footerView;

@property(nonatomic, strong) UIImageView *yuanImg,*jinImg;

@property(nonatomic, strong)UIButton *statuBtn;

@property(nonatomic, strong)UIButton *statuSelBtn;


@property(nonatomic, strong)NSString *nfcCode;
//输入的备注

@property(nonatomic, strong) UIView *bootomView;

@property(nonatomic,strong)UITextView *sgTextView;
@property(nonatomic,strong)UILabel *placeLabel;

@property(nonatomic, strong) UIButton *senderBtn;

@end

@implementation PollingRecordUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"巡检记录上传";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    _tableView.tableFooterView = [self footerViews];
    
    self.phonelist = [[NSMutableArray alloc]init];
    
    /*隐藏键盘*/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    
}

-(void)setIntentDic:(NSDictionary *)intentDic{
    self.nfcCode=intentDic[@"nfcCode"];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    _statuSelBtn.hidden=YES;
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
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
//{
//    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
//        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
//        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
//    }
//    else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
//        
//    }
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    
//}
- (void)saveImage:(UIImage *)image {
    // 对于base64编码编码
    //    NSString *headImageString=[self UIImageToBase64Str:image];
//    [kNetManager changeUserIcon:[DEFAULTS objectForKey:@"userId"] headcode:headImageString Success:^(id responseObject) {
//        NSLog(@"头像上传成功%@",responseObject);
//        if ([responseObject[@"status"] integerValue]==100) {
//            
//            _iconimage.image=image;
//        }
//    } Failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
}
-(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 0.1f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodedImageStr;
}
-(UIView *)footerViews
{
    
    if (!_footerView) {
        
        self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, (10+(WIDTH-20)*156/345)*2+50+(WIDTH-40)/3+[MyAdapter aDapter:161]+50+50)];
        self.footerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *statuLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 40)];
        statuLab.text=@"状态";
        [self.footerView addSubview:statuLab];
        
        UIButton *statuBtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width-100, 0, 80, 40)];
        statuBtn.selected=YES;
        self.statuBtn=statuBtn;
        [statuBtn setTitle:@"正常" forState:UIControlStateNormal];
        [statuBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [statuBtn addTarget:self action:@selector(changeStatu:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerView addSubview:statuBtn];
        
     
        
        UIView *sepView=[[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreen_Width, 1)];
        sepView.backgroundColor=[UIColor colorWithHexString:@"0xd3d3d3"];
        [self.footerView addSubview:sepView];
        
        self.yuanImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 55, WIDTH-20, (WIDTH -20)*156/345)];
        self.yuanImg.tag=0;
        self.yuanImg.userInteractionEnabled=YES;
        self.yuanImg.image = [UIImage imageNamed:@"yuanjing"];
        [self.footerView addSubview:self.yuanImg];
       
        
        self.jinImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.yuanImg.frame)+10, WIDTH-20, (WIDTH -20)*156/345)];
        self.jinImg.tag=0;
        self.jinImg.userInteractionEnabled=YES;
        self.jinImg.image = [UIImage imageNamed:@"jinjing"];
        [self.footerView addSubview:self.jinImg];
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
        
        
        
        //尾部视图
        self.bootomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_collectionView.frame)+10, WIDTH, [MyAdapter aDapter:140]+20)];
        self.bootomView.backgroundColor = [UIColor whiteColor];
        [self.footerView addSubview:self.bootomView];
        
        UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 10)];
        lineview.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
        [self.bootomView addSubview:lineview];
        
        _sgTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, WIDTH-20, [MyAdapter aDapter:100])];
        _sgTextView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
        _sgTextView.font = [MyAdapter fontADapter:14];
        _sgTextView.scrollEnabled = YES;//是否可以拖动
        _sgTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
        _sgTextView.delegate = self;
        _sgTextView.tag = 300;
        [self.bootomView addSubview:_sgTextView];
        
        _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, CGRectGetWidth(_sgTextView.bounds), 30)];
        _placeLabel.text = @"在这里填写备注";
        _placeLabel.font = [MyAdapter fontADapter:14];
        _placeLabel.textColor = [AppAppearance sharedAppearance].title3TextColor
        ;
        [_sgTextView addSubview:_placeLabel];
        
        
        self.senderBtn = [[UIButton alloc] init];
        [self.senderBtn setTitle:@"巡查记录上传" forState:UIControlStateNormal];
        [self.senderBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
        [self.senderBtn setBackgroundColor:[AppAppearance sharedAppearance].mainColor];
        self.senderBtn.titleLabel.font = [MyAdapter fontADapter:16];
        self.senderBtn.layer.cornerRadius = 6;
        self.senderBtn.layer.masksToBounds = YES;
        
        self.senderBtn.frame = CGRectMake(20, CGRectGetMaxY(self.sgTextView.frame)+10, self.view.frame.size.width-40, [MyAdapter aDapter:40]);
        [self.senderBtn addTarget:self action:@selector(senderButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bootomView addSubview:self.senderBtn];
        
        _statuSelBtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width-100, 42, 80, 40)];
        [_statuSelBtn setTitle:@"异常" forState:UIControlStateNormal];
        [_statuSelBtn setBackgroundColor:[UIColor whiteColor]];
        [_statuSelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _statuSelBtn.hidden=YES;
//        _statuSelBtn.layer.cornerRadius = 5;
        _statuSelBtn.layer.shadowOffset =  CGSizeMake(1, 1);
        _statuSelBtn.layer.shadowOpacity = 0.8;
        _statuSelBtn.layer.shadowColor =  [UIColor blackColor].CGColor;
        [_statuSelBtn addTarget:self action:@selector(selStatu:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerView addSubview:_statuSelBtn];

        
    }
    return _footerView;
}


//完成添加
-(void)senderButtonAction
{
    if (self.yuanImg.tag==0) {
        showAlert(@"请上传远景照片");
        return;
    }else if (self.jinImg.tag==0){
        showAlert(@"请上传近景照片");
    }
    NSLog(@"phonelist%@",self.phonelist);
    NSString *appKey=[AppDataManager defaultManager].identifier;
    NSString *nfcCode=self.nfcCode;
    NSString *nfcPatrolPerson=@"nfcPatrolPerson";
    NSString *nfcPatrolTime=[self getNowTime];
    NSString *nfcRemark=_sgTextView.text;
    NSString *nfcStatus=_statuBtn.titleLabel.text;
    NSString *nfcFarImg=[self UIImageToBase64Str:_yuanImg.image];
    NSString *nfcNearImg=[self UIImageToBase64Str:_jinImg.image];
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
    
    NSDictionary *param = @{@"appKey":appKey,@"nfcCode":nfcCode,@"nfcPatrolPerson":nfcPatrolPerson,@"nfcPatrolTime":nfcPatrolTime,@"nfcRemark":nfcRemark,@"nfcStatus":nfcStatus,@"nfcFarImg":nfcFarImg,@"nfcNearImg":nfcNearImg,@"nfcDetailImg":nfcDetailImg,};
    [RequestManager postRequestWithURLPath:[URLManager requestURLGenetatedWithURL:KURLPollingUpload] withParamer:param completionHandler:^(id responseObject) {
        NSLog(@"上传巡检结果：%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            [self.navigationController popViewControllerAnimated:NO];
            [JRToast showWithText:@"上传成功" duration:1.0];
        }
        
        
    } failureHandler:^(NSError *error, NSUInteger statusCode) {
        NSLog(@"上传巡检结果错误：%@",error);
    }];

}
-(NSString *)getNowTime{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}
-(void)selStatu:(UIButton *)sender{
    
    _statuSelBtn.hidden=YES;
  
    if (_statuBtn.selected==YES) {
        [_statuSelBtn setTitle:@"正常" forState:UIControlStateNormal];
        [_statuBtn setTitle:@"异常" forState:UIControlStateNormal];
    }else{
        [_statuSelBtn setTitle:@"异常" forState:UIControlStateNormal];
        [_statuBtn setTitle:@"正常" forState:UIControlStateNormal];
    }
     _statuBtn.selected=!_statuBtn.selected;
}
-(void)changeStatu:(UIButton *)sender{
    if (_statuBtn.selected==YES) {
         [_statuSelBtn setTitle:@"异常" forState:UIControlStateNormal];
    }else{
         [_statuSelBtn setTitle:@"正常" forState:UIControlStateNormal];
    }
   
    _statuSelBtn.hidden=NO;
   // [sender setTitle:@"异常" forState:UIControlStateNormal];
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
    
    self.bootomView.frame = CGRectMake(0, CGRectGetMaxY(_collectionView.frame)+10, WIDTH, [MyAdapter aDapter:140]+20);
    
    self.footerView.frame = CGRectMake(0, 0, WIDTH,(10+(WIDTH-20)*156/345)*2+50+[MyAdapter aDapter:161]+50+_collectionView.frame.size.height);
    
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

}



#pragma mark  ---UItextViewDelegate-------
-(void)textViewDidChange:(UITextView *)textView
{
    
    if(_sgTextView.text.length !=0)
    {
        _placeLabel.hidden = YES;
    }
    else
    {
        _placeLabel.hidden=  NO;
    }
}




-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    _sgTextView.text=@"";
    _placeLabel.hidden = NO;
    
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
