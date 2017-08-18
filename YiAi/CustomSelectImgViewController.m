//
//  CustomSelectImgViewController.m
//  YiAi
//
//  Created by zlkj on 2017/6/23.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "CustomSelectImgViewController.h"

#import "QTRejectViewCell.h"
#import "TZImagePickerController.h"
#import "HXTagsView.h"
#import "XWDragCellCollectionView.h"

//十六进制颜色
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface CustomSelectImgViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,XWDragCellCollectionViewDataSource, XWDragCellCollectionViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate,UIActionSheetDelegate>{
    
}

@end

@implementation CustomSelectImgViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
//    [self resetLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.phonelist = [[NSMutableArray alloc]init];
    
    
    self.svMain = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, self.view.frame.size.height)];
    self.svMain.backgroundColor = [UIColor clearColor];
    self.svMain.showsVerticalScrollIndicator = NO;
    self.svMain.showsHorizontalScrollIndicator = NO;
    self.svMain.scrollEnabled = NO;
    self.svMain.delegate = self;
    [self.view addSubview:self.svMain];
    

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[XWDragCellCollectionView alloc]initWithFrame:CGRectMake(0,0, WIDTH,(WIDTH-40)/3+20) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[QTRejectViewCell class] forCellWithReuseIdentifier:@"rejectViewMeCell"];
    [self.svMain addSubview:_collectionView];
    
//    self.viewlin = [[UIView alloc]initWithFrame:CGRectMake(0, _collectionView.frame.size.height-10, WIDTH, 10)];
//    self.viewlin.backgroundColor = [AppAppearance sharedAppearance].cellLineColor;
//    [_collectionView addSubview:self.viewlin];
    
    //添加照片按钮
    self.btnAddPhone = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAddPhone.frame = CGRectMake(10, 10, (WIDTH-40)/3, (WIDTH-40)/3);
    [self.btnAddPhone setBackgroundImage:[UIImage imageNamed:@"icon_find_phone_tianjia2"] forState:UIControlStateNormal];
    [self.btnAddPhone addTarget:self action:@selector(BtnAddPhoneClick) forControlEvents:UIControlEventTouchUpInside];
    [_collectionView addSubview:self.btnAddPhone];
    
    
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
    
//    self.viewlin.frame = CGRectMake(0, CGRectGetMaxY(_collectionView.frame)-10, WIDTH, 10);
    
//    self.footerView.frame = CGRectMake(0, CGRectGetMaxY(_collectionView.frame)+10, WIDTH, [MyAdapter aDapter:100]);
    
    self.svMain.contentSize = CGSizeMake(WIDTH,CGRectGetMaxY(_collectionView.frame));
    
    
    CGSize customSize = CGSizeMake(WIDTH,CGRectGetMaxY(_collectionView.frame));
    
    if ([self.delegate respondsToSelector:@selector(refreshCustomFrame:)]) {
        
        [self.delegate refreshCustomFrame:customSize];
    }
    
    
}

-(void)showSheetView{
    
    
    
    
    if ([self.delegate respondsToSelector:@selector(selectPhpto)]) {
        
        [self.delegate selectPhpto];
    }
    
    
    
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择打开方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"相册", nil];
//    sheet.actionSheetStyle = UIActionSheetStyleDefault;
//    
//    [sheet showInView:self.view];
    
    
    
    
    
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


//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//
//
//        [self callCameraOrPhotoWithType:UIImagePickerControllerSourceTypeCamera];
//
//    }else if (buttonIndex ==1){
//
//        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:20 delegate:nil];
//        // 你可以通过block或者代理，来得到用户选择的照片.
//
//        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *asssets, BOOL isOk) {
//
//
//            [self.phonelist addObjectsFromArray:photos];
//            [self resetLayout];
//
//        }];
//
//        // 在这里设置imagePickerVc的外观
//        imagePickerVc.navigationBar.barTintColor = [UIColor blackColor];
//        imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
//        // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
//        // 设置是否可以选择视频/原图
//        // imagePickerVc.allowPickingVideo = NO;
//        // imagePickerVc.allowPickingOriginalPhoto = NO;
//        imagePickerVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//        [self presentViewController:imagePickerVc animated:YES completion:nil];
//
//
//
//
//
//    }else{
//
//        //取消
//    }
//}
//
//
//
//
//
//
//
//
//-(void)callCameraOrPhotoWithType:(UIImagePickerControllerSourceType)sourceType{
//    BOOL isCamera = YES;
//    if (sourceType == UIImagePickerControllerSourceTypeCamera) {//判断是否有相机
//        isCamera = [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera];
//    }
//    if (isCamera) {
//        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//        imagePicker.delegate = self;
//        imagePicker.allowsEditing = NO;//为NO，则不会出现系统的编辑界面
//        imagePicker.sourceType = sourceType;
//        [self presentViewController:imagePicker animated:YES completion:^(){
//            if ([[[UIDevice currentDevice] systemVersion]floatValue]>=7.0) {
//                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//            }
//        }];
//    } else {
//
//    }
//}
//#pragma UIImagePickerControllerDelegate
////相册或则相机选择上传的实现
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo{
//
//    NSArray *photos = [[NSArray alloc]initWithObjects:aImage, nil];
//
//    [picker dismissViewControllerAnimated:YES completion:^{
//        // [self uploadPhotos:photos];
//    }];
//}





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
