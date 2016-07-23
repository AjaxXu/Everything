//
//  WDProfileViewController.m
//  Everything
//
//  Created by Louis on 16/7/11.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDProfileViewController.h"
#import "WDCommonTableViewCell.h"
#import "WDUserModel.h"
#import "WDCellModel.h"
#import "WDEditNickNameViewController.h"
#import "WDAutographViewController.h"
#import "ChooseCityViewController.h"

static NSString *const kCellIdentifier = @"ProfileCell";

@interface WDProfileViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *modelArrays;
@property (nonatomic, strong) NSMutableDictionary *cellHeights;

@end

@implementation WDProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    [self loadData];
}

- (void)loadData
{
    // 头像模型
    WDCellModel *headImageModel = [WDCellModel new];
    headImageModel.title = @"头像";
    headImageModel.rightImageName = _userModel.head_image;
    headImageModel.rightImageHeight = 60;
    headImageModel.indicatorType = WDTableViewCellIndicatorTypeRightArrow;
    headImageModel.canSelect = YES;
    
    //  name
    WDCellModel *nameModel = [WDCellModel new];
    nameModel.title = @"名字";
    nameModel.desc = _userModel.nickname;
    nameModel.indicatorType = WDTableViewCellIndicatorTypeRightArrow;
    nameModel.canSelect = YES;
    
    // phone
    WDCellModel *phoneModel = [WDCellModel new];
    phoneModel.title = @"手机";
    phoneModel.desc = _userModel.phone_number;
    phoneModel.canSelect = NO;
    
    // gender
    WDCellModel *genderModel = [WDCellModel new];
    genderModel.title = @"性别";
    genderModel.desc = _userModel.gender == 0? @"未设置" : _userModel.gender == 1? @"男": @"女";
    genderModel.indicatorType = WDTableViewCellIndicatorTypeRightArrow;
    genderModel.canSelect = YES;
    
    // address
    WDCellModel *addressModel = [WDCellModel new];
    addressModel.title = @"地区";
    addressModel.desc = _userModel.address;
    addressModel.indicatorType = WDTableViewCellIndicatorTypeRightArrow;
    addressModel.canSelect = YES;
    
    // 签名
    WDCellModel *autographModel = [WDCellModel new];
    autographModel.title = @"个性签名";
    autographModel.desc = _userModel.autograph;
    autographModel.indicatorType = WDTableViewCellIndicatorTypeRightArrow;
    autographModel.canSelect = YES;
    
    _modelArrays = [NSMutableArray arrayWithObjects:headImageModel, nameModel, phoneModel, genderModel, addressModel, autographModel, nil];
    
    _cellHeights = [NSMutableDictionary new];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_modelArrays count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDCommonTableViewCell *normalCell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    normalCell.model = [_modelArrays objectAtIndex:indexPath.row];
    normalCell.userInteractionEnabled = normalCell.model.canSelect;
    [_cellHeights setHeight:[normalCell fixedHeight] withIndexPath:indexPath];
    return normalCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UIActionSheet *sheet;
        // 判断是否支持相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍 照" otherButtonTitles:@"从相册选择", nil];
        } else {
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
        }
        sheet.tag = 101;
        [sheet showInView:self.view];
    }
    else if (indexPath.row == 1)
    {
        WDEditNickNameViewController *enmVC = [WDEditNickNameViewController new];
        enmVC.nickname = ((WDCellModel*)[_modelArrays objectAtIndex:1]).desc;
        WeakSelf
        [enmVC returnText:^(NSString *text) {
            WDCellModel *model = [weakSelf.modelArrays objectAtIndex:1];
            model.desc = text;
            weakSelf.userModel.nickname = text;
            [weakSelf.modelArrays replaceObjectAtIndex:1 withObject:model];
            [weakSelf.tableView reloadData];
        }];
        [self.navigationController pushViewController:enmVC animated:YES];
    }
    else if (indexPath.row == 3)
    {
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc]
                                       initWithTitle:nil
                                       delegate:self
                                       cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:nil
                                       otherButtonTitles:@"男", @"女",nil];
        
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        actionSheet.tag = 103;
        [actionSheet showInView:self.view];
    }
    else if (indexPath.row == 4)
    {
        ChooseCityViewController *ccVC = [ChooseCityViewController new];
        WeakSelf
        ccVC.selectCity = ^(ChooseCityModel *cityModel){
            WDCellModel *model = [weakSelf.modelArrays objectAtIndex:4];
            model.desc = cityModel.name;
            weakSelf.userModel.address = cityModel.name;
            [weakSelf.modelArrays replaceObjectAtIndex:4 withObject:model];
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:ccVC animated:YES];
    }
    else if (indexPath.row == 5)
    {
        WDAutographViewController *aVC = [WDAutographViewController new];
        aVC.autograph = ((WDCellModel*)[_modelArrays objectAtIndex:5]).desc;
        WeakSelf
        [aVC returnText:^(NSString *text) {
            WDCellModel *model = [weakSelf.modelArrays objectAtIndex:5];
            model.desc = text;
            weakSelf.userModel.autograph = text;
            [weakSelf.modelArrays replaceObjectAtIndex:5 withObject:model];
            [weakSelf.tableView reloadData];
        }];
        [self.navigationController pushViewController:aVC animated:YES];
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:indexPath forKey:@"indexPath"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,10, 0, 20)];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsMake(0,10, 0, 20)];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_cellHeights getHeightWithIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 选择头像行
    if (actionSheet.tag == 101) {
        NSUInteger sourceType = 0;
        // 判断支持相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                default:
                    return;
            }
        }else{
            if (buttonIndex == 0) {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }else{
                return;
            }
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{
        }];
    }
    // 性别 行
    else if(actionSheet.tag == 103)
    {
        if (buttonIndex == 2 || _userModel.gender == buttonIndex + 1) {
            return;
        }
        _userModel.gender = buttonIndex + 1;
        WDCellModel *model = [_modelArrays objectAtIndex:3];
        model.desc = _userModel.gender == 1? @"男": @"女";
        [_modelArrays replaceObjectAtIndex:3 withObject:model];
        [self.tableView reloadData];
    }
}

#pragma image picker controller delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    // 上传图片
    // 压缩图片
    NSData *fileData = UIImageJPEGRepresentation(image, 0.5);
    //保存到Documents
    NSString *imageDir = WDSearchPathCaches
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[WDUserDefaults objectForKey:kUserID]];
    
    NSString *imageFile = [imageDir stringByAppendingPathComponent: fileName];
    //    NSLog(@"%@",imageFile);
    [SVProgressHUD show];
    [WDNetOperation postDataWithURL:[NSString stringWithFormat:@"/users/%@/head_image", [WDUserDefaults objectForKey:kUserID]] parameters:nil fileData:fileData name:@"head_image" fileName:fileName mimeType:@"image/jpeg" progress:^(NSProgress *uploadProgress) {
        //上传进度
        // @property int64_t totalUnitCount;    需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        //
        // 给Progress添加监听 KVO
        //        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        // 回到主队列刷新UI,用户自定义的进度条
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat progress = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
            [SVProgressHUD showProgress:progress];
        });
    } success:^(id responseObject) {
        
        [SVProgressHUD showSuccessWithStatus:@"上传头像成功" duration:1.5];
        [fileData writeToFile:imageFile atomically:YES];
        //保存至相册
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            WDCellModel *model = [_modelArrays objectAtIndex:0];
            _userModel.head_image = responseObject[@"content"][@"head_image"];
            model.rightImageName = _userModel.head_image;
            [_modelArrays replaceObjectAtIndex:0 withObject:model];
            [self.tableView reloadData];
        });
    } failure: ^(NSError *error){
        [SVProgressHUD showErrorWithStatus:@"上传头像失败" duration:1.5];
        NSLog(@"%@", error);
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)setupView
{
    self.title = @"个人资料";
    self.tableView.backgroundColor = WDGlobalBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.view.backgroundColor = WDGlobalBackgroundColor;
    [self.tableView registerClass:[WDCommonTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 44);
    button.backgroundColor = [UIColor clearColor];
    //设置button正常状态下的图片
    [button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
    button.imageEdgeInsets = UIEdgeInsetsMake(3, -7, 3, 44);
    [button setTitle:@"我" forState:UIControlStateNormal];
    //button标题的偏移量，这个偏移量是相对于图片的
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0);
    //设置button正常状态下的标题颜色
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget: self action: @selector(doBack) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)doBack
{
    NSDictionary *userDict = [_userModel yy_modelToJSONObject];
    [WDUserDefaults setObject:userDict forKey:kUserModel];
    [WDUserDefaults synchronize];
    NSString *tableID = [WDUserDefaults objectForKey:kUserID];
    [WDNetOperation postRequestWithURL:[NSString stringWithFormat:@"/users/%@", tableID] parameters:userDict success:nil failure:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 图片保存完毕的回调
- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextIn {
    NSLog(@"照片保存成功");
}

@end
