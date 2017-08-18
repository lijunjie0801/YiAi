//
//  PushServiceViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/14.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "PushServiceViewController.h"
#import "QTRejectViewCell.h"
#import "TZImagePickerController.h"
#import "HXTagsView.h"
#import "XWDragCellCollectionView.h"
#import "AutocompletionTableView.h"

//十六进制颜色
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface PushServiceViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,XWDragCellCollectionViewDataSource, XWDragCellCollectionViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>{
    XWDragCellCollectionView *_collectionView;
    
}


@property(nonatomic, strong) UIView *topView,*footerView;

@property(nonatomic, strong) UITextField *nameFile,*locationFile;

@property(nonatomic, strong) UIView *nameView;

@property (nonatomic,strong) AutocompletionTableView *autoTab;


@property(nonatomic,strong)UITextView *sgTextView;
@property(nonatomic,strong)UILabel *placeLabel;

@property(nonatomic, strong) NSMutableArray *nameArray;


@end

@implementation PushServiceViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    [self resetLayout];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}




-(NSMutableArray *)nameArray
{
    if (!_nameArray) {
        
        _nameArray = [NSMutableArray array];
    }
    return _nameArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"填写维修信息";
    [self shouldRightItem];
    
    _nameArray = @[@"你好",@"刘亦菲",@"迪丽热巴",@"小狗",@"小明",@"菜鸟",@"菜逼",@"傻逼",@"二货"];
    
    [self createSubViews];
    
}


-(void)createSubViews
{
    
    self.phonelist = [[NSMutableArray alloc]init];
    
    
    self.svMain = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    self.svMain.backgroundColor = [UIColor clearColor];
    self.svMain.showsVerticalScrollIndicator = NO;
    self.svMain.showsHorizontalScrollIndicator = NO;
    self.svMain.delegate = self;
    [self.view addSubview:self.svMain];
    
    
    //头部视图
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH,(10+[MyAdapter aDapter:40]+10)*2)];
    self.topView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    [self.svMain addSubview:self.topView];
    
    UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10+[MyAdapter aDapter:19]/2, [MyAdapter aDapter:80], [MyAdapter aDapter:21])];
    nameLbl.text = @"工程名称";
    nameLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    nameLbl.font = [MyAdapter fontADapter:16];
    [self.topView addSubview:nameLbl];
    
    
    
    
    
    
    _nameView =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLbl.frame)+10, 10+[MyAdapter aDapter:19]/2, WIDTH - CGRectGetMaxX(nameLbl.frame)-10-10, [MyAdapter aDapter:21])];
    [self.topView addSubview:_nameView];
//    self.nameView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameClick)];
//    [self.nameView addGestureRecognizer:tag];
    
    _nameFile = [[UITextField alloc] initWithFrame:self.nameView.bounds];
    _nameFile.textAlignment = NSTextAlignmentRight;
    _nameFile.font =[MyAdapter fontADapter:16];
    _nameFile.placeholder = @"请选择设备类型";
    _nameFile.tag =1;
    _nameFile.delegate = self;
    [self.nameView addSubview:_nameFile];
    
    
    
    
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLbl.frame)+10, WIDTH, 1)];
    linView.backgroundColor =[AppAppearance sharedAppearance].cellLineColor;
    [self.topView addSubview:linView];
    
    
    
    UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(linView.frame)+10+[MyAdapter aDapter:19]/2, [MyAdapter aDapter:80], [MyAdapter aDapter:21])];
    locationLbl.text = @"位置信息";
    locationLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    locationLbl.font = [MyAdapter fontADapter:16];
    [self.topView addSubview:locationLbl];
    
    _locationFile = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(locationLbl.frame)+10, CGRectGetMaxY(linView.frame)+10+[MyAdapter aDapter:19]/2, WIDTH - CGRectGetMaxX(locationLbl.frame)-10-10, [MyAdapter aDapter:21])];
    _locationFile.textAlignment = NSTextAlignmentRight;
    _locationFile.font =[MyAdapter fontADapter:16];
    _locationFile.placeholder = @"请输入位置信息";
    _locationFile.tag = 200;
    [self.topView addSubview:_locationFile];
    
    UIView *topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topView.frame.size.height-10, WIDTH, 10)];
    topBackView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    [self.topView addSubview:topBackView];
    
    
    
    
    
    
    
    
    
    //中部视图
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[XWDragCellCollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.topView.frame), WIDTH,(WIDTH-40)/3+20) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[QTRejectViewCell class] forCellWithReuseIdentifier:@"rejectViewMeCell"];
    [self.svMain addSubview:_collectionView];
    
    self.viewlin = [[UIView alloc]initWithFrame:CGRectMake(0, _collectionView.frame.size.height-1, WIDTH, 1)];
    self.viewlin.backgroundColor = [AppAppearance sharedAppearance].cellLineColor;
    [_collectionView addSubview:self.viewlin];
    
    //添加照片按钮
    self.btnAddPhone = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAddPhone.frame = CGRectMake(10, 10, (WIDTH-40)/3, (WIDTH-40)/3);
    [self.btnAddPhone setBackgroundImage:[UIImage imageNamed:@"icon_find_phone_tianjia2"] forState:UIControlStateNormal];
    [self.btnAddPhone addTarget:self action:@selector(BtnAddPhoneClick) forControlEvents:UIControlEventTouchUpInside];
    [_collectionView addSubview:self.btnAddPhone];
    
    
    
    //尾部视图
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_collectionView.frame)+10, WIDTH, [MyAdapter aDapter:100])];
    self.footerView.backgroundColor = [UIColor whiteColor];
    [self.svMain addSubview:self.footerView];
    
    _sgTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, WIDTH-20, [MyAdapter aDapter:100])];
    _sgTextView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    _sgTextView.font = [MyAdapter fontADapter:14];
    _sgTextView.scrollEnabled = YES;//是否可以拖动
    _sgTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    _sgTextView.delegate = self;
    _sgTextView.tag = 300;
    [self.footerView addSubview:_sgTextView];
    
    _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, CGRectGetWidth(_sgTextView.bounds), 30)];
    _placeLabel.text = @"在这里填写备注";
    _placeLabel.font = [MyAdapter fontADapter:14];
    _placeLabel.textColor = [AppAppearance sharedAppearance].title3TextColor
    ;
    [_sgTextView addSubview:_placeLabel];
    
    
    
    
//    //判断视图中是否有autoTableView
//    for(UIView *subVc in self.view.subviews){
//
//        if(![subVc isKindOfClass:[AutocompletionTableView class]]){
//
//
//            self.autoTab=[[AutocompletionTableView alloc]initWithTextField:self.nameFile inViewController:self withArr:_nameArray];
//            self.autoTab.tabDelegate=self;
//
//            __weak  PushServiceViewController *ws = self;
//            [self.autoTab setClickCell:^(id model) {
//                //        MedInfoModel *models=(MedInfoModel *)model;
//
//                //        ws.yaopinmingcheng=models.s_name;
//                //        ws.yaopinmingchengTxt.text = models.s_name;
//                // self.meicijiliang=models.meicijiliang;
//                // self.jiliangdanwei=models.jiliangdanwei;
//                // self.zhuyishixiang=models.zhuyishixiang;
//                //        [ws.tableView reloadDataWithAnimation];
//
//                NSLog(@"返回的结果是======%@",model);
//
//                ws.nameFile.text = model;
//
//
//            }];
//
//
//
//            [[UIApplication sharedApplication].keyWindow addSubview:self.autoTab];
//
//
//        }
//
//
//    }
//
    
    
    
    
    
    
    
    
    
    
}


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
    
    self.viewlin.frame = CGRectMake(0, CGRectGetMaxY(_collectionView.frame)-1, WIDTH, 1);
    
    self.footerView.frame = CGRectMake(0, CGRectGetMaxY(_collectionView.frame)+10, WIDTH, [MyAdapter aDapter:100]);
    
    self.svMain.contentSize = CGSizeMake(WIDTH,CGRectGetMaxY(self.footerView.frame));
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
    
    NSArray *photos = [[NSArray alloc]initWithObjects:aImage, nil];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        // [self uploadPhotos:photos];
    }];
}












#pragma mark 自动提示列表的处理
//-(void)autoCompletionTableView:(AutocompletionTableView *)completionView deleteString:(NSString *)sString {
//    
//    NSLog(@"sstring:%@",sString);
//    
//}
//-(void)autoCompletionTableView:(AutocompletionTableView *)completionView didSelectString:(id)sString {
//    NSLog(@"sstring:%@",sString);
//}








-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 1) {
        
        [textField resignFirstResponder];
        
        [ActionSheetStringPicker showPickerWithTitle:nil rows:self.nameArray initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            
            self.nameFile.text = self.nameArray[selectedIndex];
            
        } cancelBlock:^(ActionSheetStringPicker *picker) {
            
            
        } origin:self.view];
        
        
        
        return NO;
        
        
    }
    return YES;
    
    
    
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


-(void)shouldRightItem
{
    UIButton *btn =[self.class buttonWithImage:nil title:@"发布" target:self action:@selector(publishItemAction)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self addItemForLeft:NO withItem:item spaceWidth:0];
}


-(void)publishItemAction
{
    [_svc showMessage:@"发布信息"];
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

