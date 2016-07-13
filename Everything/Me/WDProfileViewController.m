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

- (void)viewWillDisappear:(BOOL)animated
{
    NSDictionary *userDict = [_userModel yy_modelToJSONObject];
    [WDUserDefaults setObject:userDict forKey:kUserModel];
    [WDUserDefaults synchronize];
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
    else if (indexPath.row == 5)
    {
        WDAutographViewController *aVC = [WDAutographViewController new];
        aVC.autograph = ((WDCellModel*)[_modelArrays objectAtIndex:4]).desc;
        WeakSelf
        [aVC returnText:^(NSString *text) {
            WDCellModel *model = [weakSelf.modelArrays objectAtIndex:4];
            model.desc = text;
            [weakSelf.modelArrays replaceObjectAtIndex:1 withObject:model];
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
    [picker dismissViewControllerAnimated:YES completion:nil];;
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    // 上传图片
    [self uploadImage: image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadImage:(UIImage*)image
{
    return;
}

- (void)setupView
{
    self.title = @"个人资料";
    self.tableView.backgroundColor = WDGlobalBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.view.backgroundColor = WDGlobalBackgroundColor;
    [self.tableView registerClass:[WDCommonTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}


@end
