//
//  ContactUsVC.m
//  YunDi_Student
//
//  Created by Chen on 16/10/4.
//  Copyright © 2016年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#import "ContactUsVC.h"
#import "TPKeyboardAvoidingTableView.h"
#import "TweetSendImagesCell.h"
#import "TweetSendTextCell.h"
#import "ImagePickerManger.h"

#import "UIActionSheet+Common.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>



@interface ContactUsVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic ,strong) TPKeyboardAvoidingTableView *myTableView;

//参数
@property (nonatomic ,copy) NSString *textViewStr;

//保存返回的url 上传用到的
@property (nonatomic ,strong) NSMutableArray *resultUrlArray;

//展示的url
@property (nonatomic ,strong) NSMutableArray *showResultUrlArray;




@property (nonatomic ,strong) UIButton *setBtn;



@end

@implementation ContactUsVC

- (void)viewDidLoad{

    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"帮助与反馈"];
    
    //    添加myTableView
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[TweetSendTextCell class] forCellReuseIdentifier:kCCellIdentifier_TweetSendText];
        [tableView registerClass:[TweetSendImagesCell class] forCellReuseIdentifier:kCellIdentifier_TweetSendImages];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
    
    _myTableView.tableFooterView = [self customFooterView];
}

- (UIView *)customFooterView{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    
    
    UIButton *SetBtn = [[UIButton alloc]init];
    self.setBtn = SetBtn;
    //    loginBtn = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"登录" andFrame:CGRectMake(20, 20, SCREEN_WIDTH - 20*2, 45) target:self action:@selector(sendLogin)];
    SetBtn.frame = CGRectMake(PaddingLeftWidth, 40, SCREEN_WIDTH - PaddingLeftWidth*2, 45);
    
    [SetBtn addTarget: self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    SetBtn.layer.cornerRadius = 4;
    SetBtn.layer.masksToBounds = YES;
    [SetBtn setAdjustsImageWhenHighlighted:NO];
    [SetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [SetBtn setTitle:@"提交" forState:UIControlStateNormal];
    [SetBtn.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:20]];
    SetBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    SetBtn.enabled = NO;
    SetBtn.backgroundColor = [UIColor myColorWithHexString:@"#a9a9a9"];
    
    [footerV addSubview:SetBtn];
    
    return footerV;
}


#pragma mark Table M

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0) {
        TweetSendTextCell *cell = [tableView dequeueReusableCellWithIdentifier:kCCellIdentifier_TweetSendText forIndexPath:indexPath];
//        cell.tweetContentView.text = _curTweet.tweetContent;
//        [cell setLocationStr:self.locationData.displayLocaiton];
        cell.textValueChangedBlock = ^(NSString *valueStr){
            
            weakSelf.textViewStr = valueStr;
            [weakSelf isAllWrite];

        };


        return cell;
    }else {
        TweetSendImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TweetSendImages forIndexPath:indexPath];
        cell.curTweet = self.showResultUrlArray;
        cell.addPicturesBlock = ^(){
            
            [weakSelf.view endEditing:YES];
            [weakSelf showActionForPhoto];
        };
        cell.deleteTweetImageBlock = ^(int toDelete){
            [weakSelf.resultUrlArray removeObjectAtIndex:toDelete];
            [weakSelf.showResultUrlArray removeObjectAtIndex:toDelete];
            [weakSelf.myTableView reloadData];
        };
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 0;
    if (indexPath.row == 0) {
        cellHeight = [TweetSendTextCell cellHeight];
    }else if(indexPath.row == 1){
        cellHeight = [TweetSendImagesCell cellHeightWithObj:self.resultUrlArray.count];
    }
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)sendBtnClick:(UIButton *)btn{

    //判断
    
    
    NSString *img = @"";
    //拼接图片

    
    if (self.resultUrlArray.count > 0) {
        
        for (int i = 0; i < self.resultUrlArray.count ; i ++) {
            
            img = [img stringByAppendingString:[NSString stringWithFormat:@"%@,",self.resultUrlArray[i]]];
            
        }
        img = [NSString removeLastOneChar:img];
        
    }else{
        
        img = @"";
    }
    
    [btn startQueryAnimate];
    
//    [NetWork crateProblemWithcustId:self.userModel.custId contents:self.textViewStr img:img WaitAnimation:YES CompletionHandler:^(id object) {
//
//        [btn stopQueryAnimate];
//
//        BaseSecondModel *model = object;
//        if (model .statusCode == 800) {
//
//            [MBProgressHUD showHudTipStr:@"反馈/建议已提交"];
//
//            [self.navigationController popViewControllerAnimated:YES];
//
//        }else{
//
//            [MBProgressHUD showHudTipStr:model.returnObj.msg];
//
//        }
//
//    } errorHandler:^(id object) {
//
//       [btn stopQueryAnimate];
//
//    }];
//
    
}


#pragma mark UIActionSheet M

- (void)showActionForPhoto{
    @weakify(self);
    [[UIActionSheet bk_actionSheetCustomWithTitle:nil buttonTitles:@[@"拍照", @"从相册选择"] destructiveTitle:nil cancelTitle:@"取消" andDidDismissBlock:^(UIActionSheet *sheet, NSInteger index) {
        @strongify(self);
        
        
        if (index == 0) {
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                NSLog(@"该设备不支持拍照");
                return;
            }
            
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:^{
                
            }];
            
            
        }else if(index == 1){
            
            //相册
            [self goToPhotoLib];
            
        }
        

    }] showInView:self.view];
}


//***************

- (void)goToPhotoLib{
    
    
    [ImagePickerManger handelImagePickerWithLimitNum:1 withController:self WithContent:^(NSArray *assets, BOOL sendSucess) {
        
        NSLog(@"------------------------------图片选择回调");
        
        if (!sendSucess) {
            
            
            return ;
        }
        
        PHAsset *asset =  assets[0];
        
        
        NSString *fileName = [asset valueForKey:@"filename"];
        NSLog(@"imageName------- %@",fileName);
        
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.synchronous = YES;
        options.resizeMode = PHImageRequestOptionsResizeModeFast;
        // 是否要原图
        CGSize size ;//= original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);//原图
        //            size = CGSizeZero;//缩略图
        
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"result***********%@", result);
            NSLog(@"info********%@", info);
            
            
            
//            UIImage *scalImage = [self imageWithImageSimple:result scaledToSize:150];
            
            
            [self compressedImageFiles:result imageKB:800 imageBlock:^(UIImage *image) {
                
                //png-jpg
                NSData *data;
                if (UIImagePNGRepresentation(image) == nil) {
                    data = UIImageJPEGRepresentation(image, 0.0);
                    
                } else {
                    data = UIImagePNGRepresentation(image);
                }
                
                if (data.length == 0) {
                    
                    NSLog(@"未压缩成功   -------------  ");
                    
                    return ;
                    
                }
                
                NSLog(@"文件大小 ----  %lu k",(unsigned long)data.length/1024);
                
                
//                [NetWork uploadImgCommomWithUserId:self.userModel.custId filename:fileName image:data origin:nil WaitAnimation:YES CompletionHandler:^(id object) {
//
//                    NSDictionary *dic = object;
//                    NSDictionary *returnObj = [dic objectForKey:@"returnObj"];
//                    if ([[returnObj objectForKey:@"status"] intValue] == 1) {
//
//                        NSLog(@"%@",returnObj);
//                        [MBProgressHUD showHudTipStr:@"保存成功"];
//
//                        [self.resultUrlArray addObject:[returnObj objectForKey:@"img"]];
//                        [self.showResultUrlArray addObject:[returnObj objectForKey:@"imgFull"]];
//                        [self.myTableView reloadData];
//
//                    }else{
//
//                        [MBProgressHUD showHudTipStr:@"保存失败"];
//
//                        NSLog(@" %@ ------- %@ ",[returnObj objectForKey:@"status"] , [returnObj objectForKey:@"msg"]);
//
//                    }
//
//                } errorHandler:^(id object) {
//
//
//                    [MBProgressHUD showHudTipStr:@"网络连接失败"];
//
//                }];
//
            }];
          
            
            
        }];
        
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary
                                                                                               *)info{
    

        UIImage *theImage;
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
        //当选择的类型是图片
        if([type isEqualToString:@"public.image"]){
            //先把图片转成NSData
            theImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            
            
        }
        
        [self compressedImageFiles:theImage imageKB:800 imageBlock:^(UIImage *image) {
            
            NSString *imageName;
            
            //png-jpg
            NSData *data;
            if (UIImagePNGRepresentation(image) == nil) {
                data = UIImageJPEGRepresentation(image, 0.0);
                imageName = @"headImage.jpg";
            } else {
                data = UIImagePNGRepresentation(image);
                imageName = @"headImage.png";
            }
            
            
            if (data.length == 0) {
                
                NSLog(@"未压缩成功   -------------  ");
                
                return ;
            }
            
            //保存本地
            NSArray  * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString * filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];//[NSString stringWithFormat:@"%.f", [[NSDate date]timeIntervalSince1970]]];   // 保存文件的名称
            [data writeToFile:filePath atomically:NO];
            //上传
            
            NSData *uploadData = [NSData dataWithContentsOfFile:filePath];
            
            //删除数据
            NSFileManager* fileManager=[NSFileManager defaultManager];
            [fileManager removeItemAtPath:filePath error:nil];
            
            NSLog(@"文件大小 ----  %lu k",(unsigned long)data.length/1024);
            
//            [NetWork uploadImgCommomWithUserId:self.userModel.custId filename:imageName image:uploadData origin:nil WaitAnimation:YES CompletionHandler:^(id object) {
//
//                NSDictionary *dic = object;
//                NSDictionary *returnObj = [dic objectForKey:@"returnObj"];
//                if ([[returnObj objectForKey:@"status"] intValue] == 1) {
//
//                    NSLog(@"%@",returnObj);
//                    [MBProgressHUD showHudTipStr:@"保存成功"];
//
//
//                    [self.resultUrlArray addObject:[returnObj objectForKey:@"img"]];
//                    [self.showResultUrlArray addObject:[returnObj objectForKey:@"imgFull"]];
//
//                    [self.myTableView reloadData];
//
//
//                }else{
//
//                    [MBProgressHUD showHudTipStr:@"保存失败"];
//
//                    NSLog(@" %@ ------- %@ ",[returnObj objectForKey:@"status"] , [returnObj objectForKey:@"msg"]);
//
//                }
//
//                //删除图片
//
//
//
//            } errorHandler:^(id object) {
//
//
//                [MBProgressHUD showHudTipStr:@"网络连接失败"];
//
//            }];
//
//
//
        }]; //[self imageWithImageSimple:theImage scaledToSize:150];
    
    
   
}


//判断 填写完整
- (void)isAllWrite{
    
    if (self.textViewStr.length > 0) {
        
        self.setBtn.enabled = YES;
        [self.setBtn setBackgroundColor:[UIColor myColorWithHexString:@"#d9302f"]];
        
    }else{
        
        self.setBtn.enabled = NO;
        [self.setBtn setBackgroundColor:[UIColor myColorWithHexString:@"#a9a9a9"]];
        
    }
    
}

- (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGFloat)newSizeW{
    CGSize newSize;
    newSize.height=image.size.height*(newSizeW/image.size.width);
    newSize.width = newSizeW;
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
    
}

/**
 *  压缩图片
 *
 *  @param image       需要压缩的图片
 *  @param fImageBytes 希望压缩后的大小(以KB为单位)
 *
 *  @return 压缩后的图片
 */
- (void)compressedImageFiles:(UIImage *)image
                     imageKB:(CGFloat)fImageKBytes
                  imageBlock:(void(^)(UIImage *image))block {
    
    __block UIImage *imageCope = image;
    CGFloat fImageBytes = fImageKBytes * 1024;//需要压缩的字节Byte
    
    __block NSData *uploadImageData = nil;
    
    uploadImageData = UIImagePNGRepresentation(imageCope);
    NSLog(@"图片压前缩成 %fKB",uploadImageData.length/1024.0);
    CGSize size = imageCope.size;
    CGFloat imageWidth = size.width;
    CGFloat imageHeight = size.height;
    
    if (uploadImageData.length > fImageBytes && fImageBytes >0) {
        
        dispatch_async(dispatch_queue_create("CompressedImage", DISPATCH_QUEUE_SERIAL), ^{
            
            /* 宽高的比例 **/
            CGFloat ratioOfWH = imageWidth/imageHeight;
            /* 压缩率 **/
            CGFloat compressionRatio = fImageBytes/uploadImageData.length;
            /* 宽度或者高度的压缩率 **/
            CGFloat widthOrHeightCompressionRatio = sqrt(compressionRatio);
            
            CGFloat dWidth   = imageWidth *widthOrHeightCompressionRatio;
            CGFloat dHeight  = imageHeight*widthOrHeightCompressionRatio;
            if (ratioOfWH >0) { /* 宽 > 高,说明宽度的压缩相对来说更大些 **/
                dHeight = dWidth/ratioOfWH;
            }else {
                dWidth  = dHeight*ratioOfWH;
            }
            
            imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
            uploadImageData = UIImagePNGRepresentation(imageCope);
            
            NSLog(@"当前的图片已经压缩成 %fKB",uploadImageData.length/1024.0);
            //微调
            NSInteger compressCount = 0;
            /* 控制在 1M 以内**/
            while (fabs(uploadImageData.length - fImageBytes) > 1024) {
                /* 再次压缩的比例**/
                CGFloat nextCompressionRatio = 0.9;
                
                if (uploadImageData.length > fImageBytes) {
                    dWidth = dWidth*nextCompressionRatio;
                    dHeight= dHeight*nextCompressionRatio;
                }else {
                    dWidth = dWidth/nextCompressionRatio;
                    dHeight= dHeight/nextCompressionRatio;
                }
                
                imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
                uploadImageData = UIImagePNGRepresentation(imageCope);
                
                /*防止进入死循环**/
                compressCount ++;
                if (compressCount == 10) {
                    break;
                }
                
            }
            
            NSLog(@"图片已经压缩成 %fKB",uploadImageData.length/1024.0);
            imageCope = [[UIImage alloc] initWithData:uploadImageData];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                block(imageCope);
            });
        });
    }
    else
    {
        block(imageCope);
    }
}

/* 根据 dWidth dHeight 返回一个新的image**/
- (UIImage *)drawWithWithImage:(UIImage *)imageCope width:(NSInteger)dWidth height:(NSInteger)dHeight{
    
    UIGraphicsBeginImageContext(CGSizeMake(dWidth, dHeight));
    [imageCope drawInRect:CGRectMake(0, 0, dWidth, dHeight)];
    imageCope = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCope;
    
}


- (NSMutableArray *)showResultUrlArray{

    if (!_showResultUrlArray) {
        
        _showResultUrlArray = [NSMutableArray array];
        
    }
    return _showResultUrlArray;
}

- (NSMutableArray *)resultUrlArray{

    if (!_resultUrlArray) {
        
        _resultUrlArray = [NSMutableArray array];
    }
    return _resultUrlArray;
}
    
@end
